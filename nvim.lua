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
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")
opt.shortmess:append("I")
opt.completeopt = "menu,menuone,noselect"

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
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
vim.g.mapleader = " "
map("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>o", "<cmd>Telescope find_files<cr>")
map("n", "<leader>f", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>")
map("n", "<leader>i", "<cmd>Telescope oldfiles<cr>")
map("n", "<leader>b", "<cmd>Telescope buffers<cr>")
map("n", "<leader>nh", ":nohl<cr>")
map("n", "x", "\"_x")
map("n", "<leader>sv", "<c-w>v")
map("n", "<leader>sh", "<c-w>s")
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
map("n", "<leader>hw", ":HopWord<cr>")
map("n", "<leader>ha", ":HopAnywhere<cr>")
map("n", "<leader>lc", "<cmd>lua vim.lsp.buf.declaration()<cr>")
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>")
map("n", "<leader>lv", "<cmd>lua vim.lsp.buf.hover()<cr>")
map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>")
map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>")
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>")
map("n", "<leader>ls", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>" )
map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
map("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>")
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>")
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>")
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>")
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
    { "nvim-lua/plenary.nvim" },
    { "nmac427/guess-indent.nvim", config = function() require("guess-indent").setup {} end },
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
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.1", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
        local t = require("telescope")
        t.setup { extensions = { file_browser = { disable_devicons = true } } }
        t.load_extension "file_browser"
    end },
    { "rhysd/conflict-marker.vim" },
    { "tpope/vim-surround" },
    { "vim-scripts/ReplaceWithRegister" },
    { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
    { "nvim-lualine/lualine.nvim", config = function ()
        require("lualine").setup {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { { "mode", color = { bg = "#c2c2c2" } } },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } }, "filetype" },
                lualine_y = { { "progress", separator = nil } },
                lualine_z = { { "location", color = { bg = "#c2c2c2" } } }
            }
        }
    end },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    { "hrsh7th/nvim-cmp", config = function()
        local c = require("cmp")
        c.setup {
            snippet = {
                expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
            },
            mapping = c.mapping.preset.insert {
                ["<c-k>"] = c.mapping.select_prev_item(),
                ["<c-j>"] = c.mapping.select_next_item(),
                ["<c-space>"] = c.mapping.complete(),
                ["<c-e>"] = c.mapping.abort(),
                ["<cr>"] = c.mapping.confirm { select = false }
            },
            sources = c.config.sources {
                { name = "vsnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lsp" }
            }
        }
    end },
    { "phaazon/hop.nvim", config = function() require("hop").setup() end },
    { "neovim/nvim-lspconfig", config = function()
        require("lspconfig")["rust_analyzer"].setup {}
    end },
    { "j-hui/fidget.nvim", config = function() require("fidget").setup() end },
    { "simrat39/rust-tools.nvim", config = function() 
        require("rust-tools").setup { inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = ""
        } }
    end },
    { "windwp/nvim-autopairs", config = function()
        require("nvim-autopairs").setup {
            check_ts = true
        }
    end },
    { "windwp/nvim-ts-autotag" },
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end }
})

-- misc
vim.cmd("highlight! link CursorLineNr CursorLine")
vim.cmd("cd ~/Work")
