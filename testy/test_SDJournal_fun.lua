-- test_journal.lua
--[[
	Test cursoring over journal, turning each entry
	into a lua table to be used with luafun filters and whatnot
--]]
package.path = package.path..";../src/?.lua"

local SDJournal = require("SDJournal")
local sysd = require("systemd")
local fun = require("fun")()

-- Feed this routine a table with the names of the fields
-- you are interested in seeing in the final output table
local function selection(fields, aliases)
	return function(entry)
		local res = {}
		for _, k in ipairs(fields) do
			if entry[k] then
				res[k] = entry[k];
			end
		end
		return res;
	end
end

local function  printTable(entry)
	print(entry)
	each(print, entry)
end



local function printJournalFields(selector, flags)
	flags = flags or 0
	local jnl1 = SDJournal();

	if selector then
		each(printTable, map(selector, map(function(entry) return entry:currentValue() end, jnl1:entries())))
	else
		each(printTable, map(function(entry) return entry:currentValue() end, jnl1:entries()))	
	end
end

--printJournalFields(nil, sysd.SD_JOURNAL_CURRENT_USER)
--printJournalFields(nil, sysd.SD_JOURNAL_SYSTEM)

--printJournalFields(selection({"_HOSTNAME", "SYSLOG_FACILITY"}));
printJournalFields(selection({"_EXE", "_CMDLINE"}));

--printJournalFields();