return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

	-- Color scheme
	use 'drewtempelmeyer/palenight.vim'
	
	-- Bufferline
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
	
	-- Lualine
	use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  
  -- Lsp and completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'

  -- Snippets

  -- Vim
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Lua
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

end)
