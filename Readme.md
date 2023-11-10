This a demo project showing how to design and implement a _parameterized_ language in `OCaml` using
modules and functors.

A parameterized language `L` is a language for which a subset `X` is not fixed but can be modified,
giving several _instances_ `L(X)`. 

As an illustration, consider a language `L1` describing a very simple calculator. Programs in this language are
sequences of _statements_, where a statement is either
- an expression to computed and displayed
- assignation of a expression value to a _variable_

For example, if expressions denote integers and basic arithmeric operations on integers, execution of the following program

```
x=1
x+1
y=x*2
x+y
```

should display
```
2
6
```

Formally, the syntax of this language can be described by the following grammar :

```
<program> ::= <stmt>*

<stmt> ::=
  | <var> = <expr>
  | <expr>

<expr> :=
        | <var>
        | <int>
        | <expr> <op> <expr>

<op> := + | - | * | /
```

The `<stmt>` and `<program>` nodes describe the general structure of programs. This structure does
not depend on the actual definition of `<expr>`. We could use it, for instance, for defining a
language `L2` for which expressions denote boolean values, by rewriting `<expr>` as 

```
<expr> :=
        | <var>
        | true
        | false
        | <unop> <expr> 
        | <expr> <binop> <expr> 

<unop> := !
<binop> := or | and 
```

so that the execution of this program, for example

```
x=false
!x
y=x and !x
y
```

should display
```
true
false
```

This "separation of concern" can be explicited by 
_parameterizing_ the language `L` describing programs by the language `E` describing expressions.
The languages `L1` and `L2` defined above are then simply obtained by _instanciating_ `L` with the
adequate parameter :

```
L1 = L(I)
L2 = L(B)
```

where
- `L` defines `<program>` and `<stmt>` 
- `I` is the definition of `<expr>` we have given for integer expressions
- `B` is the definition of `<expr>` we have given for boolean expressions

When a language `T` can be defined as `T=H(G)` we say that `H` is the _host_ language and `G` the
_guest_ language. 

This project proposes a general framework for implementing this idea using OCaml _parameterized
modules_ (aka _functors_). This framework is built upon 
a library (in `./host/lib`) describing the syntax and semantics of the host language `L` and providing the
infrastructure for building a command-line compiler for the target language.

The idea is that, for defining a new language `L(G)`, one just has to
- define the abstract syntax and semantics of the guest language `G` in modules `G.Syntax`, `G.Semantics`, ...
- define the concrete syntax of the guest language as a [menhir](http://cambium.inria.fr/~fpottier/menhir) parser
- apply the `L.Compiler.Make` functor to the guest-specific modules

Two examples are provided in the directory `guests` :
- one for the guest language `I` describing integer expressions (in `./guests/int`)
- one for the guest language `B` describing boolean expressions (in `./guests/int`)

To build the corresponding compilers and test them :
- `cd guests/xxx`
- `make`
- `make test`

Notes
-----

The framework described is used, form  in a more elaborated form, to build the
[RFSM](https://github.com/jserot/rfsm) compiler.

This work was inspired by that described by X. Leroy in the paper [A modular module system](https://inria.hal.science/hal-01499946v1/file/modular-modules-jfp.pdf),
published in the _Journal of Functional Programming_. 

