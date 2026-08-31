# Lore (VCS)

Epic Games' VCS, MIT licensed, pre-1.0. No package manager support yet - ships as
plain release binaries (`lore` CLI, `loreserver`). Unlike git, `loreserver` must be
running even for fully local single-user use - there is no server-less mode.

https://github.com/EpicGames/lore

## Install / Update

Grab the latest release tag and the matching Linux x86_64 assets:

```sh
curl -s https://api.github.com/repos/EpicGames/lore/releases/latest | python3 -c "
import json,sys
data = json.load(sys.stdin)
print(data['tag_name'])
for a in data['assets']:
    if 'x86_64-unknown-linux-gnu' in a['name'] and 'debug' not in a['name'] and 'liblore' not in a['name']:
        print(a['name'], a['digest'], a['browser_download_url'])
"
```

```sh
TMPDIR=$(mktemp -d)
cd "$TMPDIR"
curl -sL -o lore.tar.gz       <lore-*-x86_64-unknown-linux-gnu.tar.gz download URL>
curl -sL -o loreserver.tar.gz <loreserver-*-x86_64-unknown-linux-gnu.tar.gz download URL>
sha256sum lore.tar.gz loreserver.tar.gz   # compare against the `digest` field above

tar xzf lore.tar.gz
tar xzf loreserver.tar.gz
chmod +x ./lore ./loreserver

# back up whatever's currently installed first if upgrading in place
mv ./lore ~/.local/bin/lore
mv ./loreserver ~/.local/bin/loreserver
cd - && rm -rf "$TMPDIR"
```

```sh
lore --version
loreserver --version
```

## Auto-starting `loreserver` as a systemd user service

For a server host that should keep `loreserver` running across reboots without a
logged-in session:

```sh
mkdir -p ~/.config/systemd/user
cat > ~/.config/systemd/user/loreserver.service <<'EOF'
[Unit]
Description=Lore VCS server
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=%h/.local/bin/loreserver
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable --now loreserver.service
systemctl --user status loreserver.service
```

Lingering is required so the service starts at boot even with nobody logged in
(without it, user services only run while that user has an active session):

```sh
sudo loginctl enable-linger $USER
```

Verify it's listening and check logs:

```sh
ss -tlnp | grep -E '41337|41339'   # default gRPC / HTTP ports
journalctl --user -u loreserver -f
```

If it only shows up on `127.0.0.1` and needs to be reachable from other machines on
the LAN, a `--config <DIR>` TOML override (see `loreserver --help`) is needed to
change the bind address - not yet worked out which key controls this.

## Persistent storage path (important - do this before relying on a server)

