local lazypath = vim.fn.stdpath("data") .. "/lazy"
local js_debug_path = lazypath .. "/vscode-js-debug"
local log_path = vim.fn.stdpath("data") .. "/dap_vscode_js.log"

require("dap-vscode-js").setup({
  node_path = "node",
  debugger_path = js_debug_path,
  -- debugger_cmd = { "js-debug-adapter" },
  -- adapters = { "pwa-node" },
  log_file_path = log_path, -- Path for file logging (optional)
  log_file_level = 0,
  log_console_level = vim.log.levels.ERROR,
})

for _, language in ipairs({
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process",
      processId = "${command:PickProcess}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }
end
