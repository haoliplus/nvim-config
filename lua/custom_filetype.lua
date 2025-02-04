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
