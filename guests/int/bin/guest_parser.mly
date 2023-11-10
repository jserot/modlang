(* The parser for the guest language *)
(* See file ../../../../host/lib/host_parser.mly for the list of keywords already defined by the host language *)

%token <int> INT
%token PLUS MINUS TIMES DIV

(* Precedences and associativities for expressions *)

%left PLUS MINUS 
%left TIMES DIV

%{
%}

%%

%public expr:
  | e = simple_expr
      { e }
  | e1 = expr PLUS e2 = expr
     { Guest_int.Syntax.EBinop ("+", e1, e2) }
  | e1 = expr MINUS e2 = expr
      { Guest_int.Syntax.EBinop ("-", e1, e2) }
  | e1 = expr TIMES e2 = expr
      { Guest_int.Syntax.EBinop ("*", e1, e2) }
  | e1 = expr DIV e2 = expr
      { Guest_int.Syntax.EBinop ("/", e1, e2) }

simple_expr:
  | x = ID
      { Guest_int.Syntax.EVar x }
  | v = INT
      { Guest_int.Syntax.EInt v }
