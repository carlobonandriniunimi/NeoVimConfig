-- Setting up diagnostics icons
local signs = require("plugins.configs.defaults").icons.diagnostics
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Use LspAttach autocommand to only map the following keys
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gl", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end)
	end,
})

-- Best lua completitions
require("neodev").setup({})

-- Mason settings
require("mason").setup({
	ensure_installed = { "lua-language-server", "stylua" }, -- not an option from mason.nvim
	PATH = "skip",
	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
	max_concurrent_installers = 10,
})

-- Options for lsp
local opts = {
	ensure_installed = { "pyright", "erlangls" },
	diagnostics = {
		underline = true,
		update_in_insert = false,
		virtual_text = {
			spacing = 4,
			-- only show sources name if multiple available
			-- source = "if_many",
			-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
			-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
			-- See function below
			-- prefix = "icons",
		},
		-- Show error -> warning -> info
		severity_sort = true,
	},
	-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
	-- Be aware that you also will need to properly configure your LSP server to
	-- provide the inlay hints.
	inlay_hints = {
		enabled = false,
	},
	capabilities = {},
	servers = {
		ocamllsp = {
			mason = false,
		},
		pyright = {
			-- mason = false,
		},
		lua_ls = {
			-- mason = false, -- set to false if you don't want this server to be installed with mason-lspconfig
			-- Use this to add any additional keymaps
			-- for specific lsp servers
			-- keys = {},
			settings = {
				Lua = {
					workspace = {
						-- Removes the loading workspace message
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
					hint = {
						-- Enables type hints if true in lsp config
						enable = true,
					},
				},
			},
		},
	},
	-- you can do any additional lsp server setup here
	-- return true if you don't want this server to be setup with lspconfig
	setup = {
		-- example to setup with typescript.nvim
		-- tsserver = function(_, opts)
		--   require("typescript").setup({ server = opts })
		--   return true
		-- end,
		-- Specify * to use this function as a fallback for any server
		-- ["*"] = function(server, opts) end,
	},
}

-- Use inlay hints if opts.inlay_hints.enabled = true
local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
if opts.inlay_hints.enabled and inlay_hint then
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.supports_method("textDocument/inlayHint") then
				inlay_hint(buffer, true)
			end
		end,
	})
end

-- If virtual_text.prefix = "icons" put diagnostic icons
if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
	opts.diagnostics.virtual_text.prefix = function(diagnostic)
		local icons = require("plugins.configs.defaults").icons.diagnostics
		for d, icon in pairs(icons) do
			if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
				return icon
			end
		end
	end
end

-- Merge diagnostics opts into vim
vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

-- Server capabilities
local servers = opts.servers
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	has_cmp and cmp_nvim_lsp.default_capabilities() or {},
	opts.capabilities or {}
)

local function setup(server)
	local server_opts = vim.tbl_deep_extend("force", {
		---@diagnostic disable-next-line: param-type-mismatch
		capabilities = vim.deepcopy(capabilities),
	}, servers[server] or {})

	-- additional setup
	if opts.setup[server] then
		if opts.setup[server](server, server_opts) then
			return
		end
	elseif opts.setup["*"] then
		if opts.setup["*"](server, server_opts) then
			return
		end
	end
	require("lspconfig")[server].setup(server_opts)
end

local have_mason, mlsp = pcall(require, "mason-lspconfig")
local all_mslp_servers = {}
if have_mason then
	all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
end

local ensure_installed = opts.ensure_installed
for server, server_opts in pairs(servers) do
	if server_opts then
		server_opts = server_opts == true and {} or server_opts
		-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
		if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
			setup(server)
		else
			ensure_installed[#ensure_installed + 1] = server
		end
	end
end

if have_mason then
	mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
end
