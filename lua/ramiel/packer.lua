-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Formatting code, mainly javascript related code
  use {
	  'jose-elias-alvarez/null-ls.nvim',
	  requires = {
		  {'neovim/nvim-lspconfig'},
		  {"nvim-lua/plenary.nvim"},
	  }
  }

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    }
  }

  -- Theme coloring
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  -- Syntax and code highlighting
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  }

  -- adds lsp config
  use 'neovim/nvim-lspconfig'

  -- Autocompletion magic
  use {
      'hrsh7th/nvim-cmp',
      requires = {
          {'neovim/nvim-lspconfig'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'L3MON4D3/LuaSnip'},
      }
  }

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  -- Automatically add closing pair for '[, {, etc'
  use 'windwp/nvim-autopairs'


  -- Automatically add closing tag for jsx, html, etc
  use 'windwp/nvim-ts-autotag'

  -- file and folder explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
end)
