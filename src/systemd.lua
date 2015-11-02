-- systemd.lua

local ffi = require("ffi")

require("sd-bus")
require("sd-daemon")
require("sd-event")
require("sd-login")


local C = {}

local Lib_systemd = ffi.load("systemd")

local exports = {
	Lib_systemd = Lib_systemd;
}

setmetatable(exports, {
	__index = function(self, key)
		local value = nil;
		local success = false;

		-- try looking in table of constants
		value = C[key]
		if value then
			rawset(self, key, value)
			return value;
		end


		-- try looking in the library for a function
		success, value = pcall(function() return Lib_systemd[key] end)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- try looking in the ffi.C namespace, for constants
		-- and enums
		success, value = pcall(function() return ffi.C[key] end)
		--print("looking for constant/enum: ", key, success, value)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- Or maybe it's a type
		success, value = pcall(function() return ffi.typeof(key) end)
		if success then
			rawset(self, key, value);
			return value;
		end

		return nil;
	end,
})

return exports

