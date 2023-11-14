local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.mypy.with({
        extra_args = function()
        local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
        if os.getenv("CONDA_DEFAULT_ENV")
            then anaconda_path = os.getenv("HOME") .. "/anaconda3/envs/" .. virtual
            print(anaconda_path)
            else anaconda_path = ""
        end
        return {"--python-executable", anaconda_path  .. "/bin/python"} --,  "--explicit-package-bases", anaconda_path}
        end,
        }),
        --[[ null_ls.builtins.diagnostics.ruff, ]]
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        --null_ls.builtins.diagnostics.eslint,
        --null_ls.builtins.completion.spell,
    },
})
