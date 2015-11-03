-- test_journal.lua

--[[
	Test using SDJournal as a cursor over the journal entries
	and printing the fields of each entry individually
--]]
package.path = package.path..";../src/?.lua"

local SDJournal = require("SDJournal")
local sysd = require("systemd")


local function printFields(entry)
--	print('    ', entry:getField("_HOSTNAME"))
--	print('    ', entry:getField("MESSAGE"))

	for fldidx, fieldname, fielddata, fieldlen in entry:fields() do
		print('    ',fieldname, entry:getField(fieldname))
	end
end

local function printJournalFields(flags)
	flags = flags or 0
	local jnl1 = SDJournal();

	for entryidx, entry in jnl1:entries() do
		print(entryidx, entry)
		printFields(entry)
	end
end

print("SD_JOURNAL_CURRENT_USER: ", sysd.SD_JOURNAL_CURRENT_USER)
printJournalFields(sysd.SD_JOURNAL_CURRENT_USER)
