express = require 'express'
routes  = require './routes'
_       = require('underscore')._
Roman   = require './build/roman'
app = module.exports = express.createServer()
flickr = require('flickr-reflection')
flickrOptions =
  key: process.env.KEY
  secret: process.env.SECRET
  apis: ['photos']

# Configuration
app.configure ->
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(require('stylus').middleware( src: __dirname + '/public' ))
  app.use(app.router)
  app.use(express.static(__dirname + '/public'))

app.configure 'development', ->
  app.use(express.errorHandler( dumpExceptions: true, showStack: true ))

app.configure 'production', ->
  app.use(express.errorHandler())

# Routes

app.get '/', (req, res) ->
  res.render 'index.jade', title: "Roman.js"

app.get '/convert/:number', (req, res) ->
  res.send Roman.romanize(req.params.number)

getURL = (obj) ->
  "http://farm#{obj['farm']}.staticflickr.com/#{obj['server']}/#{obj['id']}_#{obj['secret']}.jpg"

app.get '/images/:letter', (req, res) ->
  letter = req.params.letter
  console.log "LETTER::::: #{letter}"
  obj = {}
  flickr.connect flickrOptions, (err, api) ->
    console.log "ERROR:::: #{err}" if err
    api.photos.search tags: "the letter #{letter}", (err, data) ->
      console.log "ERROR INNER:::: #{err}" if err
      photos =  _.map data.photos.photo, (photo) ->
        url: getURL(photo)
      res.send JSON.stringify(photos)

app.listen(process.env.PORT || 3000)

process.on 'uncaughtException', (err) ->
    console.log(err)


console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
