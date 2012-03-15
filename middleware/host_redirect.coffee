module.exports = (redirect_map = {}) ->
  (req, res, next) ->
    host = req.header('Host')
    if redirect_map[host]
      res.redirect(redirect_map[host])
    else
      next()