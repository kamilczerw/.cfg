return {
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "select",
      })
    end,
  },
}
