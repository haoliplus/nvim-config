local api = vim.api
local util = vim.lsp.util
-- https://github.com/neovim/neovim//runtime/lua/vim/lsp/handlers.lua
local handlers = vim.lsp.handlers
local log = vim.lsp.log

---@private
--- Jumps to a location. Used as a handler for multiple LSP methods.
---@param _ (not used)
---@param result (table) result of LSP method; a location or a list of locations.
---@param ctx (table) table containing the context of the request, including the method
---(`textDocument/definition` can return `Location` or `Location[]`
local function raw_location_handler(_, result, ctx, config)
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(ctx.method, 'No location found')
    return nil
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  config = config or {}

  -- textDocument/definition can return Location or Location[]
  -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition

 -- create a new tab and save bufnr
  -- api.nvim_command('tabnew')
  -- local buf = api.nvim_get_current_buf()
  api.nvim_command('tab split')

  if vim.tbl_islist(result) then
    local title = 'LSP locations'
    local items = util.locations_to_items(result, client.offset_encoding)

    if config.on_list then
      assert(type(config.on_list) == 'function', 'on_list is not a function')
      config.on_list({ title = title, items = items })
    else
      if #result == 1 then
        util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)
        return
      end
      vim.fn.setqflist({}, ' ', { title = title, items = items })
      api.nvim_command('botright copen')
    end
  else
    util.jump_to_location(result, client.offset_encoding, config.reuse_win)
  end
end

 
local location_callback = function(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(method, 'No location found')
    return nil
  end
 
  api.nvim_command('tab split')
 
  if vim.tbl_islist(result) then
    util.jump_to_location(result[1])
    if #result > 1 then
      util.set_qflist(util.locations_to_items(result))
      api.nvim_command("copen")
      api.nvim_command("wincmd p")
    end
  else
    util.jump_to_location(result)
  end
end
 
handlers['textDocument/declaration']    = raw_location_handler
handlers['textDocument/definition']     = raw_location_handler
handlers['textDocument/typeDefinition'] = raw_location_handler
handlers['textDocument/implementation'] = raw_location_handler
