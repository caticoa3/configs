local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.mypy.with({
        extra_args = function()
        --[[ local virtual = os.getenv("VIRTUAL_ENV") or "/usr" ]]
        if os.getenv("CONDA_PREFIX") then 
            anaconda_path = os.getenv("HOME") .. "/anaconda3/envs/" .. os.getenv("CONDA_PREFIX")
            print(anaconda_path)
            return {"--python-executable", anaconda_path  .. "/bin/python"} --,  "--explicit-package-bases", anaconda_path}
        elseif os.getenv("VIRTUAL_ENV") then
            return {"--python-executable", os.getenv("VIRTUAL_ENV") .. "/bin/python"}
        end
        end,
        }),
        --[[ null_ls.builtins.diagnostics.ruff, ]]
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    },
})
