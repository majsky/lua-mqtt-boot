local platform = require("mqttboot.platform")

---@class LinuxPlatform : Platform
local linux = platform.new("linux")

function linux:reboot()
  os.execute("reboot")
end

function linux:nextboot(target)
  if target == "windows" then
    print("Nadstavujem windows ako bootnext...")
    os.execute("sudo efibootmgr -n 0000 > /dev/null")
  end
end

return linux
