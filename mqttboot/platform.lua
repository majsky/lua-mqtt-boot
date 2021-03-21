local platform = {
    proto={}
}

local _platform = {
    __index=platform.proto
}

function platform.proto:reboot()
    erorr("Not implemented!")
end

---@param target string
function platform.proto:nextboot(target)
    error("NextBoot")
end

function platform.proto:onConnect()
end

function platform.proto:onMessage(topic, payload)
end

---@param name string
------@return Platform
function platform.new(name)
    ---@class Platform
    local pl = setmetatable({name=name}, _platform)
    return pl
end

local current = "unknown"
function platform.current()
  if current == "unknown" then
    local isPosix = package.config:sub(1, 1) == "/"

    if isPosix then
      local hnd = io.popen("uname -s", "r")
      local uname = hnd:read("a")
      hnd:close()
      current = uname:match("(%S+)"):lower()
    else
      current = "windows"
    end
  end

  return current
end

function platform.get(plat)
  return require("mqttboot." .. (plat or platform.current()))
end

return platform
