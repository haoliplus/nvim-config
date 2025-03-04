vim.filetype.add({
  filename = {
    ["this_is_a_speci"] = "yaml",
    ["/etc/sing-box/config.json"] = "jsonc",
    ["/etc/sing-box/basic.json"] = "jsonc",
    ["/etc/sing-box/dns.json"] = "jsonc",
    ["/etc/sing-box/inbounds.json"] = "jsonc",
    ["/etc/sing-box/outbounds.json"] = "jsonc",
    ["/etc/sing-box/rules.json"] = "jsonc",
    [".kube/config"] = "yaml",
    -- ['a.sh'] = 'yaml',
  },
  pattern = {
    [".*%.h"] = "cpp",
    [".*%.sh"] = "bash",
    [".*%.html"] = "html",
    [".*%.mock"] = "text",
    [".*%.cfg"] = "cfg",
    -- A pattern containing an environment variable
    ["${XDG_CONFIG_HOME}/foo/git"] = "git",
    ["README.(a+)$"] = function(_, _, ext)
      if ext == "md" then
        return "markdown"
      elseif ext == "rst" then
        return "rst"
      end
    end,
  },
})

-- Only for my specifical config file
vim.api.nvim_create_autocmd("FileType", {
  desc = "yaml config",
  pattern = "yaml",
  -- group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
  callback = function(_)
    vim.opt.cursorcolumn = false
  end,
})
-- 为 JSON 文件添加 JSONC 检测
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.json",
  callback = function()
    -- 获取第一行内容
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

    -- 检查第一行是否以注释开头
    if first_line and (first_line:match("^%s*//") or first_line:match("^%s*/%*")) then
      -- 如果是注释，设置文件类型为 jsonc
      vim.bo.filetype = "jsonc"
    else
      -- 如果不是注释，保持为 json
      vim.bo.filetype = "json"
    end
  end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Format python",
  pattern = "python",
  -- group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
  callback = function(_)
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end,
})
