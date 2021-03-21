local mqtt = require("mosquitto")

local platform = require("mqttboot.platform")

local _DEBUG = false
---@type Platform
local _PLATFORM = nil
local client = mqtt.new()

function client.ON_CONNECT()
  print("Connected.")
  client:publish("/pc/status", _PLATFORM.name, 1, false)
  client:subscribe("/pc/#")
  _PLATFORM:onConnect()
end

function client.ON_MESSAGE(mid, topic, payload)
  if topic == "/pc/reboot" then
    if payload ~= _PLATFORM.name then
      _PLATFORM:nextboot(payload)
    end
    _PLATFORM:reboot()
  else
    print(topic, payload)
    _PLATFORM:onMessage(topic, payload)
  end
end


local function main()
  _PLATFORM = platform.get()

  client:will_set("/pc/status", "offline", 2, false)
  client:login_set("code", "vscode")
  client:connect("kodibox.lan")
  client:loop_forever()
end

local args = {...}

if args[1] == "-debug" then
  _DEBUG = true

  package.cpath = package.cpath .. ";/home/majsky4/.vscode-oss/extensions/tangzx.emmylua-0.3.49/debugger/emmy/linux/emmy_core.so"
  local dbg = require("emmy_core")
  dbg.tcpConnect("localhost", 9966)

  table.remove(args, 1)
end

main(args[1])
