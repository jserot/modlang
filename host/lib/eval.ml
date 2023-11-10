(**{1 Evaluation of programs} *)

module type EVAL = sig
  module Syntax: Syntax.SYNTAX

  val eval_program: Syntax.program -> unit
end

module Make
         (HostSyntax: Syntax.SYNTAX)
         (GuestEval: Guest.EVAL with module Syntax = HostSyntax.Guest)
     : EVAL with module Syntax = HostSyntax =
struct

  module Syntax = HostSyntax

  let replace_assoc k v l = (k,v) :: List.remove_assoc k l 
    
  let eval_stmt (env,step) s =
    let open Format in
    match s with
    | Syntax.Eval e ->
       let v = GuestEval.eval_expr env e in
       fprintf std_formatter "%2d: %a\n" step GuestEval.Value.pp v;
       (env, step+1)
    | Syntax.Assign (x,e) -> 
       let v = GuestEval.eval_expr env e in
       fprintf std_formatter "%2d: %s:=%a\n" step x GuestEval.Value.pp v;
       (replace_assoc x v env, step+1)
       
  let eval_program p = 
    let env = [] in
    let _ = List.fold_left eval_stmt (env,1) p in
    ()
   
end
