--[[ local none_ls = require('none-ls') ]]

--[[ local opts = {
   [     sources = {
   [         none_ls.builtins.diagnostics.mypy,
   [         none_ls.builtins.diagnostics.ruff,
   [     }
   [ }
   [ return opts ]]

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    },
})
