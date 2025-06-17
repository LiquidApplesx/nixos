{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    # GENERAL EDIT SETTINGS
    opts = {
      number         = true;   # show line numbers
      relativenumber = true;   # relative line numbers
      wrap           = false;  # disable line wrap
      autoindent     = true;   # copy indent on newline
      smartindent    = true;   # C-like smart indent
      expandtab      = true;   # spaces not tabs
      shiftwidth     = 2;      # indent width
      tabstop        = 2;      # tab width
      softtabstop    = 2;      # soft tab width
      
      # Search settings
      ignorecase     = true;   # ignore case in search
      smartcase      = true;   # smart case sensitivity
      hlsearch       = true;   # highlight search results
      incsearch      = true;   # incremental search
      
      # UI improvements
      termguicolors  = true;   # enable 24-bit colors
      signcolumn     = "yes";  # always show sign column
      scrolloff      = 8;      # keep cursor away from edges
      sidescrolloff  = 8;      # horizontal scroll offset
      cursorline     = true;   # highlight current line
      splitbelow     = true;   # horizontal splits go below
      splitright     = true;   # vertical splits go right
      
      # Performance
      updatetime     = 250;    # faster completion
      timeoutlen     = 300;    # which-key popup delay
      
      # Backup and swap
      backup         = false;
      writebackup    = false;
      swapfile       = false;
      undofile       = true;   # persistent undo
    };

    # LEADER KEYS
    globals = {
      mapleader      = " ";
      maplocalleader = " ";
    };

    # THEME
    colorschemes.gruvbox.enable = true;
    extraConfigLuaPre = ''
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.cmd('colorscheme gruvbox')
    '';

    # PLUGINS
    plugins = {
      # Statusline and tabs
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "gruvbox";
            component_separators = { left = ""; right = ""; };
            section_separators = { left = ""; right = ""; };
          };
        };
      };
      
      bufferline = {
        enable = true;
        settings = {
          options = {
            numbers = "both";
            diagnostics = "nvim_lsp";
            separator_style = "slant";
            show_buffer_close_icons = true;
            show_close_icon = true;
            color_icons = true;
          };
        };
      };
      
      web-devicons.enable = true;

      # Editing aids
      indent-blankline = {
        enable = true;
        settings = {
          indent.char = "│";
          scope.enabled = true;
        };
      };
      rainbow-delimiters.enable = true;
      nvim-autopairs.enable = true;
      undotree.enable = true;
      
      # Better commenting
      comment = {
        enable = true;
        settings = {
          padding = true;
          sticky = true;
        };
      };

      # Surround operations
      nvim-surround.enable = true;

      # File explorer and finder
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
        settings = {
          defaults = {
            prompt_prefix = " ";
            selection_caret = " ";
            path_display = [ "truncate" ];
            file_ignore_patterns = [ "^.git/" "^node_modules/" ];
          };
        };
      };
      
      neo-tree = {
        enable = true;
        window.width = 30;
        buffers.followCurrentFile.enabled = true;
        filesystem = {
          filteredItems = {
            hideDotfiles = false;
            hideGitignored = false;
          };
        };
      };

      # Git integration
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
          };
          signs = {
            add.text = "│";
            change.text = "│";
            delete.text = "_";
            topdelete.text = "‾";
            changedelete.text = "~";
            untracked.text = "┆";
          };
        };
      };
      fugitive.enable = true;

      # LSP Configuration
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
            "<leader>d" = "open_float";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "K" = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>f" = "format";
          };
        };
        servers = {
          # Nix
          nixd.enable = true;
          
          # Rust
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            settings = {
              cargo.buildScripts.enable = true;
              procMacro.enable = true;
            };
          };
          
          # C/C++
          clangd.enable = true;
          
          # Python
          pyright = {
            enable = true;
            settings = {
              python.analysis = {
                typeCheckingMode = "basic";
                autoImportCompletions = true;
              };
            };
          };
          
          # Shell
          bashls.enable = true;
          
          # Web development
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          
          # Lua
          lua_ls = {
            enable = true;
            settings.Lua = {
              diagnostics.globals = [ "vim" ];
              workspace.library = [
                "\${3rd}/luv/library"
                "unpack(vim.api.nvim_get_runtime_file('', true))"
              ];
            };
          };
        };
      };

      # Completion
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "luasnip";
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      
      # Snippets
      luasnip = {
        enable = true;
        settings = {
          history = true;
          delete_check_events = "TextChanged";
        };
      };
      friendly-snippets.enable = true;

      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [ 
            "nix" "lua" "rust" "python" "c" "cpp" "bash"
            "javascript" "typescript" "html" "css" "json"
            "markdown" "yaml" "toml" "vim" "vimdoc"
          ];
          highlight.enable = true;
          indent.enable = true;
          incremental_selection.enable = true;
        };
      };
      
      # Additional treesitter features
      treesitter-context.enable = true;

      # Debug Adapter Protocol
      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;

      # Terminal integration
      toggleterm = {
        enable = true;
        settings = {
          size = 20;
          open_mapping = "[[<c-\\>]]";
          hide_numbers = true;
          shade_terminals = true;
          start_in_insert = true;
          direction = "float";
          close_on_exit = true;
        };
      };

      # Problem diagnostics
      trouble.enable = true;

      # Key helper
      which-key = {
        enable = true;
        settings = {
          delay = 300;
          plugins.spelling.enabled = true;
        };
      };

      # Notifications
      notify.enable = true;

      # Better UI elements
      dressing.enable = true;

      # Startup dashboard (simplified alpha config)
      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            opts = {
              position = "center";
              hl = "Type";
            };
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                type = "button";
                val = "  Find file";
                on_press.__raw = "function() require('telescope.builtin').find_files() end";
                opts = {
                  shortcut = "f";
                };
              }
              {
                type = "button";
                val = "  Recent files";
                on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
                opts = {
                  shortcut = "r";
                };
              }
              {
                type = "button";
                val = "  Find text";
                on_press.__raw = "function() require('telescope.builtin').live_grep() end";
                opts = {
                  shortcut = "g";
                };
              }
              {
                type = "button";
                val = "  Quit";
                on_press.__raw = "function() vim.cmd.qa() end";
                opts = {
                  shortcut = "q";
                };
              }
            ];
          }
        ];
      };
    };

    # ENHANCED KEYMAPS
    keymaps = [
      # File operations
      { key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; }
      { key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; }
      { key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; }
      { key = "<leader>fh"; action = "<cmd>Telescope help_tags<CR>"; }
      { key = "<leader>fr"; action = "<cmd>Telescope oldfiles<CR>"; }
      
      # File explorer
      { key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; }
      
      # Buffer management
      { key = "<S-h>"; action = "<cmd>bprevious<CR>"; }
      { key = "<S-l>"; action = "<cmd>bnext<CR>"; }
      { key = "<leader>bd"; action = "<cmd>bdelete<CR>"; }
      
      # Window management
      { key = "<C-h>"; action = "<C-w>h"; }
      { key = "<C-j>"; action = "<C-w>j"; }
      { key = "<C-k>"; action = "<C-w>k"; }
      { key = "<C-l>"; action = "<C-w>l"; }
      
      # Resize windows
      { key = "<C-Up>"; action = "<cmd>resize -2<CR>"; }
      { key = "<C-Down>"; action = "<cmd>resize +2<CR>"; }
      { key = "<C-Left>"; action = "<cmd>vertical resize -2<CR>"; }
      { key = "<C-Right>"; action = "<cmd>vertical resize +2<CR>"; }
      
      # Terminal
      { key = "<leader>t"; action = "<cmd>ToggleTerm<CR>"; }
      
      # Utilities
      { key = "<leader>u"; action = "<cmd>UndotreeToggle<CR>"; }
      { key = "<leader>xx"; action = "<cmd>TroubleToggle<CR>"; }
      { key = "<leader>xw"; action = "<cmd>TroubleToggle workspace_diagnostics<CR>"; }
      { key = "<leader>xd"; action = "<cmd>TroubleToggle document_diagnostics<CR>"; }
      
      # Git
      { key = "<leader>gg"; action = "<cmd>Git<CR>"; }
      { key = "<leader>gb"; action = "<cmd>Git blame<CR>"; }
      
      # Debug
      { key = "<leader>db"; action = "<cmd>DapToggleBreakpoint<CR>"; }
      { key = "<leader>dc"; action = "<cmd>DapContinue<CR>"; }
      { key = "<leader>di"; action = "<cmd>DapStepInto<CR>"; }
      { key = "<leader>do"; action = "<cmd>DapStepOver<CR>"; }
      { key = "<leader>dr"; action = "<cmd>DapRepl<CR>"; }
      
      # Clear search highlighting
      { key = "<leader>h"; action = "<cmd>nohlsearch<CR>"; }
      
      # Better indenting
      { key = "<"; action = "<gv"; mode = "v"; }
      { key = ">"; action = ">gv"; mode = "v"; }
      
      # Move text up and down
      { key = "<A-j>"; action = "<cmd>m .+1<CR>=="; }
      { key = "<A-k>"; action = "<cmd>m .-2<CR>=="; }
      { key = "<A-j>"; action = "<cmd>m '>+1<CR>gv=gv"; mode = "v"; }
      { key = "<A-k>"; action = "<cmd>m '<-2<CR>gv=gv"; mode = "v"; }
    ];

    # AUTOCMDS
    autoCmd = [
      {
        event = [ "BufReadPost" ];
        pattern = "*";
        command = "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif";
      }
      {
        event = [ "TextYankPost" ];
        pattern = "*";
        callback.__raw = "function() vim.highlight.on_yank() end";
      }
    ];

    # ADDITIONAL LUA CONFIGURATION
    extraConfigLuaPost = ''
      -- DAP configuration
      local dap = require('dap')
      
      -- LLDB adapter for C/C++/Rust
      dap.adapters.lldb = {
        type = 'executable',
        command = '${pkgs.lldb}/bin/lldb-vscode',
        name = 'lldb',
      }
      
      for _, lang in ipairs({ 'c', 'cpp', 'rust' }) do
        dap.configurations[lang] = {
          {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Executable path: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = vim.fn.getcwd(),
            stopOnEntry = false,
            args = {},
          },
        }
      end
      
      -- Python DAP
      dap.adapters.python = {
        type = 'executable',
        command = '${pkgs.python3}/bin/python',
        args = { '-m', 'debugpy.adapter' },
      }
      
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = "''${file}",
          pythonPath = function()
            return '${pkgs.python3}/bin/python'
          end,
        },
      }
    '';
  };
}
