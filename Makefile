.SILENT:
.PHONY: deploy docs read-docs test

BIN = ./node_modules/.bin

LIB_PATH = ./lib
TEST_PATH = ./test
REPORTER = spec

deploy:
	git push heroku master

docs:
	$(BIN)/docco app.coffee $(shell find $(LIB_PATH) -name '*.coffee')

read-docs:
	open docs/app.html

test:
	$(BIN)/mocha -R $(REPORTER) $(shell find $(TEST_PATH) -name '*.test.coffee')
