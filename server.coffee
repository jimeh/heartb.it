# Load the app
app = require './app'

# Set port and start server.
app.listen process.env.PORT || 3000

# Print debug
console.log "Express app listening on port %d in %s mode",
  app.address().port, app.settings.env
