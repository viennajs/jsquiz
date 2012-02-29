/* description: Parses end evaluates mathematical expressions. */

/* lexical grammar */
%lex
%%
\s+                   { /* skip whitespace */ }
[dD]                  { return 'DICE'; }
[0-9]+\b              { return 'INTEGER'; }
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
    expression_list EOF             { console.log($1); return $1; }
  ;

expression_list:
  /* nothing */                     { $$ = 0; }
  | expression                      { $$ = $1; }
  ;

expression:
      expression '+' expression     { $$ = $1 + $3; }
    | expression '-' expression     { $$ = $1 - $3; }
    | expression '*' expression     { $$ = $1 * $3; }
    | expression '/' expression     { $$ = $1 / $3; }
    | expression DICE expression    { $$ = $1 * (Math.floor(Math.random() * ($3)) + 1); }
    | DICE expression               { $$ = Math.floor(Math.random() * ($2)) + 1; }
    | '(' expression ')'            { $$ = $2; }
    | INTEGER                       { $$ = Number(yytext); }
    ;
