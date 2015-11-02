--test_sd-id128.lua
package.path = package.path..";../src/?.lua"

local ffi = require("ffi")
local sd_id128 = require("sd-id128")
local sd_messages = require("sd-messages")



local id1 = sd_id128();
print("Default: ",id1)
print(" isNull: ", id1:isNull())

local coreDump = sd_messages.SD_MESSAGE_COREDUMP;

print("            COREDUMP: ", sd_messages.SD_MESSAGE_COREDUMP)
print("SD_MESSAGE_POWER_KEY: ", sd_messages.SD_MESSAGE_POWER_KEY)