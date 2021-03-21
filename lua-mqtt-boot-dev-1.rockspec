package = "lua-mqtt-boot"
version = "dev-1"
source = {
   url = "git+https://github.com/majsky/lua-mqtt-boot.git"
}
description = {
   homepage = "https://github.com/majsky/lua-mqtt-boot",
   license = "none"
}

dependencies = {
   "lua-mosquitto >= 0.4",
   "lua == 5.3"
}

build = {
   type = "builtin",
   install = {
      bin = {
         mqttboot = "boot.lua"
      }
   },

   modules = {
      ["mqttboot.platform"] = "mqttboot/platform.lua",
      ["mqttboot.windows"] = "mqttboot/windows.lua",
      ["mqttboot.linux"] = "mqttboot/linux.lua",
   }
}
