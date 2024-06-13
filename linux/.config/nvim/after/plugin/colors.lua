-- Main theme here, if this gets too crufty, comment out unused themes. If
-- that's not enough, remove them from packer. Look at packer too, some of
-- these don't need a setup call.
require('tokyonight').setup({
  style = 'night',
  light_style = 'day',
  transparent = false,
  terminal_colors = true,
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark",                            -- style for sidebars, see below
    floats = "dark",                              -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3,                           -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false,               -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = true,                            -- dims inactive windows
  lualine_bold = false,                           -- When `true`, section headers in the lualine theme will be bold

  --[===[
  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
  --]===]
})

require('rose-pine').setup({
  disable_background = true
})

require('onedark').setup({
  style = 'deep',
})

local c = require('vscode.colors').get_colors()
require('vscode').setup({
  -- Alternatively set style in setup
  -- style = 'light'

  -- Enable transparent background
  transparent = false,

  -- Enable italic comment
  italic_comments = true,

  -- Underline `@markup.link.*` variants
  underline_links = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = true,

  -- Override colors (see ./lua/vscode/colors.lua)
  color_overrides = {
    vscLineNumber = '#FFFFFF',
  },

  -- Override highlight groups (see ./lua/vscode/theme.lua)
  group_overrides = {
    -- this supports the same val table as vim.api.nvim_set_hl
    -- use colors from this colorscheme by requiring vscode.colors!
    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
  }
})

--- Enables transparency on the active window. If transparency is wanted on all
--- windows, then enable transparency via the theme.
--- @param color string | nil
--- @param transparent boolean | nil
function ColorMyPencils(color, transparent)
  -- color = color or "rose-pine"
  color = color or "tokyonight"
  if transparent == nil then transparent = true end
  vim.cmd.colorscheme(color)
  if transparent then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    if color == 'onedark' then
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
    end
  end
end

ColorMyPencils()
