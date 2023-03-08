-- config
local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "light"
opt.signcolumn = "number"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")
opt.shortmess:append("I")

-- shortcuts
local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  if opts.noremap == nil then
    opts.noremap = true
  end
  if type(modes) == "string" then
    modes = {modes}
  end
  for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end
vim.g.mapleader = " "
map("n", "<leader>o", "<cmd>Telescope find_files<cr>")
map("n", "<leader>i", "<cmd>Telescope oldfiles<cr>")
map("n", "<leader>b", "<cmd>Telescope buffers<cr>")
map("n", "<leader>nh", ":nohl<cr>")
map("n", "x", "\"_x")
map("n", "<leader>sv", "<w-w>v")
map("n", "<leader>sh", "<w-w>s")
map("n", "<leader>se", "<c-w>=")
map("n", "<leader>sx", ":close<cr>")
map("n", "<leader>sh", "<c-w>h")
map("n", "<leader>sj", "<c-w>j")
map("n", "<leader>sk", "<c-w>k")
map("n", "<leader>sl", "<c-w>l")
map("n", "<leader>st", "<c-w>s:term<cr>")
map("n", "<leader>tn", ":tabnew<cr>")
map("n", "<leader>tx", ":tabclose<cr>")
map("n", "<leader>tl", ":tabp<cr>")
map("n", "<leader>tr", ":tabn<cr>")
map("i", "<c-`>", "<esc>")
map("i", "<c-e>", "<c-o><c-e>")
map("i", "<c-y>", "<c-o><c-y>")

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
    { "nmac427/guess-indent.nvim", config = function()
        require("guess-indent").setup {}
    end },
    { "navarasu/onedark.nvim", config = function() 
        local o = require("onedark")
        o.setup { style = "light" }
        o.load()
    end },
    { "nvim-treesitter/nvim-treesitter", config = function()
        vim.cmd(":sil :TSUpdate")
    end },
    { "lukas-reineke/indent-blankline.nvim", config = function()
        require("indent_blankline").setup {
            show_current_context = true,
            show_current_context_start = true,
        }
    end },
    { "nvim-telescope/telescope.nvim", tag = "0.1.1", dependencies = { "nvim-lua/plenary.nvim" } },
    { "rhysd/conflict-marker.vim" },
    { "tpope/vim-surround" }
})

-- misc
vim.cmd("cd ~/Work")
