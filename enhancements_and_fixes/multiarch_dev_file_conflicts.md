# Multi-Arch dev package file conflicts (i386 + amd64)

Hit while building Wine 11.x with a 32-bit Unix side (`gcc -m32`), which needs
`:i386` `-dev` packages co-installed alongside `:amd64`.

## Issue

```
dpkg: error processing archive .../libpcap0.8-dev_1.10.6-1ubuntu1_amd64.deb (--unpack):
 trying to overwrite shared '/usr/bin/pcap-config', which is different from
 other instances of package libpcap0.8-dev:amd64
```

Some packages are marked `Multi-Arch: same` but ship a file whose content
**differs per architecture** at an **arch-neutral path** (`/usr/bin/...`,
`/usr/share/man/...`). `MA: same` requires shared files to be byte-identical,
so the two instances cannot co-install. This is an Ubuntu packaging bug.

Known affected on this system:

| Package | Conflicting file | Why they differ |
|---|---|---|
| `libpcap0.8-dev` | `/usr/bin/pcap-config` | amd64 links `-libverbs`, i386 does not |
| `libxtst-dev` | `/usr/share/man/man3/XTestQueryExtension.3.gz` | different docbook-xsl build snapshot |

Most `MA: same` packages never collide because their files live at
arch-specific paths (`/usr/lib/<triplet>/...`). Only arch-neutral paths break.

## NOT affected, despite appearances: `samba-dev:i386`

`samba-dev` is `Multi-Arch: same`, installs cleanly alongside `:amd64`, and
**removes nothing** -- verified in `/var/log/apt/history.log`, where the install
transaction has no `Remove:` line at all. Every non-header file it ships is
under `usr/lib/i386-linux-gnu/`; the only arch-neutral files are
`/usr/include/samba-4.0/*` headers, which are identical across arches.

It is also **required** for a 32-bit Wine build -- it provides
`/usr/lib/i386-linux-gnu/pkgconfig/netapi.pc`. Removing it causes
`configure: libnetapi not found, Samba NetAPI won't be supported`.

### Verifying a scary claim about apt

If any tool, agent, or forum post says an i386 `-dev` package will remove your
desktop, check it directly instead of trusting or fearing it. This prints the
complete plan and changes nothing:

```sh
sudo apt install --dry-run <package>:i386     # -s also works
sudo apt purge  --dry-run "<pattern>"
```

The failure mode is real for *some* i386 operations -- a package that is not
multiarch-capable can force apt to choose between architectures -- but it does
not apply to `Multi-Arch: same` `-dev` packages, which co-install by design.
After the fact, `/var/log/apt/history.log` records exactly what each
transaction installed and removed.

## What does NOT work

**A package-scoped diversion.** `dpkg-divert --package NAME` means NAME is the
package *exempt* from the diversion. Both instances of an `MA: same` package
share one bare package name, so an arch-qualified `--package libfoo:amd64`
matches **neither** instance — both then get diverted to the same target and
collide there instead. Verified empirically 2026-09-07 with `libxtst-dev`.

**You cannot express "amd64 at the canonical path, i386 diverted" in dpkg.**
Diversions key on path, not architecture.

## Solution

Use a **global** (`--local`) diversion so dpkg stops writing the canonical path,
then own that path yourself: place one explicit copy per arch and symlink the
one you want.

```sh
# 1. global divert -- dpkg's copies go to a slot you ignore
sudo dpkg-divert --no-rename \
     --divert /usr/bin/pcap-config-diverted \
     --add /usr/bin/pcap-config

# 2. place an explicit copy per arch (see refresh-diverted-copy below)
# 3. point the canonical path at the one you want
sudo ln -sfn pcap-config-amd64 /usr/bin/pcap-config
```

Resulting layout:

| Path | Contents | Owned by |
|---|---|---|
| `/usr/bin/pcap-config` | symlink -> `-amd64` | you (dpkg never writes a diverted path) |
| `/usr/bin/pcap-config-amd64` | amd64 copy | you |
| `/usr/bin/pcap-config-i386` | i386 copy | you |
| `/usr/bin/pcap-config-diverted` | last-unpacked arch | dpkg |

Switching arch is `ln -sfn pcap-config-i386 /usr/bin/pcap-config`.

### Caveats

- **Never point the symlink at the `-diverted` slot.** It holds whichever arch
  unpacked last, so it can silently start returning the wrong arch's linker
  flags. Stale-but-correct beats fresh-but-wrong-arch.
- **Any transaction unpacking BOTH instances still fails**, because both divert
  to the same target and collide there. Reinstall one at a time with
  `dpkg -i <deb>`, or pass
  `-o Dpkg::Options::=--force-overwrite`.
- Your hand-placed copies are unowned, so **no `apt install` can refresh them** --
  that is the flip side of them surviving reinstalls. Use the script below.
- Check whether the divert is still needed after a version bump: if upstream
  fixes the packaging so both arches ship identical files, the divert becomes
  unnecessary. Compare the two debs directly, not the installed file.

## refresh-diverted-copy

`./refresh-diverted-copy` in this directory re-extracts a hand-placed copy from
the current archive. No-ops when already current; refuses to install an empty
file.

```sh
refresh-diverted-copy libpcap0.8-dev amd64 /usr/bin/pcap-config /usr/bin/pcap-config-amd64 755
refresh-diverted-copy libpcap0.8-dev i386  /usr/bin/pcap-config /usr/bin/pcap-config-i386  755
refresh-diverted-copy libxtst-dev    amd64 /usr/share/man/man3/XTestQueryExtension.3.gz \
                                           /usr/share/man/man3/XTestQueryExtension.3-amd64.gz 644
```

## Related

Wine itself resolves these libs via `pkg-config`, not the legacy `*-config`
scripts, and `.pc` files live at arch-specific paths -- so they are never in
conflict and stay dpkg-managed. `PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig`
is the arch-aware mechanism; Debian also ships `i686-linux-gnu-pkg-config`.
