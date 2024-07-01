local function check_command_existence(cmd)
    local result = io.popen(cmd .. " --version 2>&1")
    if not result then
        return false
    end
    local output = result:read("*a")
    result:close()
    return output ~= "" and not output:match("not found") and not output:match("No such file or directory")
end

local function os_capture(cmd, raw) 
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

local function os_git_capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

local function cmd_exists(required_cmd)
    -- 检查git命令是否存在
    local version_output = os_capture(required_cmd .. ' 2>&1', true)
    if not version_output:match('git version') then
        return false, "Git is not installed."
    end
end

local function check_git_version(required_version)
    -- 检查git命令是否存在
    local version_output = os_git_capture('git --version 2>&1', true)
    if not version_output:match('git version') then
        return false, "Git is not installed."
    end

    -- 提取版本号并进行比较
    local version = version_output:match('%d+%.%d+%.%d+')
    local major, minor, patch = version:match('(%d+)%.(%d+)%.(%d+)')
    major, minor, patch = tonumber(major), tonumber(minor), tonumber(patch)

    local required_major, required_minor = required_version:match('(%d+)%.(%d+)')
    required_major, required_minor = tonumber(required_major), tonumber(required_minor)

    if major > required_major or (major == required_major and minor >= required_minor) then
        return true, "Git version is sufficient."
    else
        return false, "Git version is not sufficient. Required: " .. required_version .. ", but found: " .. version
    end
end

local function check_commands()
    local commands = {
        git = "git",
        node = "node",
        python3 = "python3",
        yarn = "yarn",
        isort = "isort",
        black = "black"
    }

    for key, cmd in pairs(commands) do
        if check_command_existence(cmd) then
            -- require("notify")(key .. " is installed.")
            -- only pass
        else
            require("notify")(key .. " is not installed.")
        end
    end
end



-- local success, message = check_git_version("2.20")
--
-- if success then
--   require("notify")(message)
-- else
--   require("notify")(message)
-- end


check_commands()
