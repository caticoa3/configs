local null_ls = require("null-ls")
--local utils = require("null-ls.utils")
--local d = utils.root_pattern("mypy.ini")

--for key,value in pairs(d) do
--    print('k'..key..'value'..value)
--end

null_ls.setup({
    debug = true,
    sources = {
        -- Python formatting
        null_ls.builtins.formatting.black,
        -- Python linting
        null_ls.builtins.diagnostics.ruff,
        --null_ls.builtins.diagnostics.mypy,
        --null_ls.builtins.formatting.stylua,
        --null_ls.builtins.code_actions.proselint,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    }
})
