local M = {}

local system = require("utils.system")
local ng_serve = require("commands.serve")
local cmd_create = vim.api.nvim_create_user_command

function M.setup(opts)
  opts = opts or {}

  -- check that angular/cli is installed and is angular project
  if system.ng_installed() and system.is_ng_project then
    -- [[ personalized options
    ng_serve.port = opts.port
    -- ]]

    -- plugin commands
    cmd_create("NgServe", ng_serve.start, { nargs = 0 })
    cmd_create("NgStop", ng_serve.stop, { nargs = 0 })
  end
end

return M

