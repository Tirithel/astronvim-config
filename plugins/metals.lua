local api = vim.api

function AttachDebugger()
  local dap = require "dap"

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "run or test file",
      metals = {
        runType = "runOrTestFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "test target",
      metals = {
        runType = "testTarget",
      },
    },
  }

  dap.continue()
end

return {
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt" },
    opts = {
      settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      },
      init_options = {
        statusBarProvider = "on",
      },
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = function(_, _) require("metals").setup_dap() end,
    },
    config = function(_, opts)
      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
      api.nvim_create_autocmd("FileType", {
        -- NOTE: You may or may not want java included here. You will need it if you
        -- want basic Java support but it may also conflict if you are using
        -- something like nvim-jdtls which also works on a java filetype autocmd.
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(opts)

          local status_ok, which_key = pcall(require, "which-key")
          if not status_ok then return end

          local mappings = {
            -- adding debug attach to Debug menu
            ["da"] = { "<Cmd>lua AttachDebugger()<CR>", "Attach Metals Debugger" },
            -- adding rename to LSP menu
            ["lr"] = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
          }

          which_key.register(mappings, {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
          })

          vim.keymap.set("n", ",", "<cmd>lua vim.lsp.buf.code_action()<CR>")
          vim.keymap.set("n", ".", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
          vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations)
          vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions)
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
