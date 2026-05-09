-- Anchor / Solana helpers
-- Activates when the current cwd or any parent contains an `Anchor.toml`.
-- Keymaps use the `<leader>A` prefix to avoid clashes with rust (<leader>r)
-- and crates (<leader>c).

local M = {}

local function find_anchor_root(start)
  local found = vim.fs.find({ "Anchor.toml" }, {
    upward = true,
    path = start or vim.fn.expand("%:p:h"),
  })
  if #found == 0 then
    return nil
  end
  return vim.fs.dirname(found[1])
end

local function run_in_term(cmd, root)
  vim.cmd("botright 15split | terminal")
  local term_buf = vim.api.nvim_get_current_buf()
  local chan = vim.bo[term_buf].channel
  if root then
    vim.fn.chansend(chan, "cd " .. vim.fn.shellescape(root) .. " && " .. cmd .. "\n")
  else
    vim.fn.chansend(chan, cmd .. "\n")
  end
  vim.cmd("startinsert")
end

local function anchor_run(args)
  local root = find_anchor_root()
  if not root then
    vim.notify("Anchor.toml not found in cwd or parents", vim.log.levels.WARN)
    return
  end
  run_in_term("anchor " .. args, root)
end

local function solana_run(args)
  run_in_term("solana " .. args)
end

local function open_idl()
  local root = find_anchor_root()
  if not root then
    vim.notify("Anchor.toml not found", vim.log.levels.WARN)
    return
  end
  local idl_dir = root .. "/target/idl"
  if vim.fn.isdirectory(idl_dir) == 0 then
    vim.notify("No IDL directory yet — run `anchor build` first", vim.log.levels.INFO)
    return
  end
  local files = vim.fn.globpath(idl_dir, "*.json", false, true)
  if #files == 0 then
    vim.notify("No IDL JSON files in " .. idl_dir, vim.log.levels.INFO)
    return
  end
  vim.ui.select(files, { prompt = "Open IDL:" }, function(choice)
    if choice then
      vim.cmd("edit " .. vim.fn.fnameescape(choice))
    end
  end)
end

function M.setup_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true }
  local map = vim.keymap.set

  -- Anchor lifecycle
  map("n", "<leader>Ab", function() anchor_run("build") end,
    vim.tbl_extend("force", opts, { desc = "Anchor build" }))
  map("n", "<leader>AB", function() anchor_run("build --no-idl") end,
    vim.tbl_extend("force", opts, { desc = "Anchor build (no IDL)" }))
  map("n", "<leader>At", function() anchor_run("test") end,
    vim.tbl_extend("force", opts, { desc = "Anchor test" }))
  map("n", "<leader>AT", function() anchor_run("test --skip-local-validator") end,
    vim.tbl_extend("force", opts, { desc = "Anchor test (skip local validator)" }))
  map("n", "<leader>Ad", function() anchor_run("deploy") end,
    vim.tbl_extend("force", opts, { desc = "Anchor deploy (localnet)" }))
  map("n", "<leader>AD", function() anchor_run("deploy --provider.cluster devnet") end,
    vim.tbl_extend("force", opts, { desc = "Anchor deploy (devnet)" }))
  map("n", "<leader>Ac", function() anchor_run("clean") end,
    vim.tbl_extend("force", opts, { desc = "Anchor clean" }))
  map("n", "<leader>Ak", function() anchor_run("keys list") end,
    vim.tbl_extend("force", opts, { desc = "Anchor keys list" }))
  map("n", "<leader>As", function() anchor_run("keys sync") end,
    vim.tbl_extend("force", opts, { desc = "Anchor keys sync" }))
  map("n", "<leader>Ai", open_idl,
    vim.tbl_extend("force", opts, { desc = "Open Anchor IDL" }))

  -- Solana CLI
  map("n", "<leader>Av", function() run_in_term("solana-test-validator --reset") end,
    vim.tbl_extend("force", opts, { desc = "Start solana-test-validator" }))
  map("n", "<leader>Al", function() solana_run("logs") end,
    vim.tbl_extend("force", opts, { desc = "Solana logs (tail)" }))
  map("n", "<leader>Aa", function() solana_run("address") end,
    vim.tbl_extend("force", opts, { desc = "Solana wallet address" }))
  map("n", "<leader>Ax", function() solana_run("balance") end,
    vim.tbl_extend("force", opts, { desc = "Solana balance" }))
end

-- Activate keymaps for buffers under an Anchor project (Rust + JS/TS clients).
local group = vim.api.nvim_create_augroup("AnchorHelpers", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*.rs", "*.toml", "*.ts", "*.js", "*.tsx", "*.jsx" },
  callback = function(ev)
    if find_anchor_root(vim.fn.fnamemodify(ev.file, ":p:h")) then
      M.setup_keymaps(ev.buf)
    end
  end,
})

-- User commands (work anywhere inside an Anchor workspace)
vim.api.nvim_create_user_command("AnchorBuild", function() anchor_run("build") end, {})
vim.api.nvim_create_user_command("AnchorTest", function() anchor_run("test") end, {})
vim.api.nvim_create_user_command("AnchorDeploy", function(o)
  if o.args ~= "" then
    anchor_run("deploy --provider.cluster " .. o.args)
  else
    anchor_run("deploy")
  end
end, { nargs = "?", complete = function() return { "localnet", "devnet", "testnet", "mainnet" } end })
vim.api.nvim_create_user_command("AnchorIdl", open_idl, {})
vim.api.nvim_create_user_command("SolanaValidator", function()
  run_in_term("solana-test-validator --reset")
end, {})
vim.api.nvim_create_user_command("SolanaLogs", function() solana_run("logs") end, {})

return M
