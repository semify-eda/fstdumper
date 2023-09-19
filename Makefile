
SRCDIR = src
OBJDIR = obj

csrc = $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/*.cc)
obj = ${subst $(SRCDIR),$(OBJDIR),$(addsuffix .o, $(basename $(csrc)))}

$(info $(csrc))
$(info $(obj))

all: fstdumper.so

CFLAGS = -I $(SRCDIR)/config -fPIC -O2 -DDEBUG
LDFLAGS = -lz -shared

TESTBENCH = $(wildcard testbench/*.sv)

$(OBJDIR):
	@mkdir $(OBJDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(OBJDIR)
	@echo Compiling $(<F)
	$(CC) -c -o $@ $< $(CFLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.cc $(OBJDIR)
	@echo Compiling $(<F)
	$(CXX) -c -o $@ $< $(CFLAGS)

fstdumper.so: $(obj)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

Vtop.vvp: $(TESTBENCH)
	iverilog -o $@ -s div_int_tb $(TESTBENCH) -g2012

fstdumper.so.vpi : fstdumper.so
	@cp $< $@

simulation-iverilog: fstdumper.so.vpi Vtop.vvp
	vvp -M . -mfstdumper.so Vtop.vvp

simulation-xrun: fstdumper.so
	xrun -64bit +access+r -loadvpi ./fstdumper.so:vlog_startup_routines_bootstrap $(TESTBENCH) -top div_int_tb

simulation-vsim: fstdumper.so
	vlog -64 $(TESTBENCH)
	vsim -64 -c div_int_tb -vpicompatcb -pli fstdumper.so -do "run -all"

simulation-vcs: fstdumper.so
	vcs -sverilog -full64 +vpi -load ./fstdumper.so -debug_acc+pp+f+dmptf $(TESTBENCH)
	./simv

.PHONY: clean all simulation-iverilog simulation-xrun simulation-vsim
clean:
	rm -f $(obj) *.so *.so.vpi *.vvp *.fst

