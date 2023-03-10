#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2022 lihao <haoliplus@gmail.com>
--
-- Distributed under terms of the MIT license.
--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions


local call_requires = function()
  require('plugins')
  require('lsp')
  require('packer_plugins')
end;

call_requires()
-- if pcall(call_requires) then
-- else
--     print('Failed to run init.lua');
-- end
