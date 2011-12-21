describe 'RomanNumerals:', ->
  describe 'convert()', ->
    it 'should return N when given 0', ->
      expect(RomanNumerals.convert(0)).toEqual('N')

    it 'should return MMCDI when given 2401', ->
      expect(RomanNumerals.convert(2401)).toEqual('MMCDI')

    it 'should return XCIX when given 99', ->
      expect(RomanNumerals.convert(99)).toEqual('XCIX')

    it 'should return XXIX when given 29', ->
      expect(RomanNumerals.convert(29)).toEqual('XXIX')

    it 'should return XXXVIII when given 38', ->
      expect(RomanNumerals.convert(38)).toEqual('XXXVIII')

    it 'should return MCMXCIX when given 1999', ->
      expect(RomanNumerals.convert(1999)).toEqual('MCMXCIX')

    it 'should return 1942 when given MCMXLII', ->
      expect(RomanNumerals.convert('MCMXLII')).toEqual(1942)

    it 'should return 4 when given IV', ->
      expect(RomanNumerals.convert('IV')).toEqual(4)

    it 'should return 3 when given III', ->
      expect(RomanNumerals.convert('III')).toEqual(3)

    it 'should return 291 when given CCXCI', ->
      expect(RomanNumerals.convert('CCXCI')).toEqual(291)

    it 'should throw an error if the number is too big', ->
      expect(-> RomanNumerals.convert(4000)).toThrow("Number `4000' is too small or too big. Must be bigger than 0 and smaller than 4000")

    it 'should throw an error if the number is negative', ->
      expect(-> RomanNumerals.convert(-1)).toThrow("Number `-1' is too small or too big. Must be bigger than 0 and smaller than 4000")
