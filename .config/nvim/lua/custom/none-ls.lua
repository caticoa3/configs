local null_ls = require("null-ls")
print("testing printing in none-ls.lua")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy.with({
        extra_args = function()
            if os.getenv("CONDA_PREFIX") then -- conda env is active
                local anaconda_path = os.getenv("HOME") .. "/anaconda3/envs/" .. os.getenv("CONDA_DEFAULT_ENV")
                print(anaconda_path)
                return {"--python-executable", anaconda_path  .. "/bin/python"} --,  "--explicit-package-bases", anaconda_path}
            elseif os.getenv("VIRTUAL_ENV") then
                print(os.getenv("VIRTUAL_ENV"))
                return {"--python-executable", os.getenv("VIRTUAL_ENV") .. "/bin/python"}
            end
        end
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.proselint,
        --null_ls.builtins.diagnostics.ruff,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    },
})
