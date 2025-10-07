-- Rustacean.nvim - Modern Rust development plugin
-- Successor to rust-tools.nvim with better rust-analyzer integration

local function rustacean_setup()
  vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- Rustacean-specific keybindings
        vim.keymap.set("n", "<leader>ra", function()
          vim.cmd.RustLsp("codeAction")
        end, { buffer = bufnr, desc = "Rust code action" })

        vim.keymap.set("n", "<leader>rd", function()
          vim.cmd.RustLsp("debuggables")
        end, { buffer = bufnr, desc = "Rust debuggables" })

        vim.keymap.set("n", "<leader>rr", function()
          vim.cmd.RustLsp("runnables")
        end, { buffer = bufnr, desc = "Rust runnables" })

        vim.keymap.set("n", "<leader>rt", function()
          vim.cmd.RustLsp("testables")
        end, { buffer = bufnr, desc = "Rust testables" })

        vim.keymap.set("n", "<leader>re", function()
          vim.cmd.RustLsp("explainError")
        end, { buffer = bufnr, desc = "Rust explain error" })

        vim.keymap.set("n", "<leader>rc", function()
          vim.cmd.RustLsp("openCargo")
        end, { buffer = bufnr, desc = "Open Cargo.toml" })

        vim.keymap.set("n", "<leader>rp", function()
          vim.cmd.RustLsp("parentModule")
        end, { buffer = bufnr, desc = "Go to parent module" })

        vim.keymap.set("n", "J", function()
          vim.cmd.RustLsp("joinLines")
        end, { buffer = bufnr, desc = "Join lines" })

        vim.keymap.set("n", "<leader>rm", function()
          vim.cmd.RustLsp("expandMacro")
        end, { buffer = bufnr, desc = "Expand macro" })

        vim.keymap.set("n", "<leader>rh", function()
          vim.cmd.RustLsp({ "hover", "actions" })
        end, { buffer = bufnr, desc = "Hover actions" })
      end,

      default_settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = { "--all", "--", "-W", "clippy::all" },
          },
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
          diagnostics = {
            enable = true,
            experimental = {
              enable = true,
            },
          },
          inlayHints = {
            bindingModeHints = {
              enable = false,
            },
            chainingHints = {
              enable = true,
            },
            closingBraceHints = {
              enable = true,
              minLines = 25,
            },
            closureReturnTypeHints = {
              enable = "never",
            },
            lifetimeElisionHints = {
              enable = "never",
              useParameterNames = false,
            },
            maxLength = 25,
            parameterHints = {
              enable = true,
            },
            reborrowHints = {
              enable = "never",
            },
            renderColons = true,
            typeHints = {
              enable = true,
              hideClosureInitialization = false,
              hideNamedConstructor = false,
            },
          },
        },
      },
    },

    -- DAP configuration for debugging
    dap = {
      adapter = require("rustaceanvim.config").get_codelldb_adapter(
        vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib" -- macOS
        -- Use this for Linux: vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
      ),
    },

    -- Tools configuration
    tools = {
      executor = require("rustaceanvim.executors").termopen, -- Use termopen executor
      reload_workspace_from_cargo_toml = true,
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
      },
      hover_actions = {
        replace_builtin_hover = true,
      },
      crate_graph = {
        backend = "x11",
        output = nil,
        full = true,
        enabled_graphviz_backends = {
          "bmp",
          "cgimage",
          "canon",
          "dot",
          "gv",
          "xdot",
          "xdot1.2",
          "xdot1.4",
          "eps",
          "exr",
          "fig",
          "gd",
          "gd2",
          "gif",
          "gtk",
          "ico",
          "cmap",
          "ismap",
          "imap",
          "cmapx",
          "imap_np",
          "cmapx_np",
          "jpg",
          "jpeg",
          "jpe",
          "jp2",
          "json",
          "json0",
          "dot_json",
          "xdot_json",
          "pdf",
          "pic",
          "pct",
          "pict",
          "plain",
          "plain-ext",
          "png",
          "pov",
          "ps",
          "ps2",
          "psd",
          "sgi",
          "svg",
          "svgz",
          "tga",
          "tiff",
          "tif",
          "tk",
          "vml",
          "vmlz",
          "wbmp",
          "webp",
          "xlib",
          "x11",
        },
      },
    },
  }
end

rustacean_setup()
