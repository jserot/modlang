open Lang
   
module Compiler =
  Host.Compiler.Make
    (L)
    (Lexer)
    (struct include Parser type program = L.Syntax.program end)
           
let _ = Printexc.print Compiler.main ()
