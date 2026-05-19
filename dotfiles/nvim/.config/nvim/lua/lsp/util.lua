local M = {}

function M.is_windows()
  return vim.uv.os_uname().sysname:lower():find("windows") ~= nil
end

function M.mason_path(path)
  local mason_install_path = vim.fn.expand("$MASON")
  return mason_install_path .. "/" .. path
  -- return vim.fn.stdpath("data") .. "/mason/" .. path
end

return M
