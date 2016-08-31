
CFLAGS = `pkg-config --cflags --libs glib-2.0 libalpm libalpm_octopi_utils`
LIBS = `pkg-config --libs glib-2.0 libalpm libalpm_octopi_utils`

all: search

clean:
	rm -f search

search: search.c
	gcc	-o search \
		$(CFLAGS) \
		$(LIBSS) \
		search.c
