local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy.with({
	-- each python environment should have mypy installed
        -- don't run without vim.g.python3_host_prog environment; set in init.lua 
        condition = function() return vim.g.python3_host_prog ~= nil end,
        --[[extra_args = function(_)
           [    if vim.g.python3_host_prog ~= nil then
           [        return "--python-executable " .. vim.g.python3_host_prog
           [    end
           [end]]
        }),
        --[[null_ls.builtins.formatting.black,]]
        null_ls.builtins.formatting.stylua,
        --[[null_ls.builtins.code_actions.proselint,]]
        --null_ls.builtins.diagnostics.ruff,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    },
})
