{ ... }:
{
  programs.nixvim = {
    enable = true;
    vimAlias = true;
    
    # Enhanced vim options for IDE experience
    opts = {
      # Line numbers
      number = true;
      relativenumber = true;
      
      # Indentation
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      smartindent = true;
      autoindent = true;
      
      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;
      
      # UI
      wrap = false;
      scrolloff = 8;
      sidescrolloff = 8;
      mouse = "a";
      clipboard = "unnamedplus";
      termguicolors = true;
      signcolumn = "yes";
      colorcolumn = "80";
      cursorline = true;
      
      # Performance
      updatetime = 250;
      timeoutlen = 500;
      
      # Completion
      completeopt = ["menu" "menuone" "noselect"];
      
      # Better editing experience
      undofile = true;
      undolevels = 10000;
      backup = false;
      writebackup = false;
      swapfile = false;
      
      # Splits
      splitright = true;
      splitbelow = true;
      
      # Other
      hidden = true;
      showmode = false;
      pumheight = 10;
      pumblend = 10;
      winblend = 10;
    };
    
    # Global variables
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    
    # Modern colorscheme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = false;
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          telescope = true;
          which_key = true;
          indent_blankline.enabled = true;
        };
      };
    };
    
    # Comprehensive keymaps
    keymaps = [
      # File operations
      {
        mode = "n";
        key = "<leader>w";
        action = ":w<CR>";
        options = { silent = true; desc = "Save file"; };
      }
      {
        mode = "n";
        key = "<leader>wa";
        action = ":wa<CR>";
        options = { silent = true; desc = "Save all files"; };
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
        options = { silent = true; desc = "Quit"; };
      }
      {
        mode = "n";
        key = "<leader>qa";
        action = ":qa<CR>";
        options = { silent = true; desc = "Quit all"; };
      }
      
      # Clear search highlighting
      {
        mode = "n";
        key = "<Esc>";
        action = ":nohlsearch<CR>";
        options.silent = true;
      }
      
      # Better window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = { silent = true; desc = "Move to left window"; };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = { silent = true; desc = "Move to bottom window"; };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = { silent = true; desc = "Move to top window"; };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = { silent = true; desc = "Move to right window"; };
      }
      
      # Resize windows
      {
        mode = "n";
        key = "<C-Up>";
        action = ":resize +2<CR>";
        options = { silent = true; desc = "Increase window height"; };
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = ":resize -2<CR>";
        options = { silent = true; desc = "Decrease window height"; };
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = ":vertical resize -2<CR>";
        options = { silent = true; desc = "Decrease window width"; };
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = ":vertical resize +2<CR>";
        options = { silent = true; desc = "Increase window width"; };
      }
      
      # Buffer navigation
      {
        mode = "n";
        key = "<S-h>";
        action = ":bprevious<CR>";
        options = { silent = true; desc = "Previous buffer"; };
      }
      {
        mode = "n";
        key = "<S-l>";
        action = ":bnext<CR>";
        options = { silent = true; desc = "Next buffer"; };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = ":bdelete<CR>";
        options = { silent = true; desc = "Delete buffer"; };
      }
      
      # File explorer
      {
        mode = "n";
        key = "<leader>e";
        action = ":Neotree toggle<CR>";
        options = { silent = true; desc = "Toggle file explorer"; };
      }
      
      # Terminal
      {
        mode = "n";
        key = "<leader>tf";
        action = ":ToggleTerm direction=float<CR>";
        options = { silent = true; desc = "Toggle floating terminal"; };
      }
      {
        mode = "n";
        key = "<leader>th";
        action = ":ToggleTerm direction=horizontal<CR>";
        options = { silent = true; desc = "Toggle horizontal terminal"; };
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = ":ToggleTerm direction=vertical size=80<CR>";
        options = { silent = true; desc = "Toggle vertical terminal"; };
      }
      
      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.silent = true;
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.silent = true;
      }
      
      # Move lines
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options = { silent = true; desc = "Move selection down"; };
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options = { silent = true; desc = "Move selection up"; };
      }
      
      # LSP keymaps (additional to plugin defaults)
      {
        mode = "n";
        key = "<leader>lr";
        action = ":lua vim.lsp.buf.rename()<CR>";
        options = { silent = true; desc = "Rename symbol"; };
      }
      {
        mode = "n";
        key = "<leader>la";
        action = ":lua vim.lsp.buf.code_action()<CR>";
        options = { silent = true; desc = "Code actions"; };
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = ":Trouble diagnostics toggle<CR>";
        options = { silent = true; desc = "Toggle diagnostics"; };
      }
      {
        mode = "n";
        key = "<leader>lf";
        action = ":lua vim.lsp.buf.format()<CR>";
        options = { silent = true; desc = "Format document"; };
      }
    ];
    
    # Comprehensive plugin configuration
    plugins = {
      # Fix the warning
      web-devicons.enable = true;
      
      # Startup dashboard
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
                on_press = ":Telescope find_files<CR>";
                opts = {
                  keymap = ["n" "f" ":Telescope find_files<CR>" {}];
                  shortcut = "f";
                  position = "center";
                  cursor = 3;
                  width = 38;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              }
              {
                type = "button";
                val = "  New file";
                on_press = ":ene <BAR> startinsert<CR>";
                opts = {
                  keymap = ["n" "n" ":ene <BAR> startinsert<CR>" {}];
                  shortcut = "n";
                  position = "center";
                  cursor = 3;
                  width = 38;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              }
              {
                type = "button";
                val = "  Recent files";
                on_press = ":Telescope oldfiles<CR>";
                opts = {
                  keymap = ["n" "r" ":Telescope oldfiles<CR>" {}];
                  shortcut = "r";
                  position = "center";
                  cursor = 3;
                  width = 38;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              }
              {
                type = "button";
                val = "  Find text";
                on_press = ":Telescope live_grep<CR>";
                opts = {
                  keymap = ["n" "g" ":Telescope live_grep<CR>" {}];
                  shortcut = "g";
                  position = "center";
                  cursor = 3;
                  width = 38;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              }
              {
                type = "button";
                val = "  Config";
                on_press = ":e ~/.config/nixos/<CR>";
                opts = {
                  keymap = ["n" "c" ":e ~/.config/nixos/<CR>" {}];
                  shortcut = "c";
                  position = "center";
                  cursor = 3;
                  width = 38;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              }
              {
                type = "button";
                val = "  Quit";
                on_press = ":qa<CR>";
                opts = {
                  keymap = ["n" "q" ":qa<CR>" {}];
                  shortcut = "q";
                  position = "center";
                  cursor = 3;
                  width = 38;
                  align_shortcut = "right";
                  hl_shortcut = "Keyword";
                };
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
        ];
      };
      
      # Enhanced file explorer
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window = {
          width = 30;
          mappings = {
            "<space>" = "none";
          };
        };
        defaultComponentConfigs = {
          indent = {
            withExpanders = true;
            expanderCollapsed = "";
            expanderExpanded = "";
            expanderHighlight = "NeoTreeExpander";
          };
        };
      };
      
      # Enhanced fuzzy finder
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fr" = "oldfiles";
          "<leader>fc" = "grep_string";
          "<leader>fm" = "marks";
          "<leader>fk" = "keymaps";
          "<leader>fs" = "lsp_document_symbols";
          "<leader>fS" = "lsp_workspace_symbols";
        };
        settings = {
          defaults = {
            mappings = {
              i = {
                "<C-h>" = "which_key";
              };
            };
          };
        };
        extensions = {
          fzf-native.enable = true;
        };
      };
      
      # Enhanced syntax highlighting for all popular languages
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
          # Comprehensive language support
          ensure_installed = [
            # Core
            "nix"
            "lua"
            "vim"
            "vimdoc"
            
            # Web development
            "html"
            "css"
            "javascript"
            "typescript"
            "tsx"
            "json"
            "svelte"
            "vue"
            
            # System languages
            "c"
            "cpp"
            "rust"
            "go"
            "zig"
            
            # High-level languages
            "python"
            "java"
            "kotlin"
            "scala"
            "csharp"
            "php"
            "ruby"
            "elixir"
            "haskell"
            "dart"
            
            # Shell and scripting
            "bash"
            "fish"
            "powershell"
            
            # Configuration and data
            "yaml"
            "toml"
            "xml"
            "json"
            "jsonc"
            "markdown"
            "markdown_inline"
            
            # DevOps
            "dockerfile"
            "terraform"
            "hcl"
            
            # Version control
            "git_config"
            "git_rebase"
            "gitattributes"
            "gitcommit"
            "gitignore"
            
            # Other useful formats
            "regex"
            "sql"
            "graphql"
            "latex"
            "bibtex"
            "comment"
          ];
        };
      };
      
      # Comprehensive LSP setup for all popular languages
      lsp = {
        enable = true;
        servers = {
          # Nix (essential for NixOS users)
          nixd.enable = true;
          
          # System languages
          lua_ls.enable = true;
          
          # Web development (frontend)
          html.enable = true;
          cssls.enable = true;
          ts_ls.enable = true;        # TypeScript/JavaScript
          jsonls.enable = true;
          svelte.enable = true;       # Svelte
          tailwindcss.enable = true;  # Tailwind CSS
          
          # Python
          pyright.enable = true;
          
          # Rust
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          
          # Go
          gopls.enable = true;
          
          # C/C++
          clangd.enable = true;
          
          # Java
          jdtls.enable = true;
          
          # C# (.NET)
          omnisharp.enable = true;
          
          # PHP
          phpactor.enable = true;
          
          # Ruby
          ruby_lsp.enable = true;
          
          # Dart/Flutter
          dartls.enable = true;
          
          # Kotlin
          kotlin_language_server.enable = true;
          
          # Scala
          metals.enable = true;
          
          # Elixir
          elixirls.enable = true;
          
          # Haskell
          hls = {
            enable = true;
            installGhc = true;
          };
          
          # Zig
          zls.enable = true;
          
          # Shell scripting
          bashls.enable = true;
          
          # Configuration files
          yamlls.enable = true;       # YAML
          taplo.enable = true;        # TOML
          lemminx.enable = true;      # XML
          
          # Documentation
          marksman.enable = true;     # Markdown
          
          # DevOps/Docker
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          
          # Terraform
          terraformls.enable = true;
          
          # Ansible
          ansiblels.enable = true;
        };
        
        keymaps = {
          silent = true;
          lspBuf = {
            "gd" = "definition";
            "gD" = "references";
            "gt" = "type_definition";
            "gi" = "implementation";
            "K" = "hover";
          };
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
        };
      };
      
      # Enhanced completion with comprehensive language support
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          sources = [
            { name = "nvim_lsp"; priority = 1000; } # Highest priority for LSP
            { name = "luasnip"; priority = 750; }   # Snippets
            { name = "buffer"; priority = 500; }    # Current buffer
            { name = "path"; priority = 250; }      # File paths
            { name = "emoji"; priority = 100; }     # Emoji completion
          ];
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() elseif require('luasnip').expand_or_jumpable() then require('luasnip').expand_or_jump() else fallback() end end, {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() elseif require('luasnip').jumpable(-1) then require('luasnip').jump(-1) else fallback() end end, {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          window = {
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
              col_offset = -3;
              side_padding = 0;
            };
          };
          formatting = {
            fields = [ "kind" "abbr" "menu" ];
            format = "function(entry, vim_item) vim_item.menu = ({nvim_lsp = '[LSP]', luasnip = '[Snippet]', buffer = '[Buffer]', path = '[Path]', emoji = '[Emoji]'})[entry.source.name] return vim_item end";
          };
        };
      };
      
      # Snippet engine
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };
      
      # Enhanced status line
      lualine = {
        enable = true;
        settings = {
          options = {
            icons_enabled = true;
            theme = "catppuccin";
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = ["filename"];
            lualine_x = ["encoding" "fileformat" "filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
      };
      
      # Buffer line (tabs)
      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
            offsets = [
              {
                filetype = "neo-tree";
                text = "File Explorer";
                text_align = "center";
                separator = true;
              }
            ];
          };
        };
      };
      
      # Git integration
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = { text = "+"; };
            change = { text = "~"; };
            delete = { text = "_"; };
            topdelete = { text = "‾"; };
            changedelete = { text = "~"; };
          };
        };
      };
      
      # Git client
      lazygit.enable = true;
      
      # Terminal integration
      toggleterm = {
        enable = true;
        settings = {
          size = 20;
          open_mapping = "[[<c-\\>]]";
          hide_numbers = true;
          shade_terminals = true;
          start_in_insert = true;
          insert_mappings = true;
          persist_size = true;
          direction = "float";
          close_on_exit = true;
          shell = "zsh";
          float_opts = {
            border = "curved";
            winblend = 10;
          };
        };
      };
      
      # Auto pairs
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
          ts_config = {
            lua = ["string" "source"];
            javascript = ["string" "template_string"];
          };
        };
      };
      
      # Comment support
      comment = {
        enable = true;
        settings = {
          toggler = {
            line = "gcc";
            block = "gbc";
          };
          opleader = {
            line = "gc";
            block = "gb";
          };
        };
      };
      
      # Surround text objects
      nvim-surround.enable = true;
      
      # Enhanced which-key with language-specific groups
      which-key = {
        enable = true;
        settings = {
          preset = "modern";
          delay = 500;
          spec = [
            { __unkeyed-1 = "<leader>f"; group = "Find"; }
            { __unkeyed-1 = "<leader>l"; group = "LSP"; }
            { __unkeyed-1 = "<leader>t"; group = "Terminal"; }
            { __unkeyed-1 = "<leader>g"; group = "Git"; }
            { __unkeyed-1 = "<leader>b"; group = "Buffer"; }
            { __unkeyed-1 = "<leader>r"; group = "Rust"; }
            { __unkeyed-1 = "<leader>p"; group = "Python"; }
            { __unkeyed-1 = "<leader>n"; group = "Nix"; }
          ];
        };
      };
      
      # Indent guides
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          scope = {
            enabled = false;
          };
          exclude = {
            filetypes = [
              "help"
              "alpha"
              "dashboard"
              "neo-tree"
              "Trouble"
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
              "lazyterm"
            ];
          };
        };
      };
      
      # Diagnostics
      trouble = {
        enable = true;
        settings = {
          modes = {
            preview_float = {
              mode = "diagnostics";
              preview = {
                type = "float";
                relative = "editor";
                border = "rounded";
                title = "Preview";
                title_pos = "center";
                position = [0.3 0.4];
                size = { width = 0.3; height = 0.3; };
                zindex = 200;
              };
            };
          };
        };
      };
      
      # Notifications
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000";
          render = "wrapped-compact";
        };
      };
    };
    
    # Additional Lua configuration for enhanced language support
    extraConfigLua = ''
      -- Set up additional keymaps for lazygit
      vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { silent = true, desc = "Open LazyGit" })
      
      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
      
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      
      -- Simple auto-save functionality
      vim.api.nvim_create_autocmd({"FocusLost", "BufLeave"}, {
        pattern = "*",
        callback = function()
          if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
            vim.api.nvim_command('silent! write')
          end
        end,
      })
      
      -- Better search highlighting
      vim.keymap.set("n", "n", "nzzzv", { silent = true })
      vim.keymap.set("n", "N", "Nzzzv", { silent = true })
      vim.keymap.set("n", "*", "*zzzv", { silent = true })
      vim.keymap.set("n", "#", "#zzzv", { silent = true })
      
      -- Language-specific formatting and settings
      
      -- Auto-format on save for supported file types
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = {
          "*.lua", "*.py", "*.rs", "*.go", "*.js", "*.ts", "*.jsx", "*.tsx", 
          "*.java", "*.kt", "*.scala", "*.cs", "*.php", "*.rb", "*.ex", "*.exs",
          "*.hs", "*.zig", "*.nix", "*.json", "*.yaml", "*.yml", "*.toml",
          "*.html", "*.css", "*.scss", "*.vue", "*.svelte"
        },
        callback = function()
          if vim.lsp.buf.format then
            vim.lsp.buf.format()
          end
        end,
      })
      
      -- Language-specific indentation settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "python", "yaml", "yml"
        },
        callback = function()
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
          vim.opt_local.softtabstop = 4
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "go", "rust", "c", "cpp"
        },
        callback = function()
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
          vim.opt_local.softtabstop = 4
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "javascript", "typescript", "json", "html", "css", "vue", "svelte", "nix"
        },
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
        end,
      })
      
      -- Enable spell checking for markdown and text files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "text", "gitcommit" },
        callback = function()
          vim.opt_local.spell = true
          vim.opt_local.spelllang = "en_us"
        end,
      })
      
      -- Highlight yanked text
      vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function()
          vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 500,
          })
        end,
      })
      
      -- Set up file type specific keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          vim.keymap.set("n", "<leader>rr", ":!cargo run<CR>", { buffer = true, desc = "Cargo run" })
          vim.keymap.set("n", "<leader>rt", ":!cargo test<CR>", { buffer = true, desc = "Cargo test" })
          vim.keymap.set("n", "<leader>rb", ":!cargo build<CR>", { buffer = true, desc = "Cargo build" })
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.keymap.set("n", "<leader>gr", ":!go run %<CR>", { buffer = true, desc = "Go run" })
          vim.keymap.set("n", "<leader>gt", ":!go test<CR>", { buffer = true, desc = "Go test" })
          vim.keymap.set("n", "<leader>gb", ":!go build<CR>", { buffer = true, desc = "Go build" })
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.keymap.set("n", "<leader>pr", ":!python %<CR>", { buffer = true, desc = "Python run" })
          vim.keymap.set("n", "<leader>pt", ":!python -m pytest<CR>", { buffer = true, desc = "Python test" })
        end,
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "nix",
        callback = function()
          vim.keymap.set("n", "<leader>nb", ":!nix build<CR>", { buffer = true, desc = "Nix build" })
          vim.keymap.set("n", "<leader>nf", ":!nix flake check<CR>", { buffer = true, desc = "Nix flake check" })
          vim.keymap.set("n", "<leader>nu", ":!nix flake update<CR>", { buffer = true, desc = "Nix flake update" })
        end,
      })
    '';
  };
}
