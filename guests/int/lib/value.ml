(* Module defining the guest language values *)
(* This module must match the signature [Guest.VALUE]  specified in ../../../host/lib/guest.ml *)

type t =
  Val_int of int

let pp fmt v =
  let open Format in
  match v with
  | Val_int v -> fprintf fmt "%d" v
