/* description: Parses end evaluates mathematical expressions. */

/* lexical grammar */
%lex
%%
\s+                   { /* skip whitespace */ }
[dD]                  { return 'DICE'; }
[0-9]+                { return 'INTEGER'; }
"*"                   { return '*'; }
"/"                   { return '/'; }
"-"                   { return '-'; }
"+"                   { return '+'; }
"("                   { return '('; }
")"                   { return ')'; }
<<EOF>>               { return 'EOF'; }

/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%right DICE

%start expressions

%% /* language grammar */

expressions:
      expression_list EOF                     { console.log($1); return $1; }
    ;

expression_list:
    /* nothing */                             { $$ = 0; }
    | expression                              { $$ = $1; }
    ;

dice_roll:
      group_or_integer DICE group_or_integer  { $$ = $1 * (Math.floor(Math.random() * ($3)) + 1); }
    | DICE group_or_integer                   { $$ = Math.floor(Math.random() * ($2)) + 1; }
    ;

group_or_integer:
      INTEGER                                 { $$ = Number(yytext); }
    | grouped_expr                            { $$ = $1; }
    ;

grouped_expr:
     '(' expression ')'                       { $$ = $2; }
    ;

expression:
      expression '+' expression               { $$ = $1 + $3; }
    | expression '-' expression               { $$ = $1 - $3; }
    | expression '*' expression               { $$ = $1 * $3; }
    | expression '/' expression               { $$ = $1 / $3; }
    | dice_roll                               { $$ = $1; }
    | group_or_integer                        { $$ = $1; }
    ;
