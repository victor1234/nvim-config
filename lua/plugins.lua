local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

		-- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
    }

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        vim.cmd "colorscheme everforest"
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd="Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

		-- WhichKey
		use {
		  "folke/which-key.nvim",
		  config = function()
			  require("config.whichkey").setup()
		  end,
		}

		-- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

		-- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

		-- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }
		-- NVim Tree
		use {
		 "kyazdani42/nvim-tree.lua",
		 requires = {
			 "kyazdani42/nvim-web-devicons",
		 },
		 cmd = { "NvimTreeToggle", "NvimTreeClose" },
			 config = function()
				 require("config.nvimtree").setup()
			 end,
		}

		-- Completion
		use {
			"ms-jpq/coq_nvim",
			branch = "coq",
			event = "InsertEnter",
			opt = true,
			run = ":COQdeps",
			config = function()
				require("config.coq").setup()
			end,
			requires = {
				{ "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
			},
			disable = false,
		}

		-- LSP
		use {
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "nvim-lsp-installer", "lsp_signature.nvim", "coq_nvim" },
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
				"ray-x/lsp_signature.nvim",
			},
		}

		use {
			"github/copilot.vim",
			event = "InsertEnter",
			disable = false
		}


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M