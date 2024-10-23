%{
    #include "owez98.hpp"
%}

%defines %union { Object *o; }

%%
syntax:

%%

extern void yyerror(const char *msg) {  //
    fprintf(stderr, "\n%s:%i:%s [%s]\n", filename, yylineno, msg, yytext);
    exit(-1);
}
