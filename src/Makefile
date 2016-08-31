
VALA_FLAGS = 	--save-temps -X -w \
				--pkg=libalpm \
				--pkg=gio-2.0 \
				--pkg=posix \
				--vapidir=../vapi \
				-X -D_FILE_OFFSET_BITS=64

SOURCES = 	alpm_config.vala \
			alpm_octopi_utils.vala

all: libalpm_octopi_utils.so libalpm_octopi_utils.pc

clean:
	rm -f *.c alpm_octopi_utils.h alpm_octopi_utils.vapi libalpm_octopi_utils.so libalpm_octopi_utils.pc

libalpm_octopi_utils.so: ../vapi/libalpm.vapi $(SOURCES)
	valac	-o libalpm_octopi_utils.so \
			-X -fPIC \
			-X --shared \
			-H alpm_octopi_utils.h \
			--vapi=alpm_octopi_utils.vapi \
			--library=libalpm_octopi_utils \
			$(VALA_FLAGS) \
			$(SOURCES)

