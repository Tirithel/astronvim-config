return {
  {
    "mbbill/undotree",
    lazy = false,
    config = function()
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
      vim.opt.undofile = true
    end,
  },
}
