local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require("cmp")

local handlers = require('nvim-autopairs.completion.handlers')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done({
    filetypes = {
      ["*"] = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          handler = handlers["*"]
        }
      },
      lua = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method
          },
          handler = function(char, item, bufnr, rules, commit_character)
          end
        }
      },
      tex = false
    }
  })
)

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<tab>'] = cmp.mapping.confirm({ select = true }),
	}),

	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }
	}, {
		{ name = 'buffer' }
	})
})
