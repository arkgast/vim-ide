local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                     ",
  "                                                     ",
  "                                                     ",
  "                                                     ",
  "                                                     ",
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
  "                                                     ",
  "                                                     ",
}

dashboard.section.buttons.val = {
  dashboard.button("e", " New file", ":ene <BAR>startinsert<CR>"),
  dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", " Recently opened files", ":Telescope oldfiles<CR>"),
  dashboard.button("w", " Find word", ":Telescope live_grep<CR>"),
  dashboard.button("s", " Sync packages", ":PackerSync<CR>"),
  dashboard.button("g", " Git", ":Neogit kind=tab<CR>"),
  dashboard.button("q", "⚔ Quit", ":q<CR>"),
}

alpha.setup(dashboard.opts)