**`loreserver`'s built-in default storage location is `/tmp/lore-server`** when no
`--config` override is given (confirmed empirically via `/proc/<pid>/fd/` on a running
instance - the printed config dump is unhelpfully blank, `path: ""`, for both
`immutable_store.local` and `mutable_store.local`). `/tmp` does not survive a reboot,
so any repository living only on a `loreserver` started without this override is one
reboot away from being wiped - this bit us directly: a project's full push-able
history turned out to depend on a local-dev-machine `loreserver` that had been
silently resetting on every reboot for months, with only a bounded/evicting client-side
cache (see the client's own `.lore/config.toml` `[store]` section) as a fallback -
GONE was the operative word once both sides aged past each other.

Fix by pointing `loreserver` at a real directory via a `--config <DIR>` TOML override
(the running server logs which environment it's using, e.g. `Using environment: local`
- that's the `<environment>.toml`/`local.toml` file that applies):

**Important gotcha, confirmed by testing**: `path` here is a *base* directory - the
server appends its own `immutable`/`mutable` subdirectory name inside it automatically.
Do NOT include `/immutable` or `/mutable` yourself in the path value, or you get a
doubled, redundant nesting (`<path>/immutable/immutable/...`) - confirmed via
`ls -la /proc/<pid>/fd/` showing the actual doubled paths before this was caught and
fixed. Point both settings at the *same* shared base path:

```sh
mkdir -p ~/.config/lore-server-config
cat > ~/.config/lore-server-config/local.toml <<'EOF'
[immutable_store.local]
path = "<persistent base path>"

[mutable_store.local]
path = "<persistent base path>"
EOF
```

**Generic default recorded for future setups**: `~/.local/share/loreserver-data`
(a normal XDG-ish user data location) - reasonable when nothing more specific applies.

**Actual path used on both `limser` (home server) and the local dev machine**:
`$HOME/limslore` - a deliberate, memorable, non-default choice, kept identical on
both sides for this project specifically. Don't "correct" this back to the generic
default; it's intentional. Server creates `$HOME/limslore/immutable/` and
`$HOME/limslore/mutable/` itself underneath it.

Wire the path into the service and restart:

```sh
mkdir -p ~/.config/systemd/user/loreserver.service.d
cat > ~/.config/systemd/user/loreserver.service.d/persistent-storage.conf <<'EOF'
[Service]
ExecStart=
ExecStart=%h/.local/bin/loreserver --config %h/.config/lore-server-config
EOF

systemctl --user daemon-reload
systemctl --user restart loreserver.service
```

(The empty `ExecStart=` line is required - systemd drop-ins append to `ExecStart` by
default, so without clearing it first the old and new command both try to run.)

Verify the new path actually took effect:

```sh
PID=$(pgrep -f loreserver | head -1)
ls -la /proc/$PID/fd/ 2>&1 | grep -iE 'immutable|mutable' | head -5
```

## KNOWN BUG: pushing an existing, already-historied repo to a new remote fails

**Symptom**: `lore push <branch>` (with or without `--force`) against a brand-new/
empty remote repository fails every time with:

```
[Error] pushing branch to remote: code: 'Internal error', message: "failed to load current latest state: Not found"
  at lore-transport/src/error.rs:6:1
  at lore-revision/src/branch/push.rs:892 - pushing branch to remote
```

Server-side (`RUST_LOG=debug` on `loreserver`) traces to `lore-revision/src/state.rs:597`,
a `NotFound` while the server's `BranchPush` handler tries to load "current latest state."

**Confirmed NOT the cause**: version mismatch (identical failure on 0.8.5 and 0.8.6),
network/firewall (gRPC+QUIC both reachable, confirmed via `--debug`), repository/branch
ID mismatch (confirmed matching on both sides), `--force` (routes around nothing here).

**Root cause (confirmed by reading actual Lore source, MIT-licensed, github.com/EpicGames/lore)**:
in `lore-revision/src/history.rs`, `find_branch_point()` walks local history to build the
push list. If a local existence check fails for some revision (clients only lazily cache
data they've actively used - see the eviction note above), it falls back to querying the
remote - but zeroes `current_right` *unconditionally, before checking whether that remote
query even succeeded*:

```rust
if !local_right {
    current_right = Hash::default();   // zeroed regardless of the fallback result
    if let Some(Ok(right_response)) = right_response {
        current_right = right_response.next_revision;
    }
}
```

Against a brand-new remote (nothing to answer with), this silently truncates the walk and
misreports "branch root found at zero" - producing a single-leap 0-to-HEAD push attempt
instead of the normal (working) revision-by-revision walk. **Confirmed present, byte-identical,
in the newest release tag (v0.9.0) too** - upgrading does not fix it. Related (but not
identical-symptom) open issue: [EpicGames/lore#140](https://github.com/EpicGames/lore/issues/140)
("switching a workspace to a different server after repo creation").

**Confirmed working, for comparison**: a *freshly created* local repo (`lore repository
create` run directly against the target remote, no pre-existing local history) pushes
fine, including multiple sequential commits - one revision at a time, no leap. The bug is
specific to repointing an *existing, already-historied* local repo at a new remote.

### Two workarounds tried and ruled out (don't repeat these)

Both tested via SSH/SFTP-style direct file access to the server's on-disk store, in an
isolated throwaway `loreserver` instance (not production data) - a natural-seeming
"minimal path of resistance" idea, but neither works:

1. **Copying the client's `immutable/` store into the server's store directly** - fails
   immediately, no bug involved: **client and server use genuinely different on-disk
   formats** for the same conceptual "local immutable store." Client: `index/<prefix>/index_XX`
   files. Server: `index/<prefix>/pack/N` files (nested `pack/` subdir). Confirmed by
   diffing real directory trees on both sides after real commits on each. Not portable.

2. **Copying the client's `mutable/` store into the server's store directly** - the file
   *naming convention* looks identical between client and server (`index/<prefix>/index_XX`
   on both sides, unlike immutable), which is promising-looking but **does not work**:
   tested by (a) registering an empty repo shell on a clean throwaway server via
   `lore repository create --id <matching-id> <url>`, (b) stopping the server, (c) overlaying
   the client's `.lore/mutable/*` on top, (d) restarting. Result: `lore status` explicitly
   reports `"Remote branch does not exist"` - the overlay is not recognized at all. These
   are almost certainly independent LSM-tree-style embedded stores with their own
   manifest/compaction state that a cold file copy doesn't satisfy; there's no supported
   "import"/"merge" operation for this.

**Bottom line**: there is currently no way to migrate an existing repo's full history onto
a new remote. The only reliable path is to start fresh: create a brand-new local `.lore/`
directly against the new remote (matching the confirmed-working pattern above) and commit
current state as the new baseline. Old local history remains readable locally (point
`--repository` at a backup copy of the old `.lore/`) but can't be pushed anywhere.

### Third thing tried and ruled out: server-to-server replication

`loreserver` does have a real replication mechanism (`lore-server/src/store/replica.rs`,
`lore-server/src/topology/`, a `[topology]` config block with `provider = "fixed"` etc.,
peers talking over `[server.grpc_internal]`/`[server.quic_internal]`). Confirmed via source
that it does NOT touch `find_branch_point`/`BranchPush` at all - it's a raw content-addressed
fragment write between trusted peers. **But it's HA/edge-cache/read-replica infrastructure
for one logical deployment that all nodes are configured into from the start** - there is no
RPC or CLI operation to "pull/import an independent repo's entire history from a server that
was never part of this topology." Not applicable to migrating a standalone repo's history.
Don't spend time on this path for that use case.

## Recovering from local content loss (if it ever happens again)

Hard-won findings from actually going through this. Context: a project's local `.lore/`
content store ended up with **every single tracked file's content gone** (0/1026 recoverable
in a full exhaustive check) after (a) the local `loreserver` had been silently resetting on
every reboot for months (see the persistent-storage section above - this was before that fix
existed) and (b) an interrupted `lore sync` to an old revision deleted files without ever
restoring them (see next subsection).

### `lore repository dump` - enumerate the full tracked tree without touching content

```sh
lore repository dump --revision <revision-hash> [--path <subpath>] [--max-depth N]
```

Prints every tracked path plus its exact content address (`<hash>-<context>`), purely from
the tree/metadata graph - doesn't read actual file content, so it works even when content is
missing. This is the only way found to get a full file listing when `lore diff`/`lore status`
themselves fail (both need to read content, even just to enumerate "this is an add").

### `lore repository verify fragment <hash> --context <context>` is NOT a reliable content-availability check

Despite the name, this checks something narrower/different than "can this file's content be
materialized" - in testing, files that `lore file reset` could successfully pre-allocate
(matching size) still reported "Fragment not found" via `verify fragment`, and vice versa
wasn't cleanly confirmed either. Don't use it to plan a recovery; it gave misleading signal.
The only reliable way to know if a file's content is actually available is to attempt an
actual single-file `lore file reset`/`sync` and check the real resulting bytes on disk.

### Batch `lore file reset`/`sync` is all-or-nothing per invocation - and its "progress" is misleading

`lore file reset --revision <rev> <path...>` (and plain `lore sync <rev>`) pre-allocate a
`<name>.~loretemp` temp file (correct final size, but **zero-filled placeholder bytes**, not
real content) for every target in the batch, THEN write real content into each one
sequentially, and **abort the entire batch at the first content-read failure** - before any
real bytes get written to anything, even files later in the batch whose content genuinely IS
available. The printed `"Reset N (X directories, Y files)"` message describes what it
*intended*, not what it *wrote* - it's not a progress/success count. Confirmed by inspecting
`.~loretemp` files after several "successful-looking" batch attempts: 100% zero bytes despite
correct file sizes.

**The only way to actually recover real content this way is one file per invocation** (loop
over the full file list from `repository dump`, running `lore file reset --revision <rev>
<single-path>` separately for each, checking the real resulting file - not the temp file, not
the command's stdout - for genuine non-empty content). Slow (~1000 invocations for a
mid-sized project) but each invocation is a clean, isolated success/fail with no misleading
partial-credit behavior.

### Shell gotcha when scripting many `lore` calls in a loop

In at least one environment, invoking `lore` inside a `while read ... done < file` loop
(stdin redirected from a data file for the whole loop) intermittently produced spurious
`command not found: lore` errors even though `lore` resolves fine standalone - not caused by
`lore` itself. Fixed by writing the loop to an actual `.sh` script file and running it via
`bash script.sh` (not an inline multi-line command), using the lore binary's full path
(`$HOME/.local/bin/lore`), and redirecting `lore`'s own stdin from `/dev/null` inside the
loop. Cause not fully root-caused; the workaround was reliable.

## Cloning onto another machine

```sh
# install just the CLI (no server needed on a machine that's only cloning)
curl -sL -o lore.tar.gz https://github.com/EpicGames/lore/releases/download/v0.8.6/lore-v0.8.6-x86_64-unknown-linux-gnu.tar.gz
tar xzf lore.tar.gz && chmod +x ./lore && mv ./lore ~/.local/bin/lore

lore clone lore://<server-ip>:41337/<repo-name> <dest-path>
cd <dest-path> && lore history   # sanity check
```

## Firewall (ufw)

Once `loreserver` is bound to the LAN interface, open its two default ports, scoped
to the LAN subnet rather than the world (adjust the subnet to match yours):

```sh
sudo ufw allow from 192.168.0.0/24 to any port 41337 proto tcp comment 'loreserver gRPC'
sudo ufw allow from 192.168.0.0/24 to any port 41339 proto tcp comment 'loreserver HTTP'
sudo ufw allow from 192.168.0.0/24 to any port 41337 proto udp comment 'loreserver QUIC'

sudo ufw reload
sudo ufw status verbose
```

**Also open 41337 over UDP.** `lore` multiplexes two protocols on the same port
number: gRPC/TCP for control-plane calls (`EnvironmentGet`, repo lookups, etc.) and
**QUIC/UDP for the actual storage session** used by `lore push`/`sync`/`clone`. TCP-only
on 41337 lets control-plane calls through but the push/sync data transfer will hang
and fail with a QUIC handshake timeout (confirmed via `lore --debug push`) - both
protocols need to be allowed on that same port.

If `ufw` isn't enabled yet on that host, check first (`sudo ufw status`) and make
sure SSH is allowed before enabling it, or you'll lock yourself out:

```sh
sudo ufw allow 22/tcp   # or whatever port sshd actually listens on there
sudo ufw enable
```

## Debug logging

The server's own config dump (visible at startup in `journalctl --user -u loreserver`)
has no explicit log-level field - just log format/output destination. Internal errors
(e.g. a failed gRPC call returning `Internal error` to the client) may not get logged
at all at the default level. Bump verbosity via the standard Rust `RUST_LOG` env var
through a systemd drop-in, rather than editing the main unit file:

```sh
mkdir -p ~/.config/systemd/user/loreserver.service.d
cat > ~/.config/systemd/user/loreserver.service.d/debug-logging.conf <<'EOF'
[Service]
Environment=RUST_LOG=debug
EOF

systemctl --user daemon-reload
systemctl --user restart loreserver.service
```

Reproduce the failing operation, then check logs:

```sh
journalctl --user -u loreserver -n 50 --no-pager
```

If `debug` still shows nothing relevant, try `RUST_LOG=trace`. If even that stays
silent for an error the client clearly received, the error path in `loreserver`
likely just doesn't log before returning the gRPC status - a real observability gap
in the server itself, not a local config issue.
