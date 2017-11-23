ifndef TOPDIR
TOPDIR	:= ..
endif

include $(TOPDIR)/Config.mk

TARGET	:= libmy.a
SUBDIRS	:=
OBJS	:= $(patsubst %.c, %.o, $(wildcard *.c))

TARGET :compile $(OBJS)
	$(AR) $(AR_MAKE_FLAGS) $(TARGET) $(OBJS)


include $(TOPDIR)/Rules.mk 
