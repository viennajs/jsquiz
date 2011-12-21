_ = require('underscore')._

class Roman
  constructor: ->
    @dictionary = 
      "I": 1,
      "V": 5,
      "X": 10,
      "L": 50,
      "C": 100,
      "D": 500,
      "M": 1000 

  numberize: (numerals) ->
    dictionary = @dictionary
    difference = 0
    @chars = numerals.split('')
    numbers = _.map @chars, (numeral) -> dictionary[numeral]
    if numbers.length > 1
      _([1..numbers.length - 1]).each (curr, prev) ->
        if numbers[curr] > numbers[prev]
          difference += numbers[prev] * 2
      sum = _(numbers).reduce (sum, number) ->
        number + sum
      sum - difference
    else
      numbers[0]
  
  romanize: (number) ->
    numeralizer = new Numeralizer(number)
    numeralizer.numerals()

class Numeralizer
  constructor: (number) ->
    @number = number
    @parts = @number.toString().split("")
    @map =
      c: ["M", "D"]
      x: ["C", "L"]
      i: ["X", "V"]
    while @parts.length < 4
      @parts.unshift 0
  numerals: ->
    nums = []
    parts = @parts
    map = @map
    m = parseInt parts.shift()
    unless m == 0
      nums.push [1..m].map( -> "M").join("")
    _.each ["c", "x", "i"],  (numeral) ->
      part = parseInt parts.shift()
      unless part == 0
        if part == 9
          nums.push "#{numeral.toUpperCase()}#{map[numeral][0]}"
        if part > 5 && part < 9
          nums.push "#{map[numeral][1]}#{[1..(i - 5)].map( -> numeral.toUpperCase()).join("")}"
        if part == 5
          nums.push map[numeral][1]
        if part == 4
          nums.push "#{numeral.toUpperCase()}#{map[numeral][1]}"
        if part < 4
          nums.push [1..part].map( -> numeral.toUpperCase()).join("")
    nums.join ""
module.exports = new Roman
