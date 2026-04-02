local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local function template_list(opts)
  opts = opts or {}
  local template = require("local_template")
  local list = template.get_temp_list()
  if opts.filter_ft then
    return list[vim.bo.filetype] or {}
  end

  local results = {}
  for _, items in pairs(list) do
    vim.list_extend(results, items)
  end
  table.sort(results)
  return results
end

local function find_template(opts)
  opts = opts or {}
  local filter_ft = opts.filter_ft
  if filter_ft == nil then
    filter_ft = opts.type == "insert"
  end

  local results = template_list({ filter_ft = filter_ft })
  local picker = {
    prompt_title = "find in templates",
    results_title = "templates",
    finder = finders.new_table({
      results = results,
      entry_maker = make_entry.gen_from_file(opts),
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }

  if opts.type then
    picker.attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local name = vim.fn.fnamemodify(selection[1], ":t:r")
        vim.cmd("Template " .. name)
      end)
      return true
    end
  end

  pickers.new(opts, picker):find()
end

return telescope.register_extension({
  exports = {
    find_template = find_template,
  },
})
