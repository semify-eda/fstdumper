
SRCDIR = src
OBJDIR = obj

csrc = $(wildcard $(SRCDIR)/*.c)
obj = ${subst $(SRCDIR),$(OBJDIR),$(csrc:.c=.o)}

$(info $(csrc))
$(info $(obj))

default: fstdumper.so

CFLAGS = -I $(SRCDIR)/config -fPIC
LDFLAGS = -lz -shared

$(OBJDIR):
	@mkdir $(OBJDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(OBJDIR)
	@echo Compiling $(<F)
	$(CC) -c -o $@ $< $(CFLAGS)

fstdumper.so: $(obj)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

.PHONY: clean
clean:
	rm -f $(obj) fstdumper.so

