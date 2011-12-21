####################################################################

class DigitalNumber
  matchers:
    t:
      numbers: [0,2,3,5,6,7,8,9]
      direction: "h"
    tl:
      numbers: [0,4,5,6,8,9]
      direction: "v"
    tr:
      numbers: [0,1,2,3,4,7,8,9]
      direction: "v"
    m:
      numbers: [2,3,4,5,6,8,9]
      direction: "h"
    bl:
      numbers: [0,2,6,8]
      direction: "v"
    br:
      numbers: [0,1,3,4,5,6,7,8,9]
      direction: "v"
    b:
      numbers: [0,2,3,5,6,8,9]
      direction: "h"

  constructor: (n, @size = 2) ->
    @n = parseInt(n)
    rows = []
    @pushRow = (row) -> rows.push(row)
    @getRows = -> rows
    @makeRows()

  makeRows: ->
    @pushRow(" #{@multiply(@size, @makeDashes("t"))}  ")
    for i in [1..@size]
      @pushRow("#{@makeDashes('tl')}#{@multiply(@size, ' ')}#{@makeDashes('tr')} ")
    @pushRow(" #{@multiply(@size, @makeDashes("m"))}  ")
    for i in [1..@size]
      @pushRow("#{@makeDashes('bl')}#{@multiply(@size, ' ')}#{@makeDashes('br')} ")
    @pushRow(" #{@multiply(@size, @makeDashes("b"))}  ")

  multiply: (n, dash) ->
    dashes = for num in [1..n]
      dash
    dashes.join("")

  makeDashes: (section) ->
    numbers = @matchers[section].numbers
    direction = @matchers[section].direction
    if @include(numbers, @n)
      if direction == "h" then "-" else "|"
    else
      " "

  include: (array, val) ->
    result = num for num in array when num == val
    !!result

  toDigital: ->
    @getRows.join("\n")

################################################################################

class Printer

  constructor: (n, @size = 2) ->
    @numbers = n.split('')

  print: ->
    if @numbers.length == 1 then @printSingleNumber() else @printNumbers()

  printSingleNumber: ->
    dn = new DigitalNumber(@numbers[0])
    console.log dn.toDigital()

  printNumbers: ->
    rows = for num in @numbers
      new DigitalNumber(num, @size).getRows()
    for r in [0...rows[0].length]
      row = [0...@numbers.length].map (column) ->
        rows[column][r]
      console.log row.join('')

################################################################################
# Option Parser :P

printer = null

if process.argv[2] == "-s"
  printer = new Printer(process.argv[4], process.argv[3])
else
  printer = new Printer(process.argv[2])

printer.print()

###################################################################################
