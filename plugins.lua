local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "neovim/nvim-lspconfig",
    -- UFO dependencies
    dependencies = {
      "kevinhwang91/promise-async",
      "kevinhwang91/nvim-ufo",
      "luukvbaal/statuscol.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
      --  UFO configs
      local builtin = require("statuscol.builtin")
            require("statuscol").setup(
              {
                relculright = true,
                -- setopt = true,
                segments = {
                  {
                    text = {
                      builtin.foldfunc,
                    },
                    condition = {
                      true,
                      function(args) return args.fold.width > 0 end,
                    },
                  },
                  {text = { " " }, hl = "FoldColumn" },
                  {text = {"%s"}, click = "v:lua.ScSa"},
                  {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
                }
              }
            )
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "custom.configs.nvimtree"
    end,
  },

}
return plugins
