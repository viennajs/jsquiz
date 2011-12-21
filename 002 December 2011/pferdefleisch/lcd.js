(function() {
  var DigitalNumber, Printer, printer;

  DigitalNumber = (function() {

    DigitalNumber.prototype.matchers = {
      t: {
        numbers: [0, 2, 3, 5, 6, 7, 8, 9],
        direction: "h"
      },
      tl: {
        numbers: [0, 4, 5, 6, 8, 9],
        direction: "v"
      },
      tr: {
        numbers: [0, 1, 2, 3, 4, 7, 8, 9],
        direction: "v"
      },
      m: {
        numbers: [2, 3, 4, 5, 6, 8, 9],
        direction: "h"
      },
      bl: {
        numbers: [0, 2, 6, 8],
        direction: "v"
      },
      br: {
        numbers: [0, 1, 3, 4, 5, 6, 7, 8, 9],
        direction: "v"
      },
      b: {
        numbers: [0, 2, 3, 5, 6, 8, 9],
        direction: "h"
      }
    };

    function DigitalNumber(n, size) {
      var rows;
      this.size = size != null ? size : 2;
      this.n = parseInt(n);
      rows = [];
      this.pushRow = function(row) {
        return rows.push(row);
      };
      this.getRows = function() {
        return rows;
      };
      this.makeRows();
    }

    DigitalNumber.prototype.makeRows = function() {
      var i, _ref, _ref2;
      this.pushRow(" " + (this.multiply(this.size, this.makeDashes("t"))) + "  ");
      for (i = 1, _ref = this.size; 1 <= _ref ? i <= _ref : i >= _ref; 1 <= _ref ? i++ : i--) {
        this.pushRow("" + (this.makeDashes('tl')) + (this.multiply(this.size, ' ')) + (this.makeDashes('tr')) + " ");
      }
      this.pushRow(" " + (this.multiply(this.size, this.makeDashes("m"))) + "  ");
      for (i = 1, _ref2 = this.size; 1 <= _ref2 ? i <= _ref2 : i >= _ref2; 1 <= _ref2 ? i++ : i--) {
        this.pushRow("" + (this.makeDashes('bl')) + (this.multiply(this.size, ' ')) + (this.makeDashes('br')) + " ");
      }
      return this.pushRow(" " + (this.multiply(this.size, this.makeDashes("b"))) + "  ");
    };

    DigitalNumber.prototype.multiply = function(n, dash) {
      var dashes, num;
      dashes = (function() {
        var _results;
        _results = [];
        for (num = 1; 1 <= n ? num <= n : num >= n; 1 <= n ? num++ : num--) {
          _results.push(dash);
        }
        return _results;
      })();
      return dashes.join("");
    };

    DigitalNumber.prototype.makeDashes = function(section) {
      var direction, numbers;
      numbers = this.matchers[section].numbers;
      direction = this.matchers[section].direction;
      if (this.include(numbers, this.n)) {
        if (direction === "h") {
          return "-";
        } else {
          return "|";
        }
      } else {
        return " ";
      }
    };

    DigitalNumber.prototype.include = function(array, val) {
      var num, result, _i, _len;
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        num = array[_i];
        if (num === val) result = num;
      }
      return !!result;
    };

    DigitalNumber.prototype.toDigital = function() {
      return this.getRows.join("\n");
    };

    return DigitalNumber;

  })();

  Printer = (function() {

    function Printer(n, size) {
      this.size = size != null ? size : 2;
      this.numbers = n.split('');
    }

    Printer.prototype.print = function() {
      if (this.numbers.length === 1) {
        return this.printSingleNumber();
      } else {
        return this.printNumbers();
      }
    };

    Printer.prototype.printSingleNumber = function() {
      var dn;
      dn = new DigitalNumber(this.numbers[0]);
      return console.log(dn.toDigital());
    };

    Printer.prototype.printNumbers = function() {
      var num, r, row, rows, _i, _ref, _ref2, _results, _results2;
      rows = (function() {
        var _i, _len, _ref, _results;
        _ref = this.numbers;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          num = _ref[_i];
          _results.push(new DigitalNumber(num, this.size).getRows());
        }
        return _results;
      }).call(this);
      _results = [];
      for (r = 0, _ref = rows[0].length; 0 <= _ref ? r < _ref : r > _ref; 0 <= _ref ? r++ : r--) {
        row = (function() {
          _results2 = [];
          for (var _i = 0, _ref2 = this.numbers.length; 0 <= _ref2 ? _i < _ref2 : _i > _ref2; 0 <= _ref2 ? _i++ : _i--){ _results2.push(_i); }
          return _results2;
        }).apply(this).map(function(column) {
          return rows[column][r];
        });
        _results.push(console.log(row.join('')));
      }
      return _results;
    };

    return Printer;

  })();

  printer = null;

  if (process.argv[2] === "-s") {
    printer = new Printer(process.argv[4], process.argv[3]);
  } else {
    printer = new Printer(process.argv[2]);
  }

  printer.print();

}).call(this);
