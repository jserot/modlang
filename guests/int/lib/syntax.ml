(* Module defining the guest language abstract syntax *)
(* This module must match the signature [Guest.SYNTAX]  specified in ../../../host/lib/guest.ml *)

module Location = Host.Location
  
type var = string
         
type expr = 
  | EVar of string
  | EInt of int
  | EBinop of string * expr * expr

let rec pp_expr fmt e =
  let open Format in
  match e with
  | EVar v -> fprintf fmt "%s" v
  | EInt i -> fprintf fmt "%d" i
  | EBinop (op,e1,e2) -> fprintf fmt "%a%s%a" pp_expr e1 op pp_expr e2

