(function() {

  module.exports = function(redirect_map) {
    if (redirect_map == null) redirect_map = {};
    return function(req, res, next) {
      var host;
      host = req.header('Host');
      if (redirect_map[host]) {
        return res.redirect(redirect_map[host]);
      } else {
        return next();
      }
    };
  };

}).call(this);
