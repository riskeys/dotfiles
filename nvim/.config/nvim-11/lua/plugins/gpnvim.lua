return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            -- For customization, refer to Install > Configuration in the Documentation/Readme
            providers = {
                openai = {
                    disable = false,
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = os.getenv("OPENAI_API_KEY"),
                },

                -- azure = {...},

                -- copilot = {
                --     endpoint = "https://api.githubcopilot.com/chat/completions",
                --     secret = {
                --         "bash",
                --         "-c",
                --         "cat ~/.config/github-copilot/hosts.json | sed -e 's/.oauth_token...//;s/".//'",
                --     },
                -- },
                --
            },
            agents = {
                {
                    name = "ChatGPT-3.5 yo",
                    model = { model = "gpt-3.5-turbo" },
                    chat = true,
                    command = true,
                    provider = "openai",
                    temperature = 0.7,
                    system_prompt = "You are a helpful AI assistant.",
                },
                {
                    name = "ChatGPT-4o yo",
                    model = { model = "gpt-4o" },
                    chat = true,
                    command = true,
                    provider = "openai",
                    temperature = 0.7,
                    system_prompt = "You are a helpful AI assistant.",
                },
            },
        }
        require("gp").setup(conf)
    end
}
