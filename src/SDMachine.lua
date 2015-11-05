--SDMachine.lua
local ffi = require("ffi")
local sysd = require("systemd_ffi")
local fsutil = require("fs-util")


local function nil_gen()
	return nil;
end

local SDMachine = {}
local SDMachine_mt = {
	__index = SDMachine;
}

--[[
_public_ int sd_get_machine_names(char ***machines) {
        char **l = NULL, **a, **b;
        int r;

        assert_return(machines, -EINVAL);

        r = get_files_in_directory("/run/systemd/machines/", &l);
        if (r < 0)
                return r;

        if (l) {
                r = 0;

                /* Filter out the unit: symlinks */
                for (a = l, b = l; *a; a++) {
                        if (startswith(*a, "unit:") || !machine_name_is_valid(*a))
                                free(*a);
                        else {
                                *b = *a;
                                b++;
                                r++;
                        }
                }

                *b = NULL;
        }

        *machines = l;
        return r;
}
--]]

function SDMachine.machineNames(self)
-- filter these out
-- if (startswith(*a, "unit:") || !machine_name_is_valid(*a))

	return fsutil.files_in_directory("/run/systemd/machines/")
end


function SDMachine.sessionNames(self)
	return fsutil.files_in_directory("/run/systemd/sessions/")
end


function SDMachine.seatNames(self)
	return fsutil.files_in_directory("/run/systemd/seats/")
end


return SDMachine
