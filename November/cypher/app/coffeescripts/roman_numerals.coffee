class RomanNumerals
  # NOTE: This relies on the order of the keys being preserved, which isn't actually guaranteed
  this.values_to_numerals = { 1000:"M", 900:"CM", 500:"D", 400:"CD", 100:"C", 90:"XC", 50:"L", 40:"XL", 10:"X", 9:"IX", 5:"V", 4:"IV", 1:"I" }
  this.numerals_to_values = { "M":1000, "CM":900, "D":500, "CD":400, "C":100, "XC":90, "L":50, "XL":40, "X":10, "IX":9, "V":5, "IV":4, "I":1 }

  this.convert = (number) ->
    is_roman_numeral = /^[IVXLCDM]+$/.test(number)

    if is_roman_numeral
      this.convertRomanToNumber(number)
    else
      this.convertNumberToRoman(number)

  this.convertNumberToRoman = (number) ->
    if (number < 0 || number > 3999)
      throw "Number `#{number}' is too small or too big. Must be bigger than 0 and smaller than 4000"

    if number == 0
      return "N"

    result = ''

    for value, numeral of this.values_to_numerals
      while number >= value
        number -= value;
        result += numeral

    result

  this.convertRomanToNumber = (roman) ->
    if roman == "N"
      return 0

    token = /[MDLV]|C[MD]?|X[CL]?|I[XV]?/g
    number = 0

    while m = token.exec(roman)
      number += this.numerals_to_values[m[0]];

    return number
