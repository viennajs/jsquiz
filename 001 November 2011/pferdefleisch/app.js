(function() {
  var Roman, app, express, flickr, flickrOptions, getURL, routes, _;

  express = require('express');

  routes = require('./routes');

  _ = require('underscore')._;

  Roman = require('./build/roman');

  app = module.exports = express.createServer();

  flickr = require('flickr-reflection');

  flickrOptions = {
    key: process.env.KEY,
    secret: process.env.SECRET,
    apis: ['photos']
  };

  app.configure(function() {
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(require('stylus').middleware({
      src: __dirname + '/public'
    }));
    app.use(app.router);
    return app.use(express.static(__dirname + '/public'));
  });

  app.configure('development', function() {
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  app.configure('production', function() {
    return app.use(express.errorHandler());
  });

  app.get('/', function(req, res) {
    return res.render('index.jade', {
      title: "Roman.js"
    });
  });

  app.get('/convert/:number', function(req, res) {
    return res.send(Roman.romanize(req.params.number));
  });

  getURL = function(obj) {
    return "http://farm" + obj['farm'] + ".staticflickr.com/" + obj['server'] + "/" + obj['id'] + "_" + obj['secret'] + ".jpg";
  };

  app.get('/images/:letter', function(req, res) {
    var letter, obj;
    letter = req.params.letter;
    console.log("LETTER::::: " + letter);
    obj = {};
    return flickr.connect(flickrOptions, function(err, api) {
      if (err) console.log("ERROR:::: " + err);
      return api.photos.search({
        tags: "the letter " + letter
      }, function(err, data) {
        var photos;
        if (err) console.log("ERROR INNER:::: " + err);
        photos = _.map(data.photos.photo, function(photo) {
          return {
            url: getURL(photo)
          };
        });
        return res.send(JSON.stringify(photos));
      });
    });
  });

  app.listen(process.env.PORT || 3000);

  process.on('uncaughtException', function(err) {
    return console.log(err);
  });

  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);

}).call(this);
