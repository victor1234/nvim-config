local M = {}

function M.setup()
	local dap = require'dap'

	dap.adapters.lldb = {
		type = 'executable',
		command = '/usr/bin/lldb-vscode-11',
		name = "lldb"
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},
			runInTerminal = false,
		},
	}

end

return M

