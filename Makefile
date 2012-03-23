.SILENT:
.PHONY: deploy docs read-docs test build watch

BIN = ./node_modules/.bin

REPORTER = spec
TESTS    = ./test/**/*.test.coffee
SOURCES  = ./*.coffee ./lib/**/*.coffee

deploy:
	git push heroku master

docs:
	$(BIN)/docco $(shell find $(SOURCES))

read-docs:
	open docs/app.html

test:
	NODE_ENV=test $(BIN)/mocha \
		--reporter $(REPORTER) \
		$(shell find $(TESTS))

build:
	$(BIN)/coffee -c $(SOURCES)

watch:
	$(BIN)/coffee -cw $(SOURCES)
