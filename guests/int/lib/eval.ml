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
                  
let builtin_ops = [
  "+", ( + );
  "-", ( - );
  "*", ( * );
  "/", ( / );
  ]

let lookup_op op = 
  try List.assoc op builtin_ops
  with Not_found -> raise (Undefined_operator op)

let rec eval_expr env e =
  match e with
  | Syntax.EVar x -> lookup env x
  | Syntax.EInt v -> Value.Val_int v
  | Syntax.EBinop (op,e1,e2) ->
     begin match eval_expr env e1, eval_expr env e2 with
     | Val_int v1, Val_int v2 -> Value.Val_int (lookup_op op v1 v2)
     end

     
     
