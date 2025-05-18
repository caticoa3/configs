local null_ls = require("null-ls")
--local utils = require("null-ls.utils")
--local d = utils.root_pattern("mypy.ini")

--for key,value in pairs(d) do
--    print('k'..key..'value'..value)
--end

-- Simplify to just handle formatting
null_ls.setup({
    debug = false, -- Set to false to reduce noise
    sources = {
        -- Only use none-ls for formatting
        -- null_ls.builtins.formatting.black,  -- Commented out as not currently used
    }
})
