#ifndef DEBUG_H
#define DEBUG_H

#ifndef DEBUG
#define DEBUG 0
#endif

#define debug_print(...) \
            do { if (DEBUG) { fprintf(stderr, "%s(%d) : ", __FILE__, __LINE__); fprintf(stderr, __VA_ARGS__); } } while (0)

#endif
