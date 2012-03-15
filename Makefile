.SILENT:
.PHONY: build watch docs test deploy

BIN = ./node_modules/.bin
REPORTER = spec
TEST_DIR = ./test

deploy:
	git push heroku master

docs:
	$(BIN)/docco $(shell find $(COFFEE_SRC) -name '*.coffee')

test:
	$(BIN)/mocha -R $(REPORTER) $(shell find $(TEST_DIR) -name '*.test.coffee')
