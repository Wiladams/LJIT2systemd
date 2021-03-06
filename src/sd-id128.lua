local ffi = require("ffi")


local SD_ID128_FORMAT_STR = "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
local function SD_ID128_FORMAT_VAL(x) 
    return x.bytes[0], x.bytes[1], x.bytes[2], x.bytes[3], x.bytes[4], x.bytes[5], x.bytes[6], x.bytes[7], x.bytes[8], x.bytes[9], x.bytes[10], x.bytes[11], x.bytes[12], x.bytes[13], x.bytes[14], x.bytes[15]
end

ffi.cdef[[
typedef union sd_id128 sd_id128_t;

union sd_id128 {
        uint8_t bytes[16];
        uint64_t qwords[2];
};
]]
local sd_id128 = ffi.typeof("union sd_id128")

ffi.cdef[[
static const int SD_ID128_STRING_MAX = 33;

char *sd_id128_to_string(sd_id128_t id, char s[SD_ID128_STRING_MAX]);

int sd_id128_from_string(const char *s, sd_id128_t *ret);

int sd_id128_randomize(sd_id128_t *ret);

int sd_id128_get_machine(sd_id128_t *ret);

int sd_id128_get_boot(sd_id128_t *ret);
]]

ffi.metatype(sd_id128, {
    __new = function(ct, ...)
        local obj = ffi.new(ct,{bytes={...}});
        return obj;
    end,

    __tostring = function(self)
        return string.format(SD_ID128_FORMAT_STR, SD_ID128_FORMAT_VAL(self))
    end,

    __index = {
        isEqual = function(self, other)
            return self.qwords[0] == other.qwords[0] and
                self.qwords[1] == other.qwords[1]
        end,

        isNull = function(self)
            return self.qwords[0] == 0 and self.qwords[1] == 0;
        end,
    }
})

local function SD_ID128_MAKE(v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15)
    local id = sd_id128(v0, v1, v2, v3, v4, v5, v6, v7, v8,
        v9, v10, v11, v12, v13, v14, v15);
    
    return id;
end


