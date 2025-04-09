-- [[ Configure nvim-cmp and LuaSnip ]]
-- This file contains:
-- 1. Detailed configuration for nvim-cmp (completion)
--    - Mappings, formatting, sources, etc.
--    - Basic initialization is done in init.lua
-- 2. Configuration for LuaSnip (snippets)
--    - Loading snippets from friendly-snippets
--    - Custom snippet definitions
-- See `:help cmp` and `:help luasnip`

if vim.g.vscode then
  return  -- Exit early if we're in Cursor
end

local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

-- Disable jsregexp warning since we don't use transformations
vim.g.luasnip_no_lsp_snippets_transformations = true

-- Define snippet helpers
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

require('luasnip.loaders.from_vscode').lazy_load() --lazy_load({paths='../luasnippets'})

luasnip.config.setup {}

-- Add custom snippets
luasnip.add_snippets("python", {
  -- Trigger with 'fp' (f-print)
  s("fp", {
    t("print(f'{"),
    i(1, "var"),  -- First placeholder
    t("=}')"),    -- Added curly braces
  }),
})

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "󰊄",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "󰌆",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "󰉺",
}

-- Configure the completion behavior for nvim-cmp
-- This overrides the empty setup from init.lua with our detailed configuration
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path'},
    -- { name = 'ultisnips' }, -- For ultisnips users.
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  }
}