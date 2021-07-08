
prefix ?= /usr
bindir := $(prefix)/bin
libdir := $(prefix)/lib
includedir := $(prefix)/include
datadir := $(prefix)/share
localedir := $(datadir)/locale
sysconfdir ?= /etc

all: libalpm_octopi_utils.pc
	cd src && make

libalpm_octopi_utils.pc: src/libalpm_octopi_utils.pc.in
	sed -e 's|@libdir@|${prefix}/lib|g' \
		-e 's|@includedir@|${prefix}/include|g' \
		<src/libalpm_octopi_utils.pc.in >src/libalpm_octopi_utils.pc

clean:
	rm -f libalpm_octopi_utils.pc
	cd src && make clean

install:
	install -Dm644 src/alpm_octopi_utils.h $(DESTDIR)$(includedir)/alpm_octopi_utils.h
	install -Dm644 src/alpm_octopi_utils.vapi $(DESTDIR)$(datadir)/vala/vapi/alpm_octopi_utils.vapi
	install -Dm755 src/libalpm_octopi_utils.so $(DESTDIR)$(libdir)/libalpm_octopi_utils.so
	install -Dm644 src/libalpm_octopi_utils.pc $(DESTDIR)$(libdir)/pkgconfig/libalpm_octopi_utils.pc

uninstall:
	rm -f $(DESTDIR)$(includedir)/alpm_octopi_utils.h
	rm -f $(DESTDIR)$(datadir)/vala/vapi/alpm_octopi_utils.vapi
	rm -f $(DESTDIR)$(libdir)/libalpm_octopi_utils.so
	rm -f $(DESTDIR)$(libdir)/pkgconfig/libalpm_octopi_utils.pc
