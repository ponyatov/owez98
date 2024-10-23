%{
    #include "owez98.hpp"
%}

%option noyywrap yylineno

sign [+\-]
dec  [0-9]+
hex  [0-9a-fA-F]+
oct  [0-7]+
bin  [01]+
%%
#[^\n]*     {}                      /* drop spaces */
.           { yyerror("lexer"); }
