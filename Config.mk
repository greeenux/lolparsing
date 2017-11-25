CC	:= gcc
MV	:= mv
AR	:= ar
INCLUDES	:= -I. -I$(TOPDIR)/include
DEFINES	:= -DDEBUG
CFLAGS	:= -O2 -W -Wall $(INCLUDES) $(DEFINES)
AR_MAKE_FLAGS := -rscv
AR_ADDING_FLAGS := -rvcT
.SUFFIXES: .o .c .S .a		#Element of .SUFFIXES are used to check extention rules. #.SUFFIXES요소들은 확장자 규칙을 검사하는데 사용된다.

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@
%.o:%.S
	$(CC) $(CFLAGS) -c $< -o $@
