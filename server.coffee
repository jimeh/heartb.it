# Module Dependencies.
express = require 'express'

# Create server instance.
server = module.exports = express.createServer()

# Configuration.
server.configure ->
  server.set 'views', __dirname + '/views'
  server.set 'view engine', 'coffee'
  server.register '.coffee', require('coffeekup').adapters.express
  server.use express.bodyParser()
  server.use express.methodOverride()
  server.use express.static(__dirname + '/public')

server.configure 'development', ->
  server.use express.errorHandler(dumpExceptions: true, showStack: true)

server.configure 'production', ->
  server.use express.errorHandler()
  server.use require('./middleware/host_redirect')
    "www.heartb.it": "http://heartb.it/"


# Routes
server.get '/', (req, res) ->
  res.render 'index', format: true

# 404 Fallback
server.get '*', (req, res) ->
  res.render '404', format: true

# Set port and start server.
server.listen process.env.PORT || 3000

# Print debug
console.log "Express server listening on port %d in %s mode",
  server.address().port, server.settings.env
