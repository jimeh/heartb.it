.SILENT:
.PHONY: build watch docs test deploy

BIN = ./node_modules/.bin
COFFEE_SRC = ./src
COFFEE_OUT = ./
REPORTER = spec
TEST_DIR = ./test

deploy:
	git push heroku master

build:
	$(BIN)/coffee -c -o $(COFFEE_OUT) $(COFFEE_SRC)

watch:
	$(BIN)/coffee -cw -o $(COFFEE_OUT) $(COFFEE_SRC)

docs:
	$(BIN)/docco $(shell find $(COFFEE_SRC) -name '*.coffee')

test:
	$(BIN)/mocha -R $(REPORTER) $(TEST_DIR)/*.js
