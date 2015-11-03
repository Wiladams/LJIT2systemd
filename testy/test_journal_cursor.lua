-- test_journal_cursor.lua

--[[
	Test using SDJournal as a cursor over the journal entries

	In this case, we want to try the various cursor positioning
	operations to ensure the work correctly.
--]]
package.path = package.path..";../src/?.lua"

local SDJournal = require("SDJournal")
local sysd = require("systemd_ffi")

local jnl = SDJournal()

-- move forward a few times
for i=1,10 do
	jnl:next();
end

-- get the cursor label for this position
local label10 = jnl:positionLabel()
print("Label 10: ", label10)

-- seek to the beginning, print that label
jnl:seekHead();
jnl:next();
local label1 = jnl:positionLabel();
print("Label 1: ", label1);


-- seek to label 10 again
jnl:seekLabel(label10)
jnl:next();
local label3 = jnl:positionLabel();
print("Label 3: ", label3)
print("label 3 == label 10: ", label3 == label10)