(function() {
  var app, express;

  express = require('express');

  app = module.exports = express.createServer();

  app.configure(function() {
    app.set('views', __dirname + '/views');
    app.set('view engine', 'coffee');
    app.register('.coffee', require('coffeekup').adapters.express);
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    return app.use(express.static(__dirname + '/public'));
  });

  app.configure('development', function() {
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  app.configure('production', function() {
    app.use(express.errorHandler);
    return app.use(function(req, res, next) {
      console.log("Hostname: %s", req.header('Host'));
      if (req.header('Host') === 'www.heartb.it') {
        return res.redirect('http://heartb.it/');
      } else {
        return next();
      }
    });
  });

  app.get('/', function(req, res) {
    return res.render('index');
  });

  app.listen(process.env.PORT || 3000);

  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);

}).call(this);
