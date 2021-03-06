
BUILD = build
BIN = lib
OUTPUTNAME = libGameMenu.a
INCLUDE = -I./include

SRCFILES := $(shell find src/ -name *.cpp) 
OBJFILES := $(patsubst %.cpp,%.o,$(SRCFILES))
OBJFILES := $(foreach dir,$(OBJFILES),$(subst src/,,$(dir)))
DIR := $(dir $(OBJFILES))
TARGETLIST = $(foreach f,$(OBJFILES),$(BUILD)/$(f))

$(foreach d,$(DIR),$(shell mkdir -p $(BUILD)/$(d)))
$(shell mkdir -p $(BIN))

CC = g++ 
CFLAGS  = -g -std=c++11
LIBS=


G++_VER_LT48 := $(shell expr `$(CC) -dumpversion | cut -f1-2 -d.` \< 4.8 )
ifeq ("$(G++_VER_LT48)","1")
$(error old version of g++ not supported, upgrade to 4.8 or higher)
endif

$(info Source: $(SRCFILES))
$(info Targets: $(TARGETLIST))

default: $(BIN)/$(OUTPUTNAME)


$(BIN)/$(OUTPUTNAME): $(TARGETLIST)
	ar crf $(BIN)/$(OUTPUTNAME) $(TARGETLIST)


$(BUILD)/%.o: $(SRCFILES)
	$(CC) -c $(CFLAGS) $(INCLUDE) $(filter %$(notdir $(patsubst %.o,%.cpp,$@)),$(SRCFILES)) -o $@
