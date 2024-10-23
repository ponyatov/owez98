#pragma once

/// @defgroup libc libc
/// @{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <string>
#include <list>
#include <stack>
/// @}

/// @defgroup main main
/// @{
int main(int argc, char *argv[]);
void arg(int argc, char *argv);
/// @}

/// @defgroup graph graph
/// @{

class Object {
    int ref;                          ///< reference counter
    static std::list<Object *> pool;  ///< global object pool

   public:
    Object();
    virtual ~Object();
    std::string dump();         ///< full text-tree dump
    std::string head();         ///< `<T:V>` header line
    virtual std::string tag();  ///< object class/type tag
    virtual std::string val();  ///< object value
};

class Primitive : public Object {};

class Int : public Primitive {
    int val;

   public:
    Int(int n);
    Int(char *c);
};

class Container : public Object {};

class Stack : public Container {
    std::stack<Object *> nest;

   public:
    void push(Object *o);
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

/// @defgroup vm vm
/// @{

/// @brief data stack
extern Stack *D;

/// @defgroup cmd cmd
/// @{
void push(Object *p);

/// @}

/// @}
