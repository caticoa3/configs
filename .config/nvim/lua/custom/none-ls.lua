local null_ls = require("null-ls")
--local utils = require("null-ls.utils")
--local d = utils.root_pattern("mypy.ini")

--for key,value in pairs(d) do
--    print('k'..key..'value'..value)
--end

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.diagnostics.mypy.with({
	-- each python environment should have mypy installed
        -- don't run without vim.g.python3_host_prog environment; set in init.lua 
        condition = function() return vim.g.python3_host_prog ~= nil end,
        -- milliseconds
        timeout = -1, --a negavite number prevents timeout
        --multiple_files = false,
        --[[extra_args = function()
           [    if vim.g.python3_host_prog ~= nil then
           [        return "--python-executable " .. vim.g.python3_host_prog
           [    end
           [end]]
        }),
        --null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        --null_ls.builtins.code_actions.proselint,
        --null_ls.builtins.diagnostics.ruff,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    }
})
