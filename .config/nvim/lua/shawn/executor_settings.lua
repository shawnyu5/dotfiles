-- reload this package
package.loaded["executor"] = nil

local ok, executor = pcall(require, "executor")
if not ok then
   vim.notify("executor not installed", vim.log.levels.WARN)
   return
end

executor.setup({
   commands = {
      cpp = {
         "make",
         "g++ % && ./a.out",
      },
      c = {
         "make",
         "g++ % && ./a.out",
      },
      python = {
         "python3 %",
      },
      javascript = {
         -- "npm start",
         "nodemon --delay 1 %",
      },
      typescript = {
         "npm start",
         "nodemon %",
         extern = true,
      },
      sh = {
         "bash %",
      },
      vim = {
         "source %",
         extern = false,
      },
      lua = {
         "luafile %",
         extern = false,
      },
      markdown = {
         -- "mdp %",
         "MarkdownPreview",
         -- "PeekToggle",
         extern = false,
      },
      java = {
         "make",
         "java %",
      },
      html = {
         "!google-chrome-stable %",
         extern = false,
      },
      go = {
         "go run .",
         "go test",
         extern = true,
      },
      rust = {
         "cargo run",
      },
      dockerfile = {
         "docker build .",
      },
      cs = {
         "dotnet run",
         extern = true,
      },
   },
   default_mappings = true,
   always_exit = false,
   insert_on_enter = false, -- enter insert mode on entering a terminal
   dependency_commands = {
      make = "Makefile",
      ["npm start"] = "package.json",
   },
})
