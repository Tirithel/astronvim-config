return {
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    config = function(_, _)
      require("telescope").load_extension "harpoon"

      local status_ok, which_key = pcall(require, "which-key")
      if not status_ok then return end

      local mappings = {
        j = {
          desc = " Jump Harpoon",
          a = { "<Cmd>lua require('harpoon.mark').add_file()<CR>", " Add" },
          m = { "<Cmd>Telescope harpoon marks<CR>", " Selection Menu" },
          u = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", " Update Menu" },
          t = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<CR>", " Terminal" },
          ["1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1)<CR>", " 1" },
          ["2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2)<CR>", " 2" },
          ["3"] = { "<Cmd>lua require('harpoon.ui').nav_file(3)<CR>", " 3" },
          ["4"] = { "<Cmd>lua require('harpoon.ui').nav_file(4)<CR>", " 4" },
          -- p = { "<Cmd>lua require('harpoon.ui').nav_prev()<CR>", "Previous" },
          -- n = { "<Cmd>lua require('harpoon.ui').nav_next()<CR>", "Next" },
        },
      }

      which_key.register(mappings, {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
      })
    end,
  },
}
