# var
MODULE = $(notdir $(CURDIR))
REL    = $(shell git rev-parse --short=4    HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
NOW    = $(shell date +%d%m%y)

# tool
CURL   = curl -L -o
CF     = clang-format -style=file -i

# src
C  += $(wildcard src/*.c*)
H  += $(wildcard inc/*.h*)
S  += lib/$(MODULE).ini $(wildcard lib/*.s)

CP += tmp/$(MODULE).parser.cpp tmp/$(MODULE).lexer.cpp
HP += tmp/$(MODULE).parser.hpp

# cfg
CFLAGS += -Iinc -Itmp -ggdb -O0

# all
.PHONY: all run cpp
all: bin/$(MODULE)
run: cpp
cpp: bin/$(MODULE) $(S)
	$^

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

# rule
bin/$(MODULE): $(C) $(H) $(CP) $(HP)
	$(CXX) $(CFLAGS) -o $@ $(C) $(CP) $(L)
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
doc/DoxygenLayout.xml:
	doxygen -l && mv DoxygenLayout.xml doc/

# install
.PHONY: install update ref gz
install: doc ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
ref:
gz:

# merge
MERGE += Makefile README.md apt.txt .gitignore
MERGE += .clang-format .doxygen
MERGE += .vscode bin doc lib inc src tmp ref

.PHONY: dev
dev:
	git push -v
	git checkout $@
	git pull -v
	git checkout $(USER) -- $(MERGE)
	$(MAKE) doxy ; git add -f docs

.PHONY: $(USER)
$(USER):
	git push -v
	git checkout $(USER)
	git pull -v

.PHONY: release
release:
	git tag $(NOW)-$(REL)
	git push -v --tags
	$(MAKE) $(USER)

ZIP = tmp/$(MODULE)_$(NOW)_$(REL)_$(BRANCH).zip
zip: $(ZIP)
$(ZIP):
	git archive --format zip --output $(ZIP) HEAD
