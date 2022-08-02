vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', 
        requires = {{ 'nvim-lua/plenary.nvim' }},
        config = function()
            require("config.telescope")
        end
    }

    use {
        'folke/tokyonight.nvim', 
        config = function() 
            require("config.colorscheme") 
        end 
    }
end)
