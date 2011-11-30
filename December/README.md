# JSQuiz December 2011
## LCD Numbers
Totally stealing again from Ruby Quiz... again

The goal of this month's quiz will be to display LCD numbers at different sizes

The digits to be displayed will be passed as an argument to the program.  
Size should be controlled with the command-line option -s follow up by a positive integer. The default value for -s is 2.

For example, if your program is called with:

    lcd.rb 012345

The correct display is:

     --        --   --        -- 
    |  |    |    |    | |  | |   
    |  |    |    |    | |  | |   
               --   --   --   -- 
    |  |    | |       |    |    |
    |  |    | |       |    |    |
     --        --   --        -- 

And for:

    lcd.rb -s 1 6789

Your program should print:

     -   -   -   - 
    |     | | | | |
     -       -   - 
    | |   | | |   |
     -       -   - 
