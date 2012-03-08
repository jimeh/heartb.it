(function() {
  var host_rewrite;

  require('should');

  host_rewrite = require('../middleware/host_redirect');

  describe('host_redirect', function() {
    var redirect_map, redirector;
    redirect_map = {
      'www.foo.com': 'http://foo.com/',
      'img.foo.com': 'http://images.foo.com/'
    };
    redirector = host_rewrite(redirect_map);
    describe('when request does not match any entry in map', function() {
      return it('next() is called to pass on the request', function(done) {
        var next, req, res;
        req = {
          header: function() {
            return 'www.bar.com';
          }
        };
        res = {};
        next = function() {
          return done();
        };
        return redirector(req, res, next);
      });
    });
    return describe('when request matches an entry in map', function() {
      return it('req.redirect() is called with the new URL', function(done) {
        var next, req, res;
        req = {
          header: function() {
            return 'img.foo.com';
          }
        };
        res = {
          redirect: function(url) {
            url.should.equal(redirect_map[req.header()]);
            return done();
          }
        };
        next = function() {};
        return redirector(req, res, next);
      });
    });
  });

}).call(this);
