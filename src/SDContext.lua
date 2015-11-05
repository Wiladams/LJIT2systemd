--SDMachine.lua
local ffi = require("ffi")
local sysd = require("systemd_ffi")
local fsutil = require("fs-util")
local strutil = require("string-util")
local fun = require("fun")

local function nil_gen()
	return nil;
end

local SDMachine = {}
local SDMachine_mt = {
	__index = SDMachine;
}


local function isNotUnit(name)
	return not strutil.startswith(name, "unit:")
end

function SDMachine.machineNames(self)
-- filter these out
-- if (startswith(*a, "unit:") || !machine_name_is_valid(*a))

	return fun.filter(isNotUnit, fsutil.files_in_directory("/run/systemd/machines/"))
end


function SDMachine.sessionNames(self)
	return fsutil.files_in_directory("/run/systemd/sessions/")
end


function SDMachine.seatNames(self)
	return fsutil.files_in_directory("/run/systemd/seats/")
end


return SDMachine
