# Module Dependencies.
express = require 'express'

# Create app instance.
app = express.createServer()

# Export the app.
module.exports = app

# Configuration.
app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'coffee'
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + '/public')

app.configure 'development', ->
  app.use express.errorHandler(dumpExceptions: true, showStack: true)

app.configure 'production', ->
  app.use express.errorHandler()
  app.use require('./lib/middleware/host_redirect')
    "www.heartb.it": "http://heartb.it/"


# Routes
app.get '/', (req, res) ->
  res.render 'index', format: true

# 404 Fallback
app.get '*', (req, res) ->
  res.render '404', format: true
