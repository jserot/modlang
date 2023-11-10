(* Module defining the guest language dynamic semantics *)
(* This module must match the signature [Guest.EVAL]  specified in ../../../host/lib/guest.ml *)

module Syntax = Syntax

module Value = Value

type env = (string * Value.t) list

exception Illegal_expr of Syntax.expr
exception Undefined_symbol of string
exception Undefined_operator of string
                  
let lookup env x =
  try List.assoc x env
  with Not_found -> raise (Undefined_symbol x)

let builtin_unops = [
  "!", ( not );
  ]

let builtin_binops = [
  "and", ( && );
  "or", ( || );
  ]

let lookup_binop, lookup_unop = 
  let lookup ops op = 
    try List.assoc op ops
    with Not_found -> raise (Undefined_operator op) in
  (lookup builtin_binops,
   lookup builtin_unops)

let rec eval_expr env e =
  match e with
  | Syntax.EVar x -> lookup env x
  | Syntax.EBool v -> Value.Val_bool v
  | Syntax.EUnop (op,e) ->
     begin match eval_expr env e with
     | Val_bool v -> Value.Val_bool (lookup_unop op v)
     end
  | Syntax.EBinop (op,e1,e2) ->
     begin match eval_expr env e1, eval_expr env e2 with
     | Val_bool v1, Val_bool v2 -> Value.Val_bool (lookup_binop op v1 v2)
     end

     
     
