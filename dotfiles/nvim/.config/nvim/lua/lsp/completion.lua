local cmp = require("cmp")

local select_behavior = {
  behavior = cmp.SelectBehavior.Select,
}
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == "nvim_lsp" then
        local emmet_prefixes = { "Em|", "⚡ " }
        -- local client = entry.source.source.client -- Less Robust
        local completion_item = entry.completion_item -- More Robust

        -- Gave an example for diff layouting:
        --
        --     -- html:5~    Em    Text
        --     vim_item.kind = "Em"
        --     vim_item.menu = "Text"
        -- OR
        --     -- html:5~   ⚡ Text
        --     vim_item.kind = "⚡ " .. vim_item.kind
        --
        -- if client and client.name == "emmet_language_server" then -- Less Robust
        --   vim_item.kind = emmet_prefixes[1] .. vim_item.kind
        -- end
        if completion_item.detail -- More Robust
          and completion_item.detail:lower():match("emmet")
        then
          vim_item.kind = emmet_prefixes[2] .. vim_item.kind
        end
      end

      return vim_item
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(select_behavior),
    ["<C-n>"] = cmp.mapping.select_next_item(select_behavior),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})



-- NOTE: The following is reference
--
-- formatting = {
--   format = function(entry, vim_item)
--     local item = entry.completion_item
--
--     local is_emmet =
--       (item.detail and item.detail:match("Emmet"))
--       or (
--         item.labelDetails
--         and item.labelDetails.description
--         and item.labelDetails.description:match("Emmet")
--       )
--
--     if is_emmet then
--       vim_item.kind = "Em|" .. vim_item.kind
--     end
--
--     return vim_item
--   end,
-- },
