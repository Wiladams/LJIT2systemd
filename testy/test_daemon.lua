package.path = package.path..";../src/?.lua"

local sysd = require("systemd_ffi")

local res = sysd.sd_booted()

print("booted: ", res)