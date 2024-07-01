vim.filetype.add({
  filename = {
    ["this_is_a_speci"] = "yaml",
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
