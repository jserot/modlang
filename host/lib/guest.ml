(**{1 Required signatures for the guest language} *)

(**{2 Syntax} *)
module type SYNTAX = sig 

  type expr

  val pp_expr: Format.formatter -> expr -> unit

end

(**{2 Values} *)
module type VALUE = sig 

  type t

  val pp: Format.formatter -> t -> unit

end

(**{2 Evaluation} *)
module type EVAL = sig 

  module Syntax : SYNTAX

  module Value : VALUE

  type env = (string * Value.t) list
  (** The type of dynamic environments, mapping identifiers to values. *)

  exception Illegal_expr of Syntax.expr
                          
  val eval_expr: env -> Syntax.expr -> Value.t
  (** [eval_expr env e] should return the value obtained by evaluating expression [e] in environment [env].
      Should raise {!exception:Illegal_expr} in case of failure. *)
    
end

(**{2 Global signature} *)

(** Each guest language must provide a set of modules conforming to module signature {!module-type:T}. *)

module type T = sig
  module Syntax : SYNTAX
  module Value : VALUE
  module Eval : EVAL with module Syntax = Syntax and module Value = Value
end

