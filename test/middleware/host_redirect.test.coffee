require 'should'

host_redirect = require '../../lib/middleware/host_redirect'

describe 'host_redirect', ->

  redirect_map =
    'www.foo.com': 'http://foo.com/',
    'img.foo.com': 'http://images.foo.com/'

  redirector = host_redirect(redirect_map)

  describe 'when request does not match any entry in map', ->
    it 'next() is called to pass on the request', (done) ->
      req = header: -> 'www.bar.com'
      res = {}
      next = -> done()
      redirector(req, res, next)

  describe 'when request matches an entry in map', ->
    it 'req.redirect() is called with the new URL', (done) ->
      req = header: -> 'img.foo.com'
      res =
        redirect: (url) ->
          url.should.equal(redirect_map[req.header()])
          done()
      next = ->
      redirector(req, res, next)