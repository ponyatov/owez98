#pragma once

/// @defgroup libc libc
/// @{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
/// @}

/// @defgroup main main
/// @{
int main(int argc, char *argv[]);
void arg(int argc, char *argv);
/// @}

/// @defgroup graph graph
/// @{
class Object {
   public:
    Object();
    virtual ~Object();
};
/// @}

/// @defgroup skelex skelex
/// @{
extern int yylex();
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
extern char *filename;
extern int yyparse();
extern void yyerror(const char *msg);
#include "owez98.parser.hpp"
/// @}
