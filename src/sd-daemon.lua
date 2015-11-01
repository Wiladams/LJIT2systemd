local ffi = require("ffi")

require("platform")

--#include "_sd-common.h"

--[[
/*
  The following functionality is provided:

  - Support for logging with log levels on stderr
  - File descriptor passing for socket-based activation
  - Daemon startup and status notification
  - Detection of systemd boots

  See sd-daemon(3) for more information.
*/

/*
  Log levels for usage on stderr:

          fprintf(stderr, SD_NOTICE "Hello World!\n");

  This is similar to printk() usage in the kernel.
*/
#define SD_EMERG   "<0>"  /* system is unusable */
#define SD_ALERT   "<1>"  /* action must be taken immediately */
#define SD_CRIT    "<2>"  /* critical conditions */
#define SD_ERR     "<3>"  /* error conditions */
#define SD_WARNING "<4>"  /* warning conditions */
#define SD_NOTICE  "<5>"  /* normal but significant condition */
#define SD_INFO    "<6>"  /* informational */
#define SD_DEBUG   "<7>"  /* debug-level messages */

/* The first passed file descriptor is fd 3 */
#define SD_LISTEN_FDS_START 3
--]]

ffi.cdef[[

int sd_listen_fds(int unset_environment);

int sd_is_fifo(int fd, const char *path);

int sd_is_special(int fd, const char *path);

int sd_is_socket(int fd, int family, int type, int listening);

int sd_is_socket_inet(int fd, int family, int type, int listening, uint16_t port);

int sd_is_socket_unix(int fd, int type, int listening, const char *path, size_t length);

int sd_is_mq(int fd, const char *path);


int sd_notify(int unset_environment, const char *state);

int sd_notifyf(int unset_environment, const char *format, ...);

int sd_pid_notify(pid_t pid, int unset_environment, const char *state);

int sd_pid_notifyf(pid_t pid, int unset_environment, const char *format, ...) ;

int sd_pid_notify_with_fds(pid_t pid, int unset_environment, const char *state, const int *fds, unsigned n_fds);

int sd_booted(void);

int sd_watchdog_enabled(int unset_environment, uint64_t *usec);
]]


