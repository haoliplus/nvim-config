
return {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        -- your personnal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
          zsh = {
            icon = "#",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          },
        };
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = false;
        override_by_filename = {
          ["containerfile"] = {
            icon = "*",
            color = "#458ee5",
            cterm_color = "68",
            name = "containerfile",
          },
        };
      }
      require("nvim-web-devicons").set_icon {
        txt = {
          icon = '', 
          color = '#6d8086',
          cterm_color = "65",
          name = "txt"
        },
        containerfile = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "containerfile"
        },
        dockerfile = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "dockerfile"
        }
      }
      require("nvim-web-devicons").set_default_icon('', '#6d8086', 65)

    end
  }
