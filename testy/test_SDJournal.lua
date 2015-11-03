-- test_journal.lua
--[[
	Note: This iteration works, but it seems to not print
	all the entries in a journal.  Perhaps resource exhaustion
--]]
package.path = package.path..";../src/?.lua"

local SDJournal = require("SDJournal")

local jnl1 = SDJournal();

local function printFields(entry)
	for fldidx, fieldname, fielddata, fieldlen in entry:fields() do
		print('    ',fieldname, fielddata, fieldlen)
	end
end

for entryidx, entry in jnl1:entries() do
	print(entryidx, entry)
--	print(entry:getField("_HOSTNAME"))
	print(entry:getField("MESSAGE"))
	--printFields(entry)
end
