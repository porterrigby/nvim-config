return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "java", "python", "c", "bash", "go", "gomod", "gowork", "gosum" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
