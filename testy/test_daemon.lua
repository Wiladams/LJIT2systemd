package.path = package.path..";../src/?.lua"

local sysd = require("systemd")

local res = sysd.sd_booted()

print("booted: ", res)