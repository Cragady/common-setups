local M = {}

local name = require("utils.sanitize_name")

M.cmd_name = "Redir"
M.ext_cmd_name = M.cmd_name .. "Pick"
M.name_base = "[" .. M.cmd_name .. "]";
M.cmd_header = "▶ Command: "
M.separator = "─"
M.sep_count = 80

-- Below is pseudo-code(ish?)
-- This gives a couple of different uses, and you can see some of the feaures in action wth long names and certain symbols being used in the commands
-- Can see with `:ls`, `:b`, and a light header implementation
-- Scratch Buffer - `:{M.cmd_name}!`, `:{M.cmd_name}`
-- -- e.g. `:Redir! verbose map <leader> something_really_long_name_with_symbols/<>|"'`
-- Picker - `:{M.ext_cmd_name}`
-- -- e.g. `:RedirPick verbose map <leader> something_really_long_name_with_symbols/<>|"'`
-- NOTE: may need actual gnarly commands to actually see it in action

local function capture(cmd)
  local ok, output = pcall(vim.fn.execute, cmd, "silent")

  if not ok then
    vim.notify(output, vim.log.levels.ERROR)
    return nil
  end

  return vim.split(output, "\n", {
    plain = true,
    trimempty = true,
  })
end

local function handle_global_table(lines, opts)
  if not lines then return end

  table.insert(lines, 1, M.cmd_header .. opts.cmd_name)
  table.insert(lines, 2, string.rep(M.separator, math.min(M.sep_count, #lines[1])))
end

local function create_buffer(lines, opts)
  opts = opts or {}

  local buf = vim.api.nvim_create_buf(false, true)

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].filetype = opts.filetype or "vim"

  if opts.cmd_name then
    handle_global_table(lines, opts)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.cmd(opts.horizontal and "split" or "vsplit")
  vim.api.nvim_win_set_buf(0, buf)

  vim.bo[buf].modifiable = false

  -- NOTE: without this, the name of the buffs would be `[Scratch]` - To denote scratch buffers
  if opts.cmd_name then
    local safe_name = name.sanitize_name(opts.cmd_name)
    vim.api.nvim_buf_set_name(buf, M.name_base .. " " .. safe_name)
  else
    vim.api.nvim_buf_set_name(buf, M.name_base)
  end

  return buf
end

function M.show(cmd, opts)
  local lines = capture(cmd)
  if not lines then return end

  create_buffer(lines, opts)
end

function M.pick(cmd)
  local lines = capture(cmd)
  if not lines then return end

  -- TODO: fix later with Dep inversion
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local previewers = require("telescope.previewers")
  local p_utils = require("telescope.previewers.utils")


  local ns_previewer = vim.api.nvim_create_namespace "mycustnmspce.Redir"
  local hl = vim.hl

  -- local function print(val)
  --   vim.notify(vim.inspect(val))
  -- end

  p_utils.jump_to_line = function(self, bufnr, entry)
    pcall(vim.api.nvim_buf_clear_namespace, bufnr, ns_previewer, 0, -1)

    if entry.lnum and entry.lnum > 0 then
      local lnum, lnend = entry.lnum - 1, (entry.lnend or entry.lnum) - 1

      local col, colend = 0, -1
      -- Both col delimiters should be provided for them to take effect.
      -- This is to ensure that column range highlighting was opted in, as `col`
      -- is already used to determine the buffer jump position elsewhere.
      if entry.col and entry.colend then
        col, colend = entry.col - 1, entry.colend - 1
      end

      for i = lnum, lnend do
        pcall(
          hl.range,
          bufnr,
          ns_previewer,
          "TelescopePreviewLine",
          { i, i == lnum and col or 0 },
          { i, i == lnend and colend or -1 }
        )
      end

      local middle_ln = math.floor(lnum + (lnend - lnum) / 2)
      pcall(vim.api.nvim_win_set_cursor, self.state.winid, { middle_ln + 1, 0 })
      if bufnr ~= nil then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd "norm! zz"
        end)
      end
    end
  end

  local display_lines = {}
  handle_global_table(display_lines, { cmd_name = cmd })

  vim.list_extend(display_lines, lines)

  pickers
    .new({}, {
      prompt_title = M.name_base .. " " .. name.sanitize_name(cmd),

      finder = finders.new_table({
        results = display_lines,
      }),

      get_buffer_by_name = function(_, entry)

        local path = entry.path
        if path == nil then
          path = entry.filename
        end
        if path == nil then
          path = entry.value
        end

        return path
      end,

      previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry, status)

          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, display_lines)

          if entry.lnum == nill then
            entry.lnum = entry.index or 0
          end

          vim.schedule(function()
            p_utils.jump_to_line(self, self.state.bufnr, entry)
          end)
        end,
      }),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

function M.setup()
  vim.api.nvim_create_user_command(M.cmd_name, function(ctx)
    if ctx.args == "" then
      vim.notify("Usage: " .. M.cmd_name .. "[!] {command}")
      return
    end

    M.show(ctx.args, {
      horizontal = ctx.bang,
    })
  end, {
    nargs = "*",
    bang = true,
    complete = "command",
  })

  vim.api.nvim_create_user_command(M.ext_cmd_name, function(ctx)
    if ctx.args == "" then
      vim.notify("Usage: " .. M.ext_cmd_name .. " {command}")
      return
    end

    M.pick(ctx.args)
  end, {
    nargs = "*",
    complete = "command",
  })
end

return M
