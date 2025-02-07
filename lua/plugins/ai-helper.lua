-- ~/.config/nvim/lua/plugins/ai-prompt.lua

return {
    -- 本地插件配置
    {
        "aidoki/aice_craft.nvim", -- 插件名称（可以自定义）
        -- dir = "haoliplus/ai-helper", -- 本地插件目录路径
        -- dev = true, -- 标记为开发模式
        config = function()
            -- dummy_prompts = require("aice_craft.prompts")
            require("aice_craft").setup({
                api_key = os.getenv("DEEPSEEK_API_KEY"),
                prompts = {
                    ["改进代码"] = "请改进以下代码，并说明改进原因：",
                    ["代码解释"] = "请解释以下代码的功能：",
                    ["翻译"] = "请将以下内容翻译成英文：",
                    -- 添加更多自定义 prompts
                }
            })
        end,
        -- 声明依赖
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- 可选：添加键位映射
        keys = {
            { "<leader>ai", mode = "v", desc = "AI Prompt" }
        },
        -- 可选：添加命令
        cmd = { "AIPrompt" },
    }
}

