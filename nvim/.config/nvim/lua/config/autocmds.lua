vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    callback = function()
        if require("nvim-treesitter.parsers").has_parser() then
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        else
            vim.opt.foldmethod = "syntax"
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- defaults:
        -- https://neovim.io/doc/user/news-0.11.html#_defaults

        local telescope = require("telescope.builtin")

        map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        -- map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        -- map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
        -- map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("<leader>lf", vim.lsp.buf.format, "Format")
        map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
        map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        -- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            -- When cursor stops moving: Highlights all instances of the symbol under the cursor
            -- When cursor moves: Clears the highlighting
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            -- When LSP detaches: Clears the highlighting
            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                end,
            })
        end
    end,

})


vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function()
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.foldenable = true
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "json", "go", "lua", "ts" },
    callback = function()
        vim.opt_local.foldmethod = "syntax"
        vim.opt.foldenable = true
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "js", "ts", "typescript", "deno" },
    callback = function()
        vim.opt_local.foldmethod = "indent"
        vim.opt.foldenable = true
    end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

local is_tab = true

vim.api.nvim_create_user_command("ToggleTabBufferKeymap", function()
    is_tab = not is_tab
    if is_tab then
        vim.keymap.set("n", "<C-n>", "gt")
        vim.keymap.set("n", "<C-p>", "gT")
    else
        vim.keymap.set("n", "<C-n>", ":bn<CR>")
        vim.keymap.set("n", "<C-p>", ":bp<CR>")
    end
end, {})
