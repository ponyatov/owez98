%{
    #include "owez98.hpp"
    char *filename = nullptr;
%}

%option noyywrap yylineno

sign [+\-]
dec  [0-9]+
hex  [0-9a-fA-F]+
oct  [0-7]+
bin  [01]+
%%
#[^\n]*     {}                          /* line comment     */
[ \t\r\n]+  {}                          /* drop spaces      */
{sign}{dec} { push(new Int(yytext)); }  /* integer          */
.           { yyerror("lexer"); }       /* undetected char  */
