local configs = require("nvim-treesitter.configs")

configs.setup({
  -- Parsers
  ensure_installed = {
    "rust",
    "lua",
    "solidity",
    "javascript",
    "typescript",
    "tsx",
    "go",
    "python",
    "c",
    "cpp",
    "c_sharp",
    "html",
    "css",
    "scss",
    "json",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "query",
    "bash",
    "regex",
    "gitignore",
    "diff",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},

  -- Highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- Disable for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  -- Indentation
  indent = {
    enable = true,
    disable = { "python" }, -- Python indentation is better with built-in
  },

  -- Incremental Selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },

  -- Text Objects
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps = {
        -- Functions
        ["af"] = { query = "@function.outer", desc = "Select outer function" },
        ["if"] = { query = "@function.inner", desc = "Select inner function" },
        -- Classes
        ["ac"] = { query = "@class.outer", desc = "Select outer class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
        -- Conditionals
        ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
        -- Loops
        ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
        -- Parameters
        ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
        -- Comments
        ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
        ["i/"] = { query = "@comment.inner", desc = "Select inner comment" },
        -- Blocks
        ["ab"] = { query = "@block.outer", desc = "Select outer block" },
        ["ib"] = { query = "@block.inner", desc = "Select inner block" },
        -- Calls
        ["aF"] = { query = "@call.outer", desc = "Select outer call" },
        ["iF"] = { query = "@call.inner", desc = "Select inner call" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "V", -- linewise
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>sp"] = "@parameter.inner", -- swap parameters/arguments
        ["<leader>sf"] = "@function.outer", -- swap functions
      },
      swap_previous = {
        ["<leader>sP"] = "@parameter.inner",
        ["<leader>sF"] = "@function.outer",
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- Track movements in jumplist
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next function start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next function end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
        ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
        ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
        ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
        ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
      },
      goto_next = {
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
      },
      goto_previous = {
        ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
      },
    },

    lsp_interop = {
      enable = true,
      border = "rounded",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>pf"] = { query = "@function.outer", desc = "Peek function definition" },
        ["<leader>pc"] = { query = "@class.outer", desc = "Peek class definition" },
      },
    },
  },

  -- Refactor Module
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = {
      enable = false, -- Can be distracting, enable if you like it
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "]r",
        goto_previous_usage = "[r",
      },
    },
  },
})

-- Treesitter Context (shows function/class context at top)
require("treesitter-context").setup({
  enable = true,
  max_lines = 3, -- Maximum number of lines to show
  min_window_height = 20,
  line_numbers = true,
  multiline_threshold = 1,
  trim_scope = "outer",
  mode = "cursor",
  separator = nil,
  zindex = 20,
})

-- Auto-tag for HTML/JSX
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
  per_filetype = {
    ["html"] = {
      enable_close = true,
    },
  },
})

-- Folding with Treesitter (built-in foldexpr — Neovim 0.10+)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.fillchars:append({ fold = " " })

-- Custom foldtext: meaningful header (climbs treesitter when foldstart is a
-- bare brace), dot-filled ruler, right-aligned line count. Returns highlight
-- chunks so the header/dots/count get distinct colors.
local fold_anchor_nodes = {
  function_declaration = true,
  function_definition = true,
  function_item = true,
  method_definition = true,
  method_declaration = true,
  class_declaration = true,
  class_definition = true,
  struct_item = true,
  enum_item = true,
  trait_item = true,
  impl_item = true,
  mod_item = true,
  try_statement = true,
  catch_clause = true,
  finally_clause = true,
  if_statement = true,
  for_statement = true,
  while_statement = true,
  do_statement = true,
  match_expression = true,
  match_arm = true,
  arrow_function = true,
  lambda_expression = true,
  interface_declaration = true,
  type_alias_declaration = true,
  variable_declaration = true,
  lexical_declaration = true,
  object = true,
  table_constructor = true,
}

