-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--
local lspconfig = require('lspconfig') -- for debuging finding correct .git in project root 
local util = require('lspconfig.util') -- for debuging finding correct .git in project root 

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  -- Pyright is kept here to provide LSP features such as go-to-definition, hover, signature help, and references.
  -- All type checking, linting, formatting, and import organization are delegated to Ruff LSP (see ruff_lsp entry below).
  -- The 'ignore = { "*" }' setting disables Pyright's own diagnostics and type checking.
  -- If you want Pyright to provide type checking as well, remove or comment out the 'ignore' line below.
  pyright = {
    settings = {
      python = {
        analysis = {
          diagnosticMode = "openFilesOnly",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          -- typeCheckingMode = "basic",
          ignore = { '*' }, -- disables Pyright's own analysis; Ruff LSP handles linting/type checking
        }
      },
      disableOrganizeImports = true, -- Ruff LSP will handle import organization
    },
    root_dir = function(fname)-- debugs out of memory error by finding correct .git in project root 
      local root = util.root_pattern('.git')(fname)
      local home = os.getenv('HOME')
      if root and root ~= home and not root:match('^' .. home .. '/?$') then
        return root
      end
      -- Fallback to project markers
      root = util.root_pattern('Pipfile', 'pyproject.toml', 'setup.py', 'requirements.txt')(fname)
      if root and root ~= home and not root:match('^' .. home .. '/?$') then
        return root
      end
      -- As a last resort, use the directory of the file
      return util.path.dirname(fname)
    end
  },
  ruff = {
    init_options = {
      settings = {
        -- Enable formatting and organize imports
        format = { preview = true },
        -- You can add more Ruff settings here if needed
      }
    },
    -- (Optional) Disable hover if you want Pyright to handle it
    on_attach = function(client, _)
      client.server_capabilities.hoverProvider = false
    end,
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

-- Simple mason-lspconfig setup without ensuring installation
-- (installation is now handled in init.lua for clarity)
mason_lspconfig.setup {}

-- Manual setup for each server
for server_name, server_opts in pairs(servers) do
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = server_opts.filetypes,
  }
  -- Merge in any other top-level keys (like settings, root_dir, etc.)
  for k, v in pairs(server_opts) do
    opts[k] = v
  end
  require('lspconfig')[server_name].setup(opts)
end


