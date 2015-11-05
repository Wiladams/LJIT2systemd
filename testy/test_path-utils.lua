--test_path-utils.lua
package.path = package.path..";../src/?.lua"

local putils = require("path-util")

print("isHidden: .", putils.hidden_file("."))
print("isHidden: lost+found", putils.hidden_file("lost+found"))
print("isHidden: foo.txt", putils.hidden_file("foo.txt"))
