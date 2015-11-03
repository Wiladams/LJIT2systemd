-- test_journal.lua

package.path = package.path..";../src/?.lua"

local ffi = require("ffi")
local sysd = require("systemd_ffi")

local jp = ffi.new("sd_journal *[1]")
local flags = 0;

local res = sysd.sd_journal_open(jp, flags)
print("RES: ", res, jp[0])
assert(res == 0)

local function closeJournal(jnl)
	print("CLOSE JOURNAL: ", jnl)
	sysd.sd_journal_close(jnl)
end

local jnl = jp[0];
ffi.gc(jnl, closeJournal)

