local M = {}

-- TODO: Determine if opts is wanted here.
-- NOTE: This is a simple sanitizer, don't use it for super serious shtuffs
function M.sanitize_name(cmd)
  local name = (cmd:gsub("%s+", "_"))
  -- Determine if wanted:
  name = name:gsub("[/\\<>|\"']", "")

  -- determine if wanted
  return name:sub(1, 40)
  -- return name
end

return M
