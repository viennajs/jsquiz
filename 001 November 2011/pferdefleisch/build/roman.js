(function() {
  var Numeralizer, Roman, _;
  _ = require('underscore')._;
  Roman = (function() {
    function Roman() {
      this.dictionary = {
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
      };
    }
    Roman.prototype.numberize = function(numerals) {
      var dictionary, difference, numbers, sum, _i, _ref, _results;
      dictionary = this.dictionary;
      difference = 0;
      this.chars = numerals.split('');
      numbers = _.map(this.chars, function(numeral) {
        return dictionary[numeral];
      });
      if (numbers.length > 1) {
        _((function() {
          _results = [];
          for (var _i = 1, _ref = numbers.length - 1; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--){ _results.push(_i); }
          return _results;
        }).apply(this)).each(function(curr, prev) {
          if (numbers[curr] > numbers[prev]) {
            return difference += numbers[prev] * 2;
          }
        });
        sum = _(numbers).reduce(function(sum, number) {
          return number + sum;
        });
        return sum - difference;
      } else {
        return numbers[0];
      }
    };
    Roman.prototype.romanize = function(number) {
      var numeralizer;
      numeralizer = new Numeralizer(number);
      return numeralizer.numerals();
    };
    return Roman;
  })();
  Numeralizer = (function() {
    function Numeralizer(number) {
      this.number = number;
      this.parts = this.number.toString().split("");
      this.map = {
        c: ["M", "D"],
        x: ["C", "L"],
        i: ["X", "V"]
      };
      while (this.parts.length < 4) {
        this.parts.unshift(0);
      }
    }
    Numeralizer.prototype.numerals = function() {
      var m, map, nums, parts, _i, _results;
      nums = [];
      parts = this.parts;
      map = this.map;
      m = parseInt(parts.shift());
      if (m !== 0) {
        nums.push((function() {
          _results = [];
          for (var _i = 1; 1 <= m ? _i <= m : _i >= m; 1 <= m ? _i++ : _i--){ _results.push(_i); }
          return _results;
        }).apply(this).map(function() {
          return "M";
        }).join(""));
      }
      _.each(["c", "x", "i"], function(numeral) {
        var part, _j, _k, _ref, _results2, _results3;
        part = parseInt(parts.shift());
        if (part !== 0) {
          if (part === 9) {
            nums.push("" + (numeral.toUpperCase()) + map[numeral][0]);
          }
          if (part > 5 && part < 9) {
            nums.push("" + map[numeral][1] + ((function() {
              _results2 = [];
              for (var _j = 1, _ref = i - 5; 1 <= _ref ? _j <= _ref : _j >= _ref; 1 <= _ref ? _j++ : _j--){ _results2.push(_j); }
              return _results2;
            }).apply(this).map(function() {
              return numeral.toUpperCase();
            }).join("")));
          }
          if (part === 5) {
            nums.push(map[numeral][1]);
          }
          if (part === 4) {
            nums.push("" + (numeral.toUpperCase()) + map[numeral][1]);
          }
          if (part < 4) {
            return nums.push((function() {
              _results3 = [];
              for (var _k = 1; 1 <= part ? _k <= part : _k >= part; 1 <= part ? _k++ : _k--){ _results3.push(_k); }
              return _results3;
            }).apply(this).map(function() {
              return numeral.toUpperCase();
            }).join(""));
          }
        }
      });
      return nums.join("");
    };
    return Numeralizer;
  })();
  module.exports = new Roman;
}).call(this);
