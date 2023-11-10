%token <string> ID
%token EQUAL
%token EOF

%type <Lang.L.Syntax.program> program

%start program

%{
%}

%%

(* PROGRAM *)

program:
  | stmts = list(stmt) EOF
    { stmts }
  
stmt:
  | x=ID EQUAL e=expr
    { Lang.L.Syntax.Assign (x,e) }
  | e=expr
    { Lang.L.Syntax.Eval e }

