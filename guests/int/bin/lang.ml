(* The language itself (syntax, type-checker, evaluator) *)

(* Note: this functor application has to be put in a separate module to be referenced by the parser
   without creating a dependency cycle... *)

module L = Host.Main.Make(Guest_int.Top)

