.SILENT:
.PHONY: build watch

COFFEE_SRC = src
COFFEE_OUT = .
BIN = ./node_modules/.bin

build:
	$(BIN)/coffee -c -o $(COFFEE_OUT) $(COFFEE_SRC)

watch:
	$(BIN)/coffee -cw -o $(COFFEE_OUT) $(COFFEE_SRC)

docs:
	$(BIN)/docco $(shell find $(COFFEE_SRC) -name '*.coffee')
