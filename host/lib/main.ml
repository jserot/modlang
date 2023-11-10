(**{1 Host language definition} *)

(** Output signature of the functor {!Host.Make} *)
module type T = sig
  module Guest: Guest.T
  module Syntax: Syntax.SYNTAX 
  val pp_program: Syntax.program -> unit
  val eval_program: Syntax.program -> unit
end

(** Functor building the host language implementation given a guest language implementation *)
module Make (G: Guest.T)
       : T with module Guest = G
            and module Syntax = Syntax.Make(G.Syntax) =
struct
    module Guest = G
    module Syntax = Syntax.Make(G.Syntax)
    module Eval = Eval.Make(Syntax)(G.Eval)

    let pp_program p = Syntax.pp_program Format.std_formatter p

    let eval_program p = Eval.eval_program p
end
