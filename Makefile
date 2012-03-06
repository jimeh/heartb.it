.SILENT:
.PHONY: build watch

COFFEE_SRC = src
COFFEE_OUT = .

build:
	coffee -c -o $(COFFEE_OUT) $(COFFEE_SRC)

watch:
	coffee -cw -o $(COFFEE_OUT) $(COFFEE_SRC)

docs:
	docco $(shell find $(COFFEE_SRC) -name '*.coffee')
