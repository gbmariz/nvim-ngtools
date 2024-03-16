local M = {}

local notify = require("notify")
local system = require("utils.system")
local serve_job
local job_started = false
local project_name = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h:t")
local cmd_system

M.port = 4200

local function serve_port(port)
  if system.linux then
    cmd_system = "ss -tln | grep ':".. port .."' | grep -w 'LISTEN' | grep -w '".. port .."'"
  else
    print("System not supported")
  end

  local handle = io.popen(cmd_system)
  if handle then
    local data = handle:read("*a")
    handle:close()

    return data == ""
  end
end

function M.start()
    if serve_job == nil and serve_port(M.port) then
      serve_job = vim.fn.jobstart({ "ng", "serve", "--port", M.port }, {
        on_stdout = function ()
          vim.schedule(function ()
            if not job_started then
              notify("http://localhost:" .. M.port, vim.log.levels.INFO, {
                icon = " ✓",
                title = "Server started in",
                render = "compact",
                timeout = 5000
              })

              job_started = true
            end
          end)
        end
      })

      notify(project_name .. " project, wait...", vim.log.levels.INFO, {
        icon = " 📦",
        title = "Building",
        render = "compact",
        timeout = 10000
      })
    else
      notify("The service is already active", vim.log.levels.WARN, {
        icon = " ⚠",
        title = "WARNING",
        render = "compact"
      })
    end
end

function M.stop()
  if serve_job ~= nil then
    vim.fn.jobstop(serve_job)
    serve_job = nil
    job_started = false

    notify("Service stopped", vim.log.levels.INFO, {
      title = "SUCCESS",
      render = "compact"
    })
  else
    notify("Service is not running!", vim.log.levels.WARN, {
      icon = " ⚠",
      title = "WARNING",
      render = "compact"
    })
  end
end

return M

