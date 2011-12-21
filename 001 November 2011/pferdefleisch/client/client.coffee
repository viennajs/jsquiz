jQuery ->
  class Image extends Backbone.Model

  class Images extends Backbone.Collection
    model: Image

    getRandomURL: ->
      @models[@getRandom(0,@models.length)].get('url')

    getRandom: (min, max) ->
      Math.floor(Math.random() * (max - min) + min)

  class ImageView extends Backbone.View
    tagName: "li"
    className: "image"

    initalize: ->
      _.bind(@, "render")

    render: ->
      imageURL = window[@options.letter].getRandomURL()
      $(@el).html($('<img/>').attr('src',imageURL))
      @

  class App extends Backbone.View
    className: "image_list"

    events:
      "submit form": "displayLetters"

    initialize: ->
      $('<div class="alert-message"><p/>').text('Loading...').appendTo('.alert')
      self = @
      _.bindAll(@, "displayLetters", "monitor", "convert")

      @letters = ["I", "V", "X", "L", "C", "D", "M"]
      count = 0
      delay = 0

      _.each @letters, (letter) ->
        setTimeout ->
          window[letter] = new Images
          $.getJSON "/images/#{letter}", (urls) ->
            window[letter].reset(urls)
            self.monitor count++
        , 200 * delay 
        delay++

    monitor:  (c) ->
      if c == @letters.length - 1
        new @ready

    ready: ->
      $('.alert').html('')
      $('<div class="alert-message"><p/>').text("Images Loaded").addClass('success').appendTo('.alert').delay(1500).fadeOut(350)

    displayLetters: ->
      number = $('#roman').val()
      if (/^\d*$/).test(number) && number < 10000
        @convert number
      else
        $('.alert').html('')
        $('<div class="alert-message"><p/>').text("Error").addClass('error').appendTo('.alert').delay(1500).fadeOut(350)
      return false

    convert: (number) ->
      self = @
      $display = $('#display')
      $display.html('')
      $.get "/convert/#{number}", (data) ->
        _.each data.split(''), (letter) ->
          view = new ImageView(letter: letter)
          li = $(view.render().el)
          $display.append(li)

  window.app = new App(el: $("body"))
