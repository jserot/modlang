(* Module defining the guest language values *)
(* This module must match the signature [Guest.VALUE]  specified in ../../../host/lib/guest.ml *)

type t =
  Val_bool of bool

let pp fmt v =
  let open Format in
  match v with
  | Val_bool v -> fprintf fmt "%b" v
