(* The parser for the guest language *)
(* See file ../../../../host/lib/host_parser.mly for the list of keywords already defined by the host language *)

%token TRUE FALSE
%token AND OR NOT

(* Precedences and associativities for expressions *)

%left AND
%left OR

(* Nothing *)

%{
%}

%%

%public expr:
  | x = ID
      { Guest_bool.Syntax.EVar x }
  | v = bool_const
      { Guest_bool.Syntax.EBool v }
  | NOT e=expr
      { Guest_bool.Syntax.EUnop ("!",e) }
  | e1 = expr AND e2 = expr
     { Guest_bool.Syntax.EBinop ("and", e1, e2) }
  | e1 = expr OR e2 = expr
      { Guest_bool.Syntax.EBinop ("or", e1, e2) }

bool_const:
  | TRUE { true }
  | FALSE { false }
