# Module Dependencies.
express = require 'express'

# Create server instance.
app = module.exports = express.createServer()

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

# Set port and start server.
app.listen process.env.PORT || 3000

# Print debug
console.log "Express app listening on port %d in %s mode",
  app.address().port, app.settings.env
