--SDJournal.lua

local ffi = require("ffi")
local sysd = require("systemd")
local libc = require("libc")

local SDJournal = {}
setmetatable(SDJournal, {
	__call = function(self, ...)
		return self:new(...)
	end,
})

local SDJournal_mt = {
	__index = SDJournal
}

function SDJournal.init(self, handle)
	local obj = {
		Handle = handle;
	}
	setmetatable(obj, SDJournal_mt)

	return obj;
end

function SDJournal.new(self, flags)
	flags = flags or 0
	local jp = ffi.new("sd_journal *[1]")
	
	local res = sysd.sd_journal_open(jp, flags)
	if res ~= 0 then
		return nil, res;
	end

	ffi.gc(jp[0], sysd.sd_journal_close)

	return self:init(jp[0])
end

function SDJournal.getField(self, name)
	local datap = ffi.new("char *[1]")
	local len = ffi.new("size_t [1]")
	local res = sysd.sd_journal_get_data(self.Handle, name, ffi.cast("const void **",datap), len);

	if res ~= 0 then 
		return nil 
	end

	return ffi.string(datap[0], len[0])
end

--[[
	Iterate over the entries in the journal
	Since the SDJournal object is itself a cursor
	we the will move the 'cursor' along, and then you can
	use the 'fields' iterator to get at the individual data values.
--]]
function SDJournal.entries(self)
	local function entry_gen(param, state)
		local res = sysd.sd_journal_next(param.Handle);
		if res <= 0 then
			print("SDJournal.entries() - END: ", res)
			return nil
		end
		sysd.sd_journal_restart_data(param.Handle)
		return state+1, param
	end

	return entry_gen, self, 0
end

function SDJournal.fields(self)
	local function field_gen(param, state)
		local datap = ffi.new("char *[1]")
		local len = ffi.new("size_t[1]")

		local res = sysd.sd_journal_enumerate_data(self.Handle, ffi.cast("const void **", datap), len);
		if res <= 0 then 
			print("SDJournal.fields() - END: ", res)
			return nil 
		end

		local eqlptr = ffi.C.strchr(datap[0], string.byte('='))
		local namelen = eqlptr - datap[0]
		local fieldname = ffi.string(datap[0], namelen)

		return res, fieldname, datap[0], tonumber(len[0])
	end

	return field_gen, self, 0
end

return SDJournal
