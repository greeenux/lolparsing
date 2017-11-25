.EXPORT_ALL_VARIABLES:	#Pass all macros in the Makefile to the subdir's Makefile       #Makefile 내의 모든 매크로들을 하위 Makefile에 전달함

TARGET	:= lol		#software that we want to make  #우리가 만들고 싶은 프로그램	
TOPDIR	:= $(shell /bin/pwd)
#↑↑↑↑ The only way to use the results of a shell command as a macro  #쉘명령어를 매크로로 정의한느 유일한방법
SUBDIRS := object array value serialization parser various	#SUBDIRS that we will visit     #반복문을 돌기위한 서브디렉토리
include $(TOPDIR)/Config.mk	##read $(TOPDIR)/Config.mk file  #Config.mk파일 읽어들이고 포함하라는 의미


all: test_file.o libparsing.a	
	$(CC) $(CLFAGS) -o $(TARGET) test_file.o -L./ -lparsing

# in order to make TARGET(lol)file, we need main.o and libparsing.a		#타겟을 만들기위해 main.o libparsing.a이 필요
# ↑↑↑ referring to Config.mk,gcc --O2 -W -Wall  -I. -I$(TOPDIR)/include -DDEBUG -o lol test_file.o -L./ -lparsing
# ↑↑↑ Config.mk 파일을 참조하면 위에것은gcc --O2 -W -Wall  -I. -I$(TOPDIR)/include -DDEBUG -o lol test_file.o -L./ -lparsing 의미



test_file.o: $(TOPDIR)/main/main.c
	$(CC) -c $^ -I$(TOPDIR)/include
	$(MV) $(TOPDIR)/main.o $(TOPDIR)/$@ 

#in order to make test_file.o, we need main.c file. 				#타겟을 만들기위해 main.c가필요.
# ↑↑↑ referring to Config.mk, gcc -c $(TOPDIR/main/main.c -I$(TOPDIR)/include AND mv $(TOPDIR)/main.o $(TOPDIR)/test_file.o <change filename>
# ↑↑ Config.mk 파일을 참조하면, gcc -c $(TOPDIR/main/main.c -I$(TOPDIR)/include AND mv $(TOPDIR)/main.o $(TOPDIR)/test_file.o 의미



libparsing.a : compile $(OBJS)
	$(AR) $(AR_ADDING_FLAGS) $@ $(addprefix $(TOPDIR)/,$(addsuffix /libmy.a,$(SUBDIRS)))

#in order to make we need OBJS => which are defined in Rules.mk and SUBDIRS's Makefile
#libparsing.a파일을 만들기 위해서는 OBJS들이 필요한데 이것은 Rules.mk 파일에 정의 어떻게 얻을것인지 정의 되어있다.
#referring to Config.mk, ar -rvcT libparsing.a $(TOPDIR)/$(SUBDIRS)/libmy.a<which are from SUBDIRS's libmy.a>
#Config.mk파일을 참조하면, ar -rvcT libparsing.a $(TOPDIR)/$(SUBDIRS)/libmy.a 각각의 SUBDIRS부터 온 libmy.a를 libparsing.a로

include $(TOPDIR)/Rules.mk      #read $(TOPDIR)/Rules.mk file   #Rules.mk파일 읽어들이고 포함하라는 의미
