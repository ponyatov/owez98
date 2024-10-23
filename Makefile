# var
MODULE = $(notdir $(CURDIR))

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*,h*)
S += lib/$(MODULE).ini $(wildcard lib/*.s)
CP += tmp/$(MODULE).parser.cpp tmp/$(MODULE).lexer.cpp
HP += tmp/$(MODULE).parser.hpp

# cfg
CFLAGS += -Iinc -Itmp -ggdb -O0

# all
.PHONY: all run cpp
all: bin/$(MODULE)
run: cpp
cpp: bin/$(MODULE) $(S)
	^$

# rule
bin/$(MODULE): $(C) $(H) $(CP) $(HP)
	$(CXX) $(CFLAGS) -o $(C) $(CP) $(L)
tmp/$(MODULE).lexer.cpp: src/$(MODULE).lex
	flex -o $@ $<
tmp/$(MODULE).parser.cpp: src/$(MODULE).yacc
	bison -o $@ $<

# doc
.PHONY: doc
doc:

.PHONY: doxygen
doxygen: .doxygen
	rm -rf docs ; doxygen $< 1>/dev/null

# install
.PHONY: install update ref gz
install: doc ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
ref:
gz:

