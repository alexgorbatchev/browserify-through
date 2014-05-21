# browserify-through

[![Dependency status](https://david-dm.org/alexgorbatchev/browserify-through.svg)](https://david-dm.org/alexgorbatchev/browserify-through)
[![devDependency Status](https://david-dm.org/alexgorbatchev/browserify-through/dev-status.svg)](https://david-dm.org/alexgorbatchev/browserify-through#info=devDependencies)
[![Build Status](https://secure.travis-ci.org/alexgorbatchev/browserify-through.svg?branch=master)](https://travis-ci.org/alexgorbatchev/browserify-through)

[![NPM](https://nodei.co/npm/browserify-through.svg)](https://npmjs.org/package/browserify-through)

Handy dandy helper to assist you with writing Browserify transforms.

## Installation

    npm install browserify-through

## Usage Example

```
var browserify = require('through');
var through = require('browserify-through');
var bundler = browserify('./src/index.js');

bundler.transform(through({
  map: (filepath, data, done) {
    done(null, data.replace(/foo/, 'bar'));
  },

  // optional filter
  filter: (filepath) {
    return /^\.js$/.test(filepath);
  }
}));
```

## API

### through({opts})

* `opts.map` - `function(filepath, data, [callback])` - Function should either return final data or call `callback(err, data)`.
* `opts.filter` - `function(filepath)` - If `filter` function returns `true` for a givel `filepath`, the content will be passed to the `map` function. It's much more efficient to do this step separately from the `map` function because if you want to just ignore the file, it will be passed through without being stored in memory to be passed into `map`.

## Testing

    npm test

## License

The MIT License (MIT)

Copyright 2014 Alex Gorbatchev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.