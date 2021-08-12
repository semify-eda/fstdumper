# fstdumper
Verilog VPI module to dump FST (Fast Signal Trace) databases

![fstdumper overview](doc/fstdump_overview.svg)

The aim of this project is to provide a unified VPI module working on most simulators that provide extensive VPI support. This means that some features which rely on VPI constructs that aren't supported on all target simulators need to be disabled.

There is the possibility to enable simulator specific features by using defines:

Config file `/src/include/config.h`

```
#define ICARUS_VERILOG
```