# JSQuiz December 2011

## LCD Numbers
Totally stealing again from Ruby Quiz... again

The goal of this month's quiz will be to display LCD numbers at different sizes

The digits to be displayed will be passed as an argument to the program.  
Size should be controlled with an option `s` follow up by a positive integer. The default value for `s` is 2.

For example, assuming you've implemented this on the command line, if your program is called with:

    lcd.js 012345

The correct display is:

     --        --   --        -- 
    |  |    |    |    | |  | |   
    |  |    |    |    | |  | |   
               --   --   --   -- 
    |  |    | |       |    |    |
    |  |    | |       |    |    |
     --        --   --        -- 

And for:

    lcd.js -s 1 6789

Your program should print:

     -   -   -   - 
    |     | | | | |
     -       -   - 
    | |   | | |   |
     -       -   - 

## Notes

You do not need to produce ASCII art output, but your output should be built dynamically from some kind of source. Simply using a complete image for each digit won't fly.

However, you may use an image for the individual components of the digits.

## Notes on solutions

[Peter Neumark did a blog post](http://peterneumark.com/javascript/2011-12-12/roman-numerals-in-javascript/) on his solution as well.
