CC	:= gcc
MV	:= mv
AR	:= ar
INCLUDES	:= -I. -I$(TOPDIR)/include
DEFINES	:= -DDEBUG
CFLAGS	:= -O2 -W -Wall $(INCLUDES) $(DEFINES)
AR_MAKE_FLAGS := -rscv
AR_ADDING_FLAGS := -rvcT
.SUFFIXES: .o .c .S .a

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@
%.o:%.S
	$(CC) $(CFLAGS) -c $< -o $@
