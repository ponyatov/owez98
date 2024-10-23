#include "owez98.hpp"

int main(int argc, char *argv[]) {  //
    arg(0, argv[0]);
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
        assert(yyin = fopen(argv[i], "r"));
        yyparse();
        fclose(yyin);
    }
}

void arg(int argc, char *argv) {  //
    fprintf(stderr, "argv[%i] = <%s>\n", argc, argv);
}

Object::Object() : ref(0) {}
Object::~Object() { assert(ref==0); }

#include <cxxabi.h>
std::string Object::tag() {
    std::string ret = abi::__cxa_demangle(typeid(*this).name(), 0, 0, nullptr);
    for (char &c : ret) c = tolower(c);
    return ret;
}

std::string Object::val() { return ""; }

std::string Object ::dump() { return head(); }
std::string Object ::head() { return tag(); }

Int::Int(int n) : val(n) {}
Int::Int(char *c) : val(atoi(c)) {}

Stack *D = new Stack();

void Stack::push(Object *o) { nest.push(o); }

void push(Object *o) { D->push(o); }
