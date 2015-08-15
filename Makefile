ifdef CROSS_COMPILE
CC ?= $(CROSS_COMPILE)gcc
endif

ODIR ?= obj

_OBJ = memtool.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

all: DIRS $(ODIR)/memtool
	@file $(ODIR)/memtool

$(ODIR)/%.o: %.c
	$(CC) -c -pthread -o $@ $< $(CFLAGS)

$(ODIR)/memtool: $(OBJ)
	$(CC) -pthread -o $@ $^ $(LDFLAGS) $(LIBS)

DIRS:
	mkdir -p $(ODIR)

.PHONY : help
help:
	@echo "usage of this Makefile"
	@echo "make ODIR=/some/dir/ : builds the application (same as 'make all')" in /some/dir/
	@echo "make clean   : clean binaries"
	@echo "make release : makes a tar ball of these sources"
	@echo "make help    : this message"

.PHONY : clean
clean:
	-rm -rf $(ODIR)

.PHONY : release
release: clean
	tar cjf $(ODIR)/memtool.tar.bz2 *.c Makefile
