--SDJournal.lua

local ffi = require("ffi")
local sysd = require("systemd_ffi")
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
	jp = jp[0];

	ffi.gc(jp, sysd.sd_journal_close)

	return self:init(jp)
end

function SDJournal.bytesUsed(self)
	local bytes = ffi.new("uint64_t[1]")
	local res = sysd.sd_journal_get_usage(self.Handle, bytes);

	if res ~= 0 then return false end

	bytes = bytes[0]
	
	return bytes
end

--[[
int sd_journal_previous(sd_journal *j);
int sd_journal_next(sd_journal *j);
int sd_journal_get_cursor(sd_journal *j, char **cursor);
int sd_journal_test_cursor(sd_journal *j, const char *cursor);
int sd_journal_seek_head(sd_journal *j);
int sd_journal_seek_tail(sd_journal *j);
int sd_journal_seek_cursor(sd_journal *j, const char *cursor);

--]]
function SDJournal.seekHead(self)
	local res = sysd.sd_journal_seek_head(self.Handle);
	if res ~= 0 then return false end

	return true;
end

function SDJournal.seekTail(self)
	local res = sysd.sd_journal_seek_tail(self.Handle);
	if res ~= 0 then return false end

	return true;
end

function SDJournal.seekLabel(self, label)
	local res = sysd.sd_journal_seek_cursor(self.Handle, label);
	if res ~= 0 then return false end

	return true;
end


function SDJournal.next(self)
	local res = sysd.sd_journal_next(self.Handle)
	if res ~= 0 then return false end

	return true;
end

function SDJournal.previous(self)
	local res = sysd.sd_journal_previous(self.Handle)
	if res ~= 0 then return false end

	return true;
end

function SDJournal.positionLabel(self)
	local pLabel = ffi.new("char *[1]");
	local res = sysd.sd_journal_get_cursor(self.Handle, pLabel);
	if res ~= 0 then
		return nil;
	end

	return ffi.string(pLabel[0])
end






function SDJournal.getField(self, name)
	local datap = ffi.new("char *[1]")
	local len = ffi.new("size_t [1]")
	local res = sysd.sd_journal_get_data(self.Handle, name, ffi.cast("const void **",datap), len);


	if res ~= 0 then 
		return nil 
	end

	-- find where the '=' sign is, and take everything
	-- after that.
	datap = datap[0]
	len = len[0]
	local eqlptr = ffi.C.strchr(datap, string.byte('='))
	local namelen = eqlptr - datap

	eqlptr = eqlptr + 1;
	local valuelen = len - namelen-1;

	return ffi.string(eqlptr, valuelen)
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
			--print("SDJournal.entries() - END: ", res)
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
			--print("SDJournal.fields() - END: ", res)
			return nil 
		end

		datap = datap[0];
		len = len[0];

		local eqlptr = ffi.C.strchr(datap, string.byte('='))
		local namelen = eqlptr - datap
		local fieldname = ffi.string(datap, namelen)

		return res, fieldname, datap, tonumber(len)
	end

	return field_gen, self, 0
end

function SDJournal.currentValue(self)
	local res = {}
	for _, fieldname, dataptr, len in self:fields() do
		res[fieldname] = self:getField(fieldname);
	end

	return res;
end

return SDJournal
