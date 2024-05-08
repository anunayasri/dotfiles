local function hello()
  return [[hello world]]
end

local current_treesitter_context = function()
  if not packer_plugins["nvim-treesitter"] or packer_plugins["nvim-treesitter"].loaded == false then
    return " "
  end
  local f = require'nvim-treesitter'.statusline({
    indicator_size = 300,
    type_patterns = {"class", "function", "method", "interface", "type_spec", "table", "if_statement", "for_statement", "for_in_statement"}
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  if context == "vim.NIL" then
    return " "
  end
  return " " .. context

end

require('lualine').setup({
  sections = { 
    lualine_x = {require'nvim-treesitter'.statusline} 
  }
})


-- require('lualine').setup()
