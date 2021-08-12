
SRCDIR = src
OBJDIR = obj

csrc = $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/*.cc)
obj = ${subst $(SRCDIR),$(OBJDIR),$(addsuffix .o, $(basename $(csrc)))}

$(info $(csrc))
$(info $(obj))

default: fstdumper.so

CFLAGS = -I $(SRCDIR)/config -fPIC -O2
LDFLAGS = -lz -shared

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

.PHONY: clean
clean:
	rm -f $(obj) fstdumper.so

