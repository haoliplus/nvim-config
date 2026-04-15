local root = vim.fn.getcwd()
local autocommands_path = root .. "/lua/autocommands.lua"
local autocommands_source = table.concat(vim.fn.readfile(autocommands_path), "\n")

if autocommands_source:find("black@22.12.0", 1, true) then
  error("InitMasonPackage should not pin black to a version that lacks py312 support")
end

if autocommands_source:find("isort@4.3.21", 1, true) then
  error("InitMasonPackage should not pin isort to a version that lacks --filename support")
end

print("mason package spec passed")
