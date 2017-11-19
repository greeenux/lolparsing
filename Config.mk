CC	:= gcc
LD	:= ld
INCLUDES	:= -I. -I$(TOPDIR)/include
DEFINES	:= -DDEBUG
CFLAGS	:= -O2 -W -Wall $(INCLUDES) $(DEFINES)

.SUFFIXES: .o .c .S

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@
%.o:%.S
	$(CC) $(CFLAGS) -c $< -o $@
