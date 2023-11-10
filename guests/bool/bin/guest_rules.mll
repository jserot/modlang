(* List of guest-specific lexer rules *)
(* One line per rule, in [ocamllex] format *)
(* See file ../../../../host/lib/lexer.cppo.mll for the list of rules already defined by the host language *)

  | "!" { NOT }
