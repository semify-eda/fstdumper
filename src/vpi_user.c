#include <stddef.h>

#define FSTDUMP_EXPORT __attribute__((visibility("default")))

extern void sys_fst_register(void);

FSTDUMP_EXPORT void (*vlog_startup_routines[])() = {
  sys_fst_register,
  NULL
};

// For non-VPI compliant applications that cannot find vlog_startup_routines symbol
FSTDUMP_EXPORT void vlog_startup_routines_bootstrap() {
    // Call each routine in turn like VPI would
    int cnt = 0;
    while (vlog_startup_routines[cnt] != NULL)
    {
      vlog_startup_routines[cnt]();
      cnt++;
    }
}
