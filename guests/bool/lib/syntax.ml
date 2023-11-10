(* Module defining the guest language dynamic semantics *)
(* This module must match the signature [Guest.EVAL]  specified in ../../../host/lib/guest.ml *)

module Location = Host.Location
  
type var = string
         
type expr = 
  | EVar of string
  | EBool of bool
  | EUnop of string * expr
  | EBinop of string * expr * expr

let rec pp_expr fmt e =
  let open Format in
  match e with
  | EVar v -> fprintf fmt "%s" v
  | EBool b -> fprintf fmt "%b" b
  | EUnop (op,e) -> fprintf fmt "%s%a" op pp_expr e
  | EBinop (op,e1,e2) -> fprintf fmt "%a %s %a" pp_expr e1 op pp_expr e2

