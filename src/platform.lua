local ffi = require("ffi")

-- These types are platform specific
-- and should be taylored to match
ffi.cdef[[
typedef int32_t		__pid_t;
typedef uint32_t	__uid_t;
typedef long		__clock_t;
typedef int32_t		__clockid_t;
]]

ffi.cdef[[
typedef __pid_t 		pid_t;
typedef __uid_t 		uid_t;
typedef __clockid_t		clockid_t;
]]