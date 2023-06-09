local Terminal = require("toggleterm.terminal").Terminal
local k9s = Terminal:new { cmd = "k9s", hidden = true }

function K9sToggle() k9s:toggle() end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>uU"] = { "<Cmd>UndotreeToggle<CR>", desc = "Undotree Toggle" },
    ["<leader>uk"] = { "<Cmd>lua K9sToggle()<CR>", desc = "K9s Toggle" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = { "<Cmd>ToggleTerm<CR>" },
    ["C-h"] = { "<Cmd>ToggleTerm<CR>" },
  },
}
