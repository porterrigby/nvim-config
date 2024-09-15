return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ensure_installed = { "goimports", "gofumpt", "gomodifytags", "impl", "delve" },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                -- Lsp to install
                ensure_installed = { "lua_ls", "clangd", "pyre", "jdtls", --[["tsserver"--]] },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Set up each language server


            local lsp_zero = require("lsp-zero")
            local lspconfig = require("lspconfig")

            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.pyre.setup({
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({ -- currently handled via nvim-jdtls?
                capabilities = capabilities,
                autostart = true,
                filetypes = { "java "}
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
                autostart = true,
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                },
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({})
            lspconfig.jedi_language_server.setup({})
            lspconfig.pylsp.setup({})
        end,
    },
    {
        "VonHeikemen/lsp-zero.nvim"
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
}
