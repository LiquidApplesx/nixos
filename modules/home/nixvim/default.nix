{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim = {
    enable = true;
    # 1. Core Editor Settings
    viAlias = true;
    vimAlias = true;
    # basic vim options
    opts = {
      number = true; # line numbers
      relativenumber = true; # relative line numbers
      wrap = false; # no line wrap
      ignorecase = true;
      smartcase = true;
      clipboard = "unnamedplus"; # system clipboard integration
      background = "dark"; # use dark background (for Gruvbox)
    };
    globals.mapleader = " ";
    globals.maplocalleader = " ";

    # 2. Key mappings (leader-based)
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          silent = true;
          desc = "Explorer: Toggle file tree";
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          silent = true;
          desc = "Find File";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        options = {
          silent = true;
          desc = "Recent Files";
        };
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          silent = true;
          desc = "Search in Files";
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options = {
          silent = true;
          desc = "Buffer: Delete";
        };
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<CR>";
        options = {
          silent = true;
          desc = "Buffer: Next";
        };
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprev<CR>";
        options = {
          silent = true;
          desc = "Buffer: Prev";
        };
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          silent = true;
          desc = "Git: LazyGit UI";
        };
      }
    ];

    # 3. Colorscheme - Gruvbox (dark hard)
    colorschemes.gruvbox.enable = true;
    colorschemes.gruvbox.settings.contrast_dark = "hard";

    # 4. Plugin modules
    plugins = {
      # Autocomplete and Snippets
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
      };
      luasnip.enable = true;
      # LSP
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          pyright.enable = true;
          ts_ls.enable = true;
          lua_ls.enable = true;
          bashls.enable = true;
          clangd.enable = true;
          rust_analyzer = {
	  	enable = true;
		installCargo = true;
		installRustc = true;
	  };
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
        };
      };
      # Treesitter and related
      treesitter.enable = true;
      ts-autotag.enable = true;
      # Debugger
      dap.enable = true;
      dap-ui.enable = true;
      # File explorer and search
      neo-tree.enable = true;
      telescope.enable = true;
      # UI enhancements
      lualine.enable = true;
      bufferline.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      # Terminal
      toggleterm.enable = true;
      # Git
      gitsigns.enable = true;
      lazygit.enable = true;
    };
  };
}
