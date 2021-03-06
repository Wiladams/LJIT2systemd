
local ffi = require("ffi")

local sd_id128 = require("sd-id128")

local function SD_ID128_MAKE(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15)
    local id = ffi.new(sd_id128, {
        v0, v1, v2, v3, v4, v5, v6, v7, v8,
        v9, v10, v11, v12, v13, v14, v15});
    return id;
end

local C = {}

C.SD_MESSAGE_JOURNAL_START    = sd_id128(0xf7,0x73,0x79,0xa8,0x49,0x0b,0x40,0x8b,0xbe,0x5f,0x69,0x40,0x50,0x5a,0x77,0x7b)
C.SD_MESSAGE_JOURNAL_STOP     = sd_id128(0xd9,0x3f,0xb3,0xc9,0xc2,0x4d,0x45,0x1a,0x97,0xce,0xa6,0x15,0xce,0x59,0xc0,0x0b)
C.SD_MESSAGE_JOURNAL_DROPPED  = sd_id128(0xa5,0x96,0xd6,0xfe,0x7b,0xfa,0x49,0x94,0x82,0x8e,0x72,0x30,0x9e,0x95,0xd6,0x1e)
C.SD_MESSAGE_JOURNAL_MISSED   = sd_id128(0xe9,0xbf,0x28,0xe6,0xe8,0x34,0x48,0x1b,0xb6,0xf4,0x8f,0x54,0x8a,0xd1,0x36,0x06)
C.SD_MESSAGE_JOURNAL_USAGE    = sd_id128(0xec,0x38,0x7f,0x57,0x7b,0x84,0x4b,0x8f,0xa9,0x48,0xf3,0x3c,0xad,0x9a,0x75,0xe6)

C.SD_MESSAGE_COREDUMP         = sd_id128(0xfc,0x2e,0x22,0xbc,0x6e,0xe6,0x47,0xb6,0xb9,0x07,0x29,0xab,0x34,0xa2,0x50,0xb1)

C.SD_MESSAGE_SESSION_START    = sd_id128(0x8d,0x45,0x62,0x0c,0x1a,0x43,0x48,0xdb,0xb1,0x74,0x10,0xda,0x57,0xc6,0x0c,0x66)
C.SD_MESSAGE_SESSION_STOP     = sd_id128(0x33,0x54,0x93,0x94,0x24,0xb4,0x45,0x6d,0x98,0x02,0xca,0x83,0x33,0xed,0x42,0x4a)
C.SD_MESSAGE_SEAT_START       = sd_id128(0xfc,0xbe,0xfc,0x5d,0xa2,0x3d,0x42,0x80,0x93,0xf9,0x7c,0x82,0xa9,0x29,0x0f,0x7b)
C.SD_MESSAGE_SEAT_STOP        = sd_id128(0xe7,0x85,0x2b,0xfe,0x46,0x78,0x4e,0xd0,0xac,0xcd,0xe0,0x4b,0xc8,0x64,0xc2,0xd5)
C.SD_MESSAGE_MACHINE_START    = sd_id128(0x24,0xd8,0xd4,0x45,0x25,0x73,0x40,0x24,0x96,0x06,0x83,0x81,0xa6,0x31,0x2d,0xf2)
C.SD_MESSAGE_MACHINE_STOP     = sd_id128(0x58,0x43,0x2b,0xd3,0xba,0xce,0x47,0x7c,0xb5,0x14,0xb5,0x63,0x81,0xb8,0xa7,0x58)

C.SD_MESSAGE_TIME_CHANGE      = sd_id128(0xc7,0xa7,0x87,0x07,0x9b,0x35,0x4e,0xaa,0xa9,0xe7,0x7b,0x37,0x18,0x93,0xcd,0x27)
C.SD_MESSAGE_TIMEZONE_CHANGE  = sd_id128(0x45,0xf8,0x2f,0x4a,0xef,0x7a,0x4b,0xbf,0x94,0x2c,0xe8,0x61,0xd1,0xf2,0x09,0x90)

C.SD_MESSAGE_STARTUP_FINISHED = sd_id128(0xb0,0x7a,0x24,0x9c,0xd0,0x24,0x41,0x4a,0x82,0xdd,0x00,0xcd,0x18,0x13,0x78,0xff)

C.SD_MESSAGE_SLEEP_START      = sd_id128(0x6b,0xbd,0x95,0xee,0x97,0x79,0x41,0xe4,0x97,0xc4,0x8b,0xe2,0x7c,0x25,0x41,0x28)
C.SD_MESSAGE_SLEEP_STOP       = sd_id128(0x88,0x11,0xe6,0xdf,0x2a,0x8e,0x40,0xf5,0x8a,0x94,0xce,0xa2,0x6f,0x8e,0xbf,0x14)

C.SD_MESSAGE_SHUTDOWN         = sd_id128(0x98,0x26,0x88,0x66,0xd1,0xd5,0x4a,0x49,0x9c,0x4e,0x98,0x92,0x1d,0x93,0xbc,0x40)

