(function() {
  var express, server;

  express = require('express');

  server = module.exports = express.createServer();

  server.configure(function() {
    server.set('views', __dirname + '/views');
    server.set('view engine', 'coffee');
    server.register('.coffee', require('coffeekup').adapters.express);
    server.use(express.bodyParser());
    server.use(express.methodOverride());
    return server.use(express.static(__dirname + '/public'));
  });

  server.configure('development', function() {
    return server.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  server.configure('production', function() {
    server.use(express.errorHandler());
    return server.use(require('./middleware/host_redirect')({
      "www.heartb.it": "http://heartb.it/"
    }));
  });

  server.get('/', function(req, res) {
    return res.render('index', {
      format: true
    });
  });

  server.get('*', function(req, res) {
    return res.render('404', {
      format: true
    });
  });

  server.listen(process.env.PORT || 3000);

  console.log("Express server listening on port %d in %s mode", server.address().port, server.settings.env);

}).call(this);
