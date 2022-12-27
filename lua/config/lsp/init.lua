local M = {}

local coq = require "coq"

local lsp_signature = require "lsp_signature"
lsp_signature.setup {
  bind = true,
  handler_opts = {
    border = "rounded",
  },
}

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end


function M.setup()
	require("mason").setup()

	-- require("mason-null-ls").setup{
	-- 	automatic_installation = true,
	-- }

	-- require("config.lsp.null-ls").setup(on_attach)


	local automatic_installation = true
	if vim.loop.os_uname() then
		automatic_installation = { exclude = { "clangd" } }
	end
	require("mason-lspconfig").setup{
		automatic_installation = automatic_installation,
	}

	require "neodev".setup()

	require"lspconfig".sumneko_lua.setup{
		-- coq.lsp_ensure_capabilities{
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Setup your lua path
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = {
							[vim.fn.expand "$VIMRUNTIME/lua"] = true,
							[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
						},
						checkThirdParty = false,
					},
				},
			}
		-- }
	}

	require 'lspconfig'.clangd.setup{
		-- coq.lsp_ensure_capabilities{
			on_attach = on_attach,
			capabilities = {offsetEncoding = "utf-8"},
		-- }
	}

end

return M