C.SD_MESSAGE_UNIT_STARTING    = sd_id128(0x7d,0x49,0x58,0xe8,0x42,0xda,0x4a,0x75,0x8f,0x6c,0x1c,0xdc,0x7b,0x36,0xdc,0xc5)
C.SD_MESSAGE_UNIT_STARTED     = sd_id128(0x39,0xf5,0x34,0x79,0xd3,0xa0,0x45,0xac,0x8e,0x11,0x78,0x62,0x48,0x23,0x1f,0xbf)
C.SD_MESSAGE_UNIT_STOPPING    = sd_id128(0xde,0x5b,0x42,0x6a,0x63,0xbe,0x47,0xa7,0xb6,0xac,0x3e,0xaa,0xc8,0x2e,0x2f,0x6f)
C.SD_MESSAGE_UNIT_STOPPED     = sd_id128(0x9d,0x1a,0xaa,0x27,0xd6,0x01,0x40,0xbd,0x96,0x36,0x54,0x38,0xaa,0xd2,0x02,0x86)
C.SD_MESSAGE_UNIT_FAILED      = sd_id128(0xbe,0x02,0xcf,0x68,0x55,0xd2,0x42,0x8b,0xa4,0x0d,0xf7,0xe9,0xd0,0x22,0xf0,0x3d)
C.SD_MESSAGE_UNIT_RELOADING   = sd_id128(0xd3,0x4d,0x03,0x7f,0xff,0x18,0x47,0xe6,0xae,0x66,0x9a,0x37,0x0e,0x69,0x47,0x25)
C.SD_MESSAGE_UNIT_RELOADED    = sd_id128(0x7b,0x05,0xeb,0xc6,0x68,0x38,0x42,0x22,0xba,0xa8,0x88,0x11,0x79,0xcf,0xda,0x54)

C.SD_MESSAGE_SPAWN_FAILED     = sd_id128(0x64,0x12,0x57,0x65,0x1c,0x1b,0x4e,0xc9,0xa8,0x62,0x4d,0x7a,0x40,0xa9,0xe1,0xe7)

C.SD_MESSAGE_FORWARD_SYSLOG_MISSED = sd_id128(0x00,0x27,0x22,0x9c,0xa0,0x64,0x41,0x81,0xa7,0x6c,0x4e,0x92,0x45,0x8a,0xfa,0x2e)

C.SD_MESSAGE_OVERMOUNTING     = sd_id128(0x1d,0xee,0x03,0x69,0xc7,0xfc,0x47,0x36,0xb7,0x09,0x9b,0x38,0xec,0xb4,0x6e,0xe7)

C.SD_MESSAGE_LID_OPENED       = sd_id128(0xb7,0x2e,0xa4,0xa2,0x88,0x15,0x45,0xa0,0xb5,0x0e,0x20,0x0e,0x55,0xb9,0xb0,0x6f)
C.SD_MESSAGE_LID_CLOSED       = sd_id128(0xb7,0x2e,0xa4,0xa2,0x88,0x15,0x45,0xa0,0xb5,0x0e,0x20,0x0e,0x55,0xb9,0xb0,0x70)
C.SD_MESSAGE_SYSTEM_DOCKED    = sd_id128(0xf5,0xf4,0x16,0xb8,0x62,0x07,0x4b,0x28,0x92,0x7a,0x48,0xc3,0xba,0x7d,0x51,0xff)
C.SD_MESSAGE_SYSTEM_UNDOCKED  = sd_id128(0x51,0xe1,0x71,0xbd,0x58,0x52,0x48,0x56,0x81,0x10,0x14,0x4c,0x51,0x7c,0xca,0x53)
C.SD_MESSAGE_POWER_KEY        = sd_id128(0xb7,0x2e,0xa4,0xa2,0x88,0x15,0x45,0xa0,0xb5,0x0e,0x20,0x0e,0x55,0xb9,0xb0,0x71)
C.SD_MESSAGE_SUSPEND_KEY      = sd_id128(0xb7,0x2e,0xa4,0xa2,0x88,0x15,0x45,0xa0,0xb5,0x0e,0x20,0x0e,0x55,0xb9,0xb0,0x72)
C.SD_MESSAGE_HIBERNATE_KEY    = sd_id128(0xb7,0x2e,0xa4,0xa2,0x88,0x15,0x45,0xa0,0xb5,0x0e,0x20,0x0e,0x55,0xb9,0xb0,0x73)

C.SD_MESSAGE_INVALID_CONFIGURATION = sd_id128(0xc7,0x72,0xd2,0x4e,0x9a,0x88,0x4c,0xbe,0xb9,0xea,0x12,0x62,0x5c,0x30,0x6c,0x01)

C.SD_MESSAGE_BOOTCHART        = sd_id128(0x9f,0x26,0xaa,0x56,0x2c,0xf4,0x40,0xc2,0xb1,0x6c,0x77,0x3d,0x04,0x79,0xb5,0x18)

return C