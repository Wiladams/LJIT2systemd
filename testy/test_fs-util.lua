--test_fs-util.lua

package.path = package.path..";../src/?.lua"

local fsutil = require("fs-util")

local function listFiles(path)
	print("==== Path : ", path)
for _, filename in fsutil.files_in_directory(path) do
	print(filename)
end
end

listFiles("/sys")
listFiles("/sys/kernel")