local function is_meaningless(line)
  local s = line:gsub("^%s+", ""):gsub("%s+$", "")
  if s == "" then
    return true
  end
  -- bare braces / parens / arrows: `{`, `}`, `})`, `} {`, `} else {`,
  -- `} catch (e) {`, `) {`, `=> {`, etc.
  if s:match("^[%){}%]]+$") then
    return true
  end
  if s:match("^[%){}%]=>%s]*{$") then
    return true
  end
  return false
end

local function resolve_header(foldstart, foldend)
  local raw = vim.fn.getline(foldstart)
  if not is_meaningless(raw) then
    return raw
  end

  -- Try treesitter: find ancestor whose first line is meaningful.
  local ok, node = pcall(vim.treesitter.get_node, {
    pos = { foldstart - 1, 0 },
    ignore_injections = false,
  })
  if ok and node then
    local cur = node
    while cur do
      local srow = cur:start()
      local candidate = vim.fn.getline(srow + 1)
      if fold_anchor_nodes[cur:type()] and not is_meaningless(candidate) then
        return candidate
      end
      cur = cur:parent()
    end
  end

  -- Fallback: scan forward inside the fold for the first meaningful line,
  -- then backward above the fold.
  for lnum = foldstart + 1, foldend do
    local l = vim.fn.getline(lnum)
    if not is_meaningless(l) then
      return l
    end
  end
  for lnum = foldstart - 1, math.max(foldstart - 5, 1), -1 do
    local l = vim.fn.getline(lnum)
    if not is_meaningless(l) then
      return l
    end
  end
  return raw, foldstart
end

local function leading_indent_width(line)
  return vim.fn.strdisplaywidth(line:match("^%s*") or "")
end

local function clean_header(line)
  local s = line:gsub("^%s+", ""):gsub("%s+$", "")
  -- strip trailing open-brace / arrow so the dot ruler starts cleanly
  s = s:gsub("%s*=>%s*{?$", "")
  s = s:gsub("%s*{$", "")
  return s
end

_G.custom_foldtext = function()
  local foldstart = vim.v.foldstart
  local foldend = vim.v.foldend
  local count = foldend - foldstart + 1

  local raw_header = resolve_header(foldstart, foldend)
  local indent_w = leading_indent_width(raw_header)
  local header = clean_header(raw_header)
  if header == "" then
    header = vim.fn.getline(foldstart):gsub("^%s+", "")
    indent_w = 0
  end

  local winid = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(winid)
  local textoff = (vim.fn.getwininfo(winid)[1] or {}).textoff or 0
  local budget = math.max(width - textoff, 20)

  local compact = budget < 60
  local right = compact
      and string.format(" 󰁂 %d ", count)
    or string.format(" 󰁂 %d lines ", count)

  local header_w = vim.fn.strdisplaywidth(header)
  local right_w = vim.fn.strdisplaywidth(right)

  -- If indent alone would crowd the budget, drop it.
  if indent_w + header_w + right_w + 4 > budget then
    indent_w = 0
  end

  -- Header truncation if it eats the whole budget
  if indent_w + header_w + right_w + 4 > budget then
    local max_header = budget - indent_w - right_w - 4
    if max_header < 6 then
      header = ""
      header_w = 0
    else
      local truncated = vim.fn.strcharpart(header, 0, max_header - 1)
      header = truncated .. "…"
      header_w = vim.fn.strdisplaywidth(header)
    end
  end

  local fill_w = budget - indent_w - header_w - right_w - 2
  if fill_w < 1 then
    fill_w = 1
  end
  local indent = string.rep(" ", indent_w)
  local dots = " " .. string.rep("·", fill_w) .. " "

  return {
    { indent, "Normal" },
    { header, "Function" },
    { dots, "Comment" },
    { right, "Number" },
  }
end
vim.opt.foldtext = "v:lua.custom_foldtext()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10

-- Fallback to indent folding when no treesitter parser is attached,
-- so buffers without a parser still get sensible folds.
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("TSFoldFallback", { clear = true }),
  callback = function(args)
    local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
    if not ok or not parser then
      vim.api.nvim_set_option_value("foldmethod", "indent", { scope = "local" })
    end
  end,
})
