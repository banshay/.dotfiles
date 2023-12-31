-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name
local home_dir = vim.fs.normalize("~")

local config = {
   -- The command that starts the language server
   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
   cmd = {

      -- 💀
      home_dir .. "/.sdkman/candidates/java/current/bin/java",
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.

      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx2g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-javaagent:' .. home_dir .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',

      --
      '-jar',
      home_dir ..
      '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
      -- Must point to the                                                     Change this to
      -- eclipse.jdt.ls installation                                           the actual version


      -- 💀
      '-configuration', home_dir .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
      -- Must point to the                      Change to one of `linux`, `win` or `mac`
      -- eclipse.jdt.ls installation            Depending on your system.


      -- 💀
      -- See `data directory configuration` section in the README
      '-data', workspace_dir,
   },

   -- 💀
   -- This is the default if not provided, you can remove it. Or adjust as needed.
   -- One dedicated LSP server & client will be started per unique root_dir
   root_dir = require('jdtls.setup').find_root({ '.git' }),

   -- Here you can configure eclipse.jdt.ls specific settings
   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
   -- for a list of options
   settings = {
      java = {
         referenceCodeLens = {
            enabled = false,
         },
         references = {
            includeAccessors = true,
            includeDecompiledSources = true,
         },
         saveActions = {
            organizeImports = true,
         },
      }
   },

   -- Language server `initializationOptions`
   -- You need to extend the `bundles` with paths to jar files
   -- if you want to use additional eclipse.jdt.ls plugins.
   --
   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
   --
   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
   init_options = {
      bundles = {}
   },

   on_attach = require("lsp_keymaps"),
}


-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
