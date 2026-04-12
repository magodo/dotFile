return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        -- Auto-install parsers and enable treesitter highlight/indent per filetype.
        -- See: https://github.com/nvim-treesitter/nvim-treesitter/discussions/7927
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '*' },
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)
                if not vim.treesitter.language.add(lang) then
                    local available = vim.g.ts_available or require('nvim-treesitter').get_available()
                    if not vim.g.ts_available then
                        vim.g.ts_available = available
                    end
                    if vim.tbl_contains(available, lang) then
                        require('nvim-treesitter').install(lang)
                    end
                end
                if vim.treesitter.language.add(lang) then
                    vim.treesitter.start(args.buf, lang)
                    -- Treesitter's indent is not working properly for many file types, comment it out.
                    -- vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
