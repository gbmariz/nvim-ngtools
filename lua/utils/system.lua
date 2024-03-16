local M = {}

M.linux = vim.loop.os_uname().sysname == "Linux"
-- check that angular/cli is installed
function M.ng_installed()
  local handle = io.popen("ng --help 2>&1")

  if handle ~= nil then
    local data = handle:read("*a")
    handle:close()

    return data:find("ng <command>", 1, true)
  end
end

-- check if it's an angular project
M.is_ng_project = vim.fn.filereadable("angular.json") == 1 or vim.fn.filereadable("angular-cli.json") == 1

return M

