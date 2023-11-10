(**{1 Abstract syntax of the host language} *)

module type SYNTAX = sig

  module Guest: Guest.SYNTAX
  
  type expr = Guest.expr

  type var = string

  type program = stmt list

  and stmt = 
    | Assign of var * expr
    | Eval of expr
  
  val empty_program: program
    
  val pp_stmt: Format.formatter -> stmt -> unit
  val pp_program: Format.formatter -> program -> unit

end

module Make(G: Guest.SYNTAX) : SYNTAX with module Guest=G =
struct
  module Guest = G
               
  type expr = Guest.expr

  type var = string

  type program = stmt list

  and stmt = 
    | Assign of var * expr
    | Eval of expr

  let empty_program = []

  let pp_stmt fmt s = 
    let open Format in
    match s with
    | Assign (x,e) -> fprintf fmt "%s := %a" x Guest.pp_expr e
    | Eval e -> fprintf fmt "%a" Guest.pp_expr e
      
  let pp_program fmt p = 
    let open Format in
    let pp_cut fmt () = fprintf fmt "@," in
    fprintf fmt "@[<v>%a@]" (pp_print_list ~pp_sep:pp_cut pp_stmt) p

end
