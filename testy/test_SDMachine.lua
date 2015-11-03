-- test_journal_cursor.lua

--[[
	Test using SDJournal as a cursor over the journal entries

	In this case, we want to try the various cursor positioning
	operations to ensure the work correctly.
--]]
package.path = package.path..";../src/?.lua"

local SDMachine = require("SDMachine")
local sysd = require("systemd_ffi")


print("== Machines ==")
for _, name in SDMachine:machineNames() do
	print(name)
end

print("== Sessions ==")
for _, name in SDMachine:sessionNames() do 
	print(name)
end

print("== Seats == ")
for _, name in SDMachine:seatNames() do 
	print(name)
end
