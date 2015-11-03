--test_SDJoural_attr.lua

--[[
	Test using SDJournal as a cursor over the journal entries
	and printing the fields of each entry individually
--]]
package.path = package.path..";../src/?.lua"

local SDJournal = require("SDJournal")
local sysd = require("systemd_ffi")


local function printJournalAttributes()
	local jnl1 = SDJournal();

	print("== Journal ==")
	print("Size: ", jnl1:bytesUsed())
end

printJournalAttributes();

