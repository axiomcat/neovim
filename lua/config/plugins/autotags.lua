-- File: lua/custom/plugins/autopairs.lua

return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("nvim-ts-autotag").setup {}
  end,
}
