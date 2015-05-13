var through = require('../../lib/browserify-through.js');

module.exports = through({
  map: function (filepath, opts, data, done) {
    done(null, data.replace(opts.token, '__new_token__'));
  },

  filter: function (filepath, opts) {
    return new RegExp(opts.ext).test(filepath);
  }
});
