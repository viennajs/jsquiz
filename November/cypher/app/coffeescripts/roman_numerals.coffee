class RomanNumerals
  this.values_to_numerals = { 1000:"M", 900:"CM", 500:"D", 400:"CD", 100:"C", 90:"XC", 50:"L", 40:"XL", 10:"X", 9:"IX", 5:"V", 4:"IV", 1:"I" }

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
