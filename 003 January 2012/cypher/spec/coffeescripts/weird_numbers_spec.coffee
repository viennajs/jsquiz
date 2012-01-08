describe 'WeirdNumbers:', ->
  describe 'find()' , ->
    it 'should find the smallest weird number', ->
      expect(WeirdNumbers.find(70)).toEqual([70])

    it 'should find all weird numbers below 20.000', ->
      expect(WeirdNumbers.find(20000)).toEqual([70, 836, 4030, 5830, 7192, 7912, 9272, 10430, 10570, 10792, 10990, 11410, 11690, 12110, 12530, 12670, 13370, 13510, 13790, 13930, 14770, 15610, 15890, 16030, 16310, 16730, 16870, 17272, 17570, 17990, 18410, 18830, 18970, 19390, 19670, 19810])

  describe 'divisors()', ->
    it 'finds all divisors for 2', ->
      expect((new WeirdNumbers).divisors(2)).toEqual([1, 2])

    it 'finds all divisors for 70', ->
      expect((new WeirdNumbers).divisors(70)).toEqual([1, 2, 5, 7, 10, 14, 35, 70])
