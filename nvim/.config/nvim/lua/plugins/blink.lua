return {
    { "L3MON4D3/LuaSnip", keys = {} },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            -- {
            --     "L3MON4D3/LuaSnip",
            --     build = (function()
            --         -- Build Step is needed for regex support in snippets.
            --         -- This step is not supported in many windows environments.
            --         -- Remove the below condition to re-enable on windows.
            --         if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            --             return
            --         end
            --         return "make install_jsregexp"
            --     end)(),
            --     dependencies = {
            --         -- `friendly-snippets` contains a variety of premade snippets.
            --         --    See the README about individual language/framework/plugin snippets:
            --         --    https://github.com/rafamadriz/friendly-snippets
            --         -- {
            --         --   'rafamadriz/friendly-snippets',
            --         --   config = function()
            --         --     require('luasnip.loaders.from_vscode').lazy_load()
            --         --   end,
            --         -- },
            --     },
            -- },
            -- "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            -- "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-path",
        },
        version = "*",
        config = function()
            require("blink.cmp").setup({
                snippets = { preset = "luasnip" },
                signature = { enabled = true },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "normal",
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                    providers = {
                        cmdline = {
                            min_keyword_length = 2,
                        },
                    },
                },
                keymap = {
                    ["<C-f>"] = {},
                    -- ["<CR>"] = { "accept_and_enter", "fallback" },
                },
                cmdline = {
                    enabled = false,
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        -- ["<CR>"] = { "accept_and_enter", "fallback" },
                    },
                },
                completion = {
                    menu = {
                        border = nil,
                        scrolloff = 1,
                        scrollbar = false,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label",      "label_description", gap = 1 },
                                { "kind" },
                                { "source_name" },
                            },
                        },
                    },
                    documentation = {
                        window = {
                            border = nil,
                            scrollbar = false,
                            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                        },
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
