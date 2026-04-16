-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Leader (must be set before lazy)
vim.g.mapleader = ","

-- Providers
vim.g.python3_host_prog = vim.env.HOME .. "/.pyenv/versions/3.13.3/bin/python"
vim.g.loaded_perl_provider = 0

-- Compat shim for Neovim 0.12 (ft_to_lang was removed)
if not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

-- Plugins
require("lazy").setup({
  -- Colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function()
    require("catppuccin").setup({ flavour = "mocha" })
    vim.cmd.colorscheme("catppuccin")
  end },

  -- Buffer tabs
  { "akinsho/bufferline.nvim", version = "*", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup()
    end },

  -- Status line
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "auto" } })
    end },

  -- File explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" } },
    config = function() require("nvim-tree").setup({ filters = { git_ignored = false } }) end },

  -- Fuzzy finder (replaces ctrlp, fzf, ack)
  { "nvim-telescope/telescope.nvim", branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>t", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>a", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>r", "<cmd>Telescope tags<CR>", desc = "Tags" },
    },
  },

  -- Treesitter (replaces vim-polyglot)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
    vim.treesitter.language.register("bash", "sh")
    local ensure = { "lua", "python", "javascript", "typescript", "tsx", "go", "html", "css", "json", "yaml", "bash", "markdown" }
    for _, lang in ipairs(ensure) do
      pcall(function() vim.treesitter.start(0, lang) end)
    end
    vim.api.nvim_create_autocmd("FileType", {
      callback = function() pcall(vim.treesitter.start) end,
    })
  end },

  -- Database
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  { "kristijanhusak/vim-dadbod-ui", dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle" },
    keys = { { "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" } },
  },

  -- Git
  "tpope/vim-fugitive",
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- Editing
  { "kylechui/nvim-surround", event = "VeryLazy", config = function() require("nvim-surround").setup() end },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup() end },
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },

  -- Motion (replaces easymotion)
  { "folke/flash.nvim", event = "VeryLazy",
    keys = { { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" } },
  },

  -- Keybinding cheatsheet
  { "folke/which-key.nvim", event = "VeryLazy", config = function() require("which-key").setup() end },

  -- Emmet
  { "mattn/emmet-vim", ft = { "html", "css", "jsx", "tsx", "vue", "svelte" } },

  -- Terminal
  { "akinsho/toggleterm.nvim", version = "*", config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      size = 15,
    })
  end },

  -- LSP
  { "williamboman/mason.nvim", config = function() require("mason").setup() end },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "gopls", "terraformls", "lua_ls" },
      })
    end },
  { "neovim/nvim-lspconfig", dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "pyright", "ts_ls", "gopls", "terraformls", "lua_ls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
      vim.lsp.enable(servers)
      -- LSP keybindings (activate when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(keys, fn, desc) vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc }) end
          map("gd", "<cmd>Lspsaga goto_definition<CR>", "Go to definition")
          map("gr", "<cmd>Lspsaga finder<CR>", "References")
          map("K", "<cmd>Lspsaga hover_doc<CR>", "Hover docs")
          map("<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename")
          map("<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code action")
          map("<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", "Diagnostics")
          map("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev diagnostic")
          map("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic")
          map("<leader>o", "<cmd>Lspsaga outline<CR>", "Outline")
        end,
      })
    end },

  -- LSP UI
  { "nvimdev/lspsaga.nvim", event = "LspAttach", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lspsaga").setup({ lightbulb = { enable = false } }) end },

  -- Completion
  { "hrsh7th/nvim-cmp", event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end },
})

-- Buffer navigation
vim.keymap.set("n", "<leader><Tab>", "<cmd>bn<CR>")
vim.keymap.set("n", "<leader>`", "<cmd>bp<CR>")

-- Split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- Surround word shortcut: ,w then type the surround char
vim.keymap.set("n", "<leader>w", "ysiw", { remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>h")
vim.keymap.set("n", "<C-h>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Backup / undo / swap
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.config/nvim/backups")
vim.opt.directory = vim.fn.expand("~/.config/nvim/swaps")
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- Settings
vim.opt.number = true
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.gdefault = true
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.wildignore:append("*.jpg,*.jpeg,*.gif,*.png,*.psd,*.o,*.obj,*.min.js")
vim.opt.wildignore:append("*/node_modules/*,*/.git/*,*/vendor/*,*/build/*,*/tmp/*")
