return {
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    config = function(_, _)
      require("telescope").load_extension "harpoon"

      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then return end

      local mappings = {
        h = {
          desc = " Harpoon",
          a = { "<Cmd>lua require('harpoon.mark').add_file()<CR>", " Add" },
          m = { "<Cmd>Telescope harpoon marks<CR>", " Selection Menu" },
          u = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", " Update Menu" },
          ["1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Goto 1" },
          ["2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Goto 2" },
          ["3"] = { "<Cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Goto 3" },
          ["4"] = { "<Cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Goto 4" },
        },
      }

      which_key.register(mappings, {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
      })
    end,
  },
}
