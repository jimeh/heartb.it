# Module Dependencies
express = require 'express'
app = module.exports = express.createServer()


# Configuration
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
  app.use require('./middleware/host_redirect')
    "www.heartb.it": "http://heartb.it/"


# Routes
app.get '/', (req, res) ->
  res.render 'index', format: true


# Set port and start server.
app.listen process.env.PORT || 3000

console.log "Express server listening on port %d in %s mode",
  app.address().port, app.settings.env
