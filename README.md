# fstdumper
Verilog VPI module to dump FST (Fast Signal Trace) databases

![fstdumper overview](doc/fstdump_overview.svg)

# Overview

The aim of this project is to provide a unified VPI module working on most simulators that provide extensive VPI support. This means that some features which rely on VPI constructs that aren't supported on all target simulators need to be disabled.

There is the possibility to enable simulator specific features by using defines:

Config file `/src/include/config.h`

```
#define ICARUS_VERILOG
```

# Example usage

```
module top;

logic clk;

initial
  begin
    $display("fstdumper!");
    clk = 1;
    
    $fstDumpfile("top.fst");
    $fstDumpvars(0, top);
    $fstDumplimit(1000);
    
    # 5 $fstDumpall;
    # 5 $fstDumpflush;
    # 5 $fstDumpoff;
    # 5 $fstDumpon;
    # 5 $finish;
  end

always #1 clk = ~clk;

endmodule
```


# Compatibility Matrix


| Simulator       | Version               | Status |
|-----------------|-----------------------|--------|
| Icarus Verilog  | Version 11.0 (stable) | works  |
| Cadence Xcelium | 19.09-s001            | works  |
|                 |                       |        |

You can contribute by 