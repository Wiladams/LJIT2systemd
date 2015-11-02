local ffi = require("ffi")

ffi.cdef[[
typedef struct sd_bus_vtable sd_bus_vtable;
]]

--require("sd-bus")

ffi.cdef[[
enum {
        _SD_BUS_VTABLE_START             = '<',
        _SD_BUS_VTABLE_END               = '>',
        _SD_BUS_VTABLE_METHOD            = 'M',
        _SD_BUS_VTABLE_SIGNAL            = 'S',
        _SD_BUS_VTABLE_PROPERTY          = 'P',
        _SD_BUS_VTABLE_WRITABLE_PROPERTY = 'W',
};

enum {
        SD_BUS_VTABLE_DEPRECATED                   = 1 << 0,
        SD_BUS_VTABLE_HIDDEN                       = 1 << 1,
        SD_BUS_VTABLE_UNPRIVILEGED                 = 1 << 2,
        SD_BUS_VTABLE_METHOD_NO_REPLY              = 1 << 3,
        SD_BUS_VTABLE_PROPERTY_CONST               = 1 << 4,
        SD_BUS_VTABLE_PROPERTY_EMITS_CHANGE        = 1 << 5,
        SD_BUS_VTABLE_PROPERTY_EMITS_INVALIDATION  = 1 << 6,
        SD_BUS_VTABLE_PROPERTY_EXPLICIT            = 1 << 7,
        _SD_BUS_VTABLE_CAPABILITY_MASK             = 0xFFFF << 40
};
]]


--#define SD_BUS_VTABLE_CAPABILITY(x) ((uint64_t) (((x)+1) & 0xFFFF) << 40)

ffi.cdef[[
struct sd_bus_vtable {
        /* Please do not initialize this structure directly, use the
         * macros below instead */

        uint8_t type:8;
        uint64_t flags;
        //uint64_t flags:56;
        union {
                struct {
                        size_t element_size;
                } start;
                struct {
                        const char *member;
                        const char *signature;
                        const char *result;
                        sd_bus_message_handler_t handler;
                        size_t offset;
                } method;
                struct {
                        const char *member;
                        const char *signature;
                } signal;
                struct {
                        const char *member;
                        const char *signature;
                        sd_bus_property_get_t get;
                        sd_bus_property_set_t set;
                        size_t offset;
                } property;
        } x;
};
]]

--[[
#define SD_BUS_VTABLE_START(_flags)                                     \
        {                                                               \
                .type = _SD_BUS_VTABLE_START,                           \
                .flags = _flags,                                        \
                .x.start.element_size = sizeof(sd_bus_vtable),          \
        }

#define SD_BUS_METHOD_WITH_OFFSET(_member, _signature, _result, _handler, _offset, _flags)   \
        {                                                               \
                .type = _SD_BUS_VTABLE_METHOD,                          \
                .flags = _flags,                                        \
                .x.method.member = _member,                             \
                .x.method.signature = _signature,                       \
                .x.method.result = _result,                             \
                .x.method.handler = _handler,                           \
                .x.method.offset = _offset,                             \
        }
#define SD_BUS_METHOD(_member, _signature, _result, _handler, _flags)   \
        SD_BUS_METHOD_WITH_OFFSET(_member, _signature, _result, _handler, 0, _flags)

#define SD_BUS_SIGNAL(_member, _signature, _flags)                      \
        {                                                               \
                .type = _SD_BUS_VTABLE_SIGNAL,                          \
                .flags = _flags,                                        \
                .x.signal.member = _member,                             \
                .x.signal.signature = _signature,                       \
        }

#define SD_BUS_PROPERTY(_member, _signature, _get, _offset, _flags)     \
        {                                                               \
                .type = _SD_BUS_VTABLE_PROPERTY,                        \
                .flags = _flags,                                        \
                .x.property.member = _member,                           \
                .x.property.signature = _signature,                     \
                .x.property.get = _get,                                 \
                .x.property.offset = _offset,                           \
        }

#define SD_BUS_WRITABLE_PROPERTY(_member, _signature, _get, _set, _offset, _flags) \
        {                                                               \
                .type = _SD_BUS_VTABLE_WRITABLE_PROPERTY,               \
                .flags = _flags,                                        \
                .x.property.member = _member,                           \
                .x.property.signature = _signature,                     \
                .x.property.get = _get,                                 \
                .x.property.set = _set,                                 \
                .x.property.offset = _offset,                           \
        }

#define SD_BUS_VTABLE_END                                               \
        {                                                               \
                .type = _SD_BUS_VTABLE_END,                             \
        }
--]]
