.SILENT:
.PHONY: docs test deploy

BIN = ./node_modules/.bin

LIB_PATH = ./lib
TEST_PATH = ./test
REPORTER = spec

deploy:
	git push heroku master

docs:
	$(BIN)/docco app.coffee $(shell find $(LIB_PATH) -name '*.coffee')

test:
	$(BIN)/mocha -R $(REPORTER) $(shell find $(TEST_PATH) -name '*.test.coffee')
