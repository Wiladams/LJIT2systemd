--SDMachine.lua
local ffi = require("ffi")
local sysd = require("systemd_ffi")

local function nil_gen()
	return nil;
end

local SDMachine = {}
local SDMachine_mt = {
	__index = SDMachine;
}


function SDMachine.machineNames(self)
	local names = ffi.new("char **[1]")
	local res = sysd.sd_get_machine_names(names);
print("RES: ", res)
	if res <= 0 then
		return nil_gen
	end

	names = names[0];

	local function name_gen(param, nextone)
		if nextone >= param.size then
			-- free up the parameters
			return nil;
		end

		return nextone+1, ffi.string(param.names[nextone]);
	end

	return name_gen, {names=names, size=res}, 0
end


function SDMachine.sessionNames(self)
	local names = ffi.new("char **[1]")
	local res = sysd.sd_get_sessions(names);
print("RES: ", res)
	if res <= 0 then
		return nil_gen
	end

	names = names[0];

	local function name_gen(param, nextone)
		if nextone >= param.size then
			-- free up the parameters
			return nil;
		end

		return nextone+1, ffi.string(param.names[nextone]);
	end

	return name_gen, {names=names, size=res}, 0
end


function SDMachine.seatNames(self)
	local names = ffi.new("char **[1]")
	local res = sysd.sd_get_seats(names);
print("RES: ", res)
	if res <= 0 then
		return nil_gen
	end

	names = names[0];

	local function name_gen(param, nextone)
		if nextone >= param.size then
			-- free up the parameters
			return nil;
		end

		return nextone+1, ffi.string(param.names[nextone]);
	end

	return name_gen, {names=names, size=res}, 0
end



return SDMachine
