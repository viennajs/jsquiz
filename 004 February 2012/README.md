# JSQuiz February 2012

## Dice roller

Write a JS function/object/thingamajig that accepts two arguments: a dice expression followed by the number of times to roll it. It should return and/or display the result(s).

The dice expression as BNF:

    <expr> := <expr> + <expr>
           |  <expr> - <expr>
           |  <expr> * <expr>
           |  <expr> / <expr>
           |  ( <expr> )
           |  [<expr>] d <expr>
           |  integer

* Integers are positive; never zero, never negative.
* The "d" (dice) expression XdY rolls a Y-sided die (numbered
  from 1 to Y) X times, accumulating the results.  X is optional
  and defaults to 1.
* All binary operators are left-associative.
* Operator precedence:
          ( )      highest
          d
          * /
          + -      lowest