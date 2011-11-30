(function() {
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  jQuery(function() {
    var App, Image, ImageView, Images;
    Image = (function() {
      __extends(Image, Backbone.Model);
      function Image() {
        Image.__super__.constructor.apply(this, arguments);
      }
      return Image;
    })();
    Images = (function() {
      __extends(Images, Backbone.Collection);
      function Images() {
        Images.__super__.constructor.apply(this, arguments);
      }
      Images.prototype.model = Image;
      Images.prototype.getRandomURL = function() {
        return this.models[this.getRandom(0, this.models.length)].get('url');
      };
      Images.prototype.getRandom = function(min, max) {
        return Math.floor(Math.random() * (max - min) + min);
      };
      return Images;
    })();
    ImageView = (function() {
      __extends(ImageView, Backbone.View);
      function ImageView() {
        ImageView.__super__.constructor.apply(this, arguments);
      }
      ImageView.prototype.tagName = "li";
      ImageView.prototype.className = "image";
      ImageView.prototype.initalize = function() {
        return _.bind(this, "render");
      };
      ImageView.prototype.render = function() {
        var imageURL;
        imageURL = window[this.options.letter].getRandomURL();
        $(this.el).html($('<img/>').attr('src', imageURL));
        return this;
      };
      return ImageView;
    })();
    App = (function() {
      __extends(App, Backbone.View);
      function App() {
        App.__super__.constructor.apply(this, arguments);
      }
      App.prototype.className = "image_list";
      App.prototype.events = {
        "submit form": "displayLetters"
      };
      App.prototype.initialize = function() {
        var count, delay, self;
        $('<div class="alert-message"><p/>').text('Loading...').appendTo('.alert');
        self = this;
        _.bindAll(this, "displayLetters", "monitor", "convert");
        this.letters = ["I", "V", "X", "L", "C", "D", "M"];
        count = 0;
        delay = 0;
        return _.each(this.letters, function(letter) {
          setTimeout(function() {
            window[letter] = new Images;
            return $.getJSON("/images/" + letter, function(urls) {
              window[letter].reset(urls);
              return self.monitor(count++);
            });
          }, 200 * delay);
          return delay++;
        });
      };
      App.prototype.monitor = function(c) {
        if (c === this.letters.length - 1) {
          return new this.ready;
        }
      };
      App.prototype.ready = function() {
        $('.alert').html('');
        return $('<div class="alert-message"><p/>').text("Images Loaded").addClass('success').appendTo('.alert').delay(1500).fadeOut(350);
      };
      App.prototype.displayLetters = function() {
        var number;
        number = $('#roman').val();
        if (/^\d*$/.test(number) && number < 10000) {
          this.convert(number);
        } else {
          $('.alert').html('');
          $('<div class="alert-message"><p/>').text("Error").addClass('error').appendTo('.alert').delay(1500).fadeOut(350);
        }
        return false;
      };
      App.prototype.convert = function(number) {
        var $display, self;
        self = this;
        $display = $('#display');
        $display.html('');
        return $.get("/convert/" + number, function(data) {
          return _.each(data.split(''), function(letter) {
            var li, view;
            view = new ImageView({
              letter: letter
            });
            li = $(view.render().el);
            return $display.append(li);
          });
        });
      };
      return App;
    })();
    return window.app = new App({
      el: $("body")
    });
  });
}).call(this);
