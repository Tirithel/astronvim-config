local api = vim.api

return {
  {
    "mfussenegger/nvim-jdtls",
    lazy = true,
    ft = { "java" },
    config = function(_, opts)
      -- local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      local nvim_jdtls_group = api.nvim_create_augroup("nvim-jdtls", { clear = true })
      api.nvim_create_autocmd("Filetype", {
        pattern = "java", -- autocmd to start jdtls
        callback = function()
          opts.root_dir =
            vim.fs.dirname(vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, { upward = true })[1])
          opts.cmd = { require("mason-registry").get_package("jdtls"):get_install_path() .. "/bin/jdtls" }
          require("jdtls").start_or_attach(opts)
        end,
        group = nvim_jdtls_group,
      })
    end,
  },
}