--[[
#define SD_ID128_CONST_STR(x)                                           \
        ((const char[SD_ID128_STRING_MAX]) {                            \
                ((x).bytes[0] >> 4) >= 10 ? 'a' + ((x).bytes[0] >> 4) - 10 : '0' + ((x).bytes[0] >> 4), \
                ((x).bytes[0] & 15) >= 10 ? 'a' + ((x).bytes[0] & 15) - 10 : '0' + ((x).bytes[0] & 15), \
                ((x).bytes[1] >> 4) >= 10 ? 'a' + ((x).bytes[1] >> 4) - 10 : '0' + ((x).bytes[1] >> 4), \
                ((x).bytes[1] & 15) >= 10 ? 'a' + ((x).bytes[1] & 15) - 10 : '0' + ((x).bytes[1] & 15), \
                ((x).bytes[2] >> 4) >= 10 ? 'a' + ((x).bytes[2] >> 4) - 10 : '0' + ((x).bytes[2] >> 4), \
                ((x).bytes[2] & 15) >= 10 ? 'a' + ((x).bytes[2] & 15) - 10 : '0' + ((x).bytes[2] & 15), \
                ((x).bytes[3] >> 4) >= 10 ? 'a' + ((x).bytes[3] >> 4) - 10 : '0' + ((x).bytes[3] >> 4), \
                ((x).bytes[3] & 15) >= 10 ? 'a' + ((x).bytes[3] & 15) - 10 : '0' + ((x).bytes[3] & 15), \
                ((x).bytes[4] >> 4) >= 10 ? 'a' + ((x).bytes[4] >> 4) - 10 : '0' + ((x).bytes[4] >> 4), \
                ((x).bytes[4] & 15) >= 10 ? 'a' + ((x).bytes[4] & 15) - 10 : '0' + ((x).bytes[4] & 15), \
                ((x).bytes[5] >> 4) >= 10 ? 'a' + ((x).bytes[5] >> 4) - 10 : '0' + ((x).bytes[5] >> 4), \
                ((x).bytes[5] & 15) >= 10 ? 'a' + ((x).bytes[5] & 15) - 10 : '0' + ((x).bytes[5] & 15), \
                ((x).bytes[6] >> 4) >= 10 ? 'a' + ((x).bytes[6] >> 4) - 10 : '0' + ((x).bytes[6] >> 4), \
                ((x).bytes[6] & 15) >= 10 ? 'a' + ((x).bytes[6] & 15) - 10 : '0' + ((x).bytes[6] & 15), \
                ((x).bytes[7] >> 4) >= 10 ? 'a' + ((x).bytes[7] >> 4) - 10 : '0' + ((x).bytes[7] >> 4), \
                ((x).bytes[7] & 15) >= 10 ? 'a' + ((x).bytes[7] & 15) - 10 : '0' + ((x).bytes[7] & 15), \
                ((x).bytes[8] >> 4) >= 10 ? 'a' + ((x).bytes[8] >> 4) - 10 : '0' + ((x).bytes[8] >> 4), \
                ((x).bytes[8] & 15) >= 10 ? 'a' + ((x).bytes[8] & 15) - 10 : '0' + ((x).bytes[8] & 15), \
                ((x).bytes[9] >> 4) >= 10 ? 'a' + ((x).bytes[9] >> 4) - 10 : '0' + ((x).bytes[9] >> 4), \
                ((x).bytes[9] & 15) >= 10 ? 'a' + ((x).bytes[9] & 15) - 10 : '0' + ((x).bytes[9] & 15), \
                ((x).bytes[10] >> 4) >= 10 ? 'a' + ((x).bytes[10] >> 4) - 10 : '0' + ((x).bytes[10] >> 4), \
                ((x).bytes[10] & 15) >= 10 ? 'a' + ((x).bytes[10] & 15) - 10 : '0' + ((x).bytes[10] & 15), \
                ((x).bytes[11] >> 4) >= 10 ? 'a' + ((x).bytes[11] >> 4) - 10 : '0' + ((x).bytes[11] >> 4), \
                ((x).bytes[11] & 15) >= 10 ? 'a' + ((x).bytes[11] & 15) - 10 : '0' + ((x).bytes[11] & 15), \
                ((x).bytes[12] >> 4) >= 10 ? 'a' + ((x).bytes[12] >> 4) - 10 : '0' + ((x).bytes[12] >> 4), \
                ((x).bytes[12] & 15) >= 10 ? 'a' + ((x).bytes[12] & 15) - 10 : '0' + ((x).bytes[12] & 15), \
                ((x).bytes[13] >> 4) >= 10 ? 'a' + ((x).bytes[13] >> 4) - 10 : '0' + ((x).bytes[13] >> 4), \
                ((x).bytes[13] & 15) >= 10 ? 'a' + ((x).bytes[13] & 15) - 10 : '0' + ((x).bytes[13] & 15), \
                ((x).bytes[14] >> 4) >= 10 ? 'a' + ((x).bytes[14] >> 4) - 10 : '0' + ((x).bytes[14] >> 4), \
                ((x).bytes[14] & 15) >= 10 ? 'a' + ((x).bytes[14] & 15) - 10 : '0' + ((x).bytes[14] & 15), \
                ((x).bytes[15] >> 4) >= 10 ? 'a' + ((x).bytes[15] >> 4) - 10 : '0' + ((x).bytes[15] >> 4), \
                ((x).bytes[15] & 15) >= 10 ? 'a' + ((x).bytes[15] & 15) - 10 : '0' + ((x).bytes[15] & 15), \
                0 })
--]]

-- create a single instance to represent the nil value
--#define SD_ID128_NULL ((const sd_id128_t) { .qwords = { 0, 0 }})

return sd_id128;
