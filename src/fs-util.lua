local ffi = require("ffi")

local libc = require("libc")
local putil = require("path-util")
local dirutil = require("dirent-util")


local function nil_iter()
    return nil;
end



-- This is a 'generator' which will continue
-- the iteration over files
local function gen_files(dir, state)
    local de = nil

    while true do
       de = libc.readdir(dir)
    
        -- if we've run out of entries, then return nil
        if de == nil then return nil end

        --dirutil.dirent_ensure_type(d, de);

    -- check the entry to see if it's an actual file, and not
    -- a directory or link
        if dirutil.dirent_is_file(de) then
            break;
        end
    end

    
    local name = ffi.string(de.d_name);

    return de, name
end

local function iterate_files_in_directory(path)
    local dir = libc.opendir(path)

    if not dir==nil then return nil_iter, nil, nil; end

    -- make sure to do the finalizer
    -- for garbage collection
    ffi.gc(dir, libc.closedir);

    return gen_files, dir, initial;
end

--[[
local F.get_files_in_directory(const char *path, char ***list) 
{
        _cleanup_closedir_ DIR *d = NULL;
        size_t bufsize = 0, n = 0;
        _cleanup_strv_free_ char **l = NULL;

        assert(path);

        /* Returns all files in a directory in *list, and the number
         * of files as return value. If list is NULL returns only the
         * number. */

        d = opendir(path);
        if (!d)
                return -errno;

        for (;;) {
                struct dirent *de;

                errno = 0;
                de = readdir(d);
                if (!de && errno != 0)
                        return -errno;
                if (!de)
                        break;

                dirent_ensure_type(d, de);

                if (!dirent_is_file(de))
                        continue;

                if (list) {
                        /* one extra slot is needed for the terminating NULL */
                        if (!GREEDY_REALLOC(l, bufsize, n + 2))
                                return -ENOMEM;

                        l[n] = strdup(de->d_name);
                        if (!l[n])
                                return -ENOMEM;

                        l[++n] = NULL;
                } else
                        n++;
        }

        if (list) {
                *list = l;
                l = NULL; /* avoid freeing */
        }

        return n;
}
--]]

local exports = {
    files_in_directory = iterate_files_in_directory;
}

return exports
