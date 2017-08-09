--SDLoginMonitor.lua
local sysd = require("systemd_ffi")


local categories = {
	"seat",		-- seats added/removed
	"session",	-- session creation/modification
	"uid",		-- user login state change
	"machine"	-- virtual machine and container start/stop
}

local SDLoginMonitor = {}
setmetatable(SDLoginMonitor, {
	__call = function(self, ...)
		return self:new(...);
	end,
})
local SDLoginMonitor_mt = {
	__index = SDLoginMonitor
}

function SDLoginMonitor.init(self, handle)
	if not handle then return nil end

	local fd = sysd.sd_login_monitor_get_fd(handle);
	local events = sysd.sd_login_monitor_get_events(handle);
	local timeout_usec = ffi.new("uint64_t[1]")
	local success = sysd.sd_login_monitor_get_timeout(handle, timeout_usec);
	timeout_usec = timeout_usec[0];

	local obj = {
		Handle = handle;

		FileDescriptor = fd;
		EventMask = events;
		Timeout = timeout_usec;
	}
	setmetatable(obj, SDLoginMonitor_mt)

	return obj;
end

function SDLoginMonitor.new(self, category)
	local mon = ffi.new("sd_login_monitor * [1]")
	local res = sd_login_monitor_new(category, mon);
	if res ~= 0 then
		return nil, res
	end
	mon = mon[0];

	ffi.gc(mon, sysd.sd_login_monitor_unref);

	return self:init(mon);
end

function SDLoginMonitor.flush(self)
	sysd.sd_login_monitor_flush(self.Handle);
end

