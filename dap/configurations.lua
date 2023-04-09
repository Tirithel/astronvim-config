return {
  scala = {
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
  },
}
