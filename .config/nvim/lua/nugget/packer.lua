vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', 
        requires = {{ 'nvim-lua/plenary.nvim' }},
        config = function()
            require("nugget.config.telescope")
        end
    }

    use {
        'folke/tokyonight.nvim', 
        config = function() 
            require("nugget.config.colorscheme") 
        end 
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        config = function() 
            require("nugget.config.explorer") 
        end
    }
    
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rails'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-surround'

    use {
        'nvim-treesitter/nvim-treesitter', 
        run = ':TSUpdate', 
        config = function() 
            require("nugget.config.treesitter") 
        end
    }

    use {
        "neovim/nvim-lspconfig", 
        config = function () 
            require("nugget.config.lspconfig") 
        end
    }


    use { 
        "williamboman/nvim-lsp-installer" ,
        config = function () 
            require("nugget.config.lspinstaller")
        end
    }
end)
