{ pkgs, ... }: {
  # Special nixified version of neovim. Source: https://github.com/nix-community/nixvim
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      updatetime = 100;

      number = true;
      relativenumber = true;
      cursorline = true;
      ruler = true;
      scrolloff = 4;
      autoindent = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
      settings.transparent_background = true;
    };

    plugins = {
      luasnip.enable = true;
      bufferline.enable = true;
      nvim-autopairs.enable = true;
      telescope.enable = true;
      oil.enable = true;
      lualine.enable = true;
      neo-tree.enable = true;
      treesitter.enable = true;
    };

    plugins.lsp = {
      enable = true;
      servers = {
	bashls.enable = true;
	clangd.enable = true;
	java-language-server.enable = true;
	lua-ls.enable = true;
	nil-ls.enable = true;
	pyright.enable = true;
	tsserver.enable = true;
	#rust-analyzer.enable = true;
      };
    };

    plugins.copilot-lua = {
      enable = true;
      suggestion.enabled = false;
      panel.enabled = false;
      filetypes = {
        yaml = false;
        markdown = false;
        help = false;
        gleam = false; # Copilot doesn't really help when writing Gleam
        gitcommit = false;
        gitrebase = false;
        hgcommit = false;
        svn = false;
        cvs = false;
        "." = false;
      };
    };


    plugins.cmp-buffer = { enable = true; };

    plugins.cmp-emoji = { enable = true; };

    plugins.cmp-nvim-lsp = { enable = true; };

    plugins.cmp-path = { enable = true; };

    plugins.cmp_luasnip = { enable = true; };

    plugins.cmp = {
      enable = true;

      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "nvim_lua"; }
          { name = "path"; }
          { name = "copilot"; }
        ];

        formatting = {
          fields = [ "abbr" "kind" "menu" ];
          format =
            # lua
            ''
              function(_, item)
                local icons = {
                  Namespace = "󰌗",
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰆧",
                  Constructor = "",
                  Field = "󰜢",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈚",
                  Reference = "󰈇",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "󰙅",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "󰊄",
                  Table = "",
                  Object = "󰅩",
                  Tag = "",
                  Array = "[]",
                  Boolean = "",
                  Number = "",
                  Null = "󰟢",
                  String = "󰉿",
                  Calendar = "",
                  Watch = "󰥔",
                  Package = "",
                  Copilot = "",
                  Codeium = "",
                  TabNine = "",
                }

                local icon = icons[item.kind] or ""
                item.kind = string.format("%s %s", icon, item.kind or "")
                return item
              end
            '';
        };

        window = {
          completion = {
            winhighlight =
              "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
            scrollbar = false;
            sidePadding = 0;
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
          };

          settings.documentation = {
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            winhighlight =
              "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
          };
        };

        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" =
            "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
          "<Tab>" =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
          "<S-Tab>" =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
        };
      };
    };
  };
  home.sessionVariables = { EDITOR = "nvim"; };
}
