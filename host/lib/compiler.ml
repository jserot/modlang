(**{1 The command-line compiler} *)

(** Output signature of the functor {!Compiler.Make} *)
module type T = sig
  val main: unit -> unit
end

(** Signature for the [Parser] input to the functor {!Compiler.Make} *)
module type PARSER = sig
  type token 
  type program
  exception Error
  val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> program
end

(** Signature for the [Lexer] input to the functor {!Compiler.Make} *)
module type LEXER = sig
  type token
  type lexical_error = Illegal_character
  exception Lexical_error of lexical_error * int * int
  val main: Lexing.lexbuf -> token
end

(** Functor building the compiler structure given a language definition, a lexer and a parser implementation *)
module Make
         (L: Main.T)
         (Lexer: LEXER)
         (Parser: PARSER with type token = Lexer.token and type program = L.Syntax.program) : T =
struct

  let usage = "usage: mlc [options...] file"

  let source_file = ref ""

  let anonymous fname = source_file := fname

  type options = {
    mutable dump_pgm: bool;
    }

  let options = {
    dump_pgm = false;
    }

  let opt_specs = [
      "-dump_program", Arg.Unit (fun () -> options.dump_pgm <- true), "dump program after parsing";
    ]

  let parse fname = 
    let ic = open_in_bin fname in
    Location.input_name := fname;
    Location.input_chan := ic;
    let lexbuf = Lexing.from_channel !Location.input_chan in
    Location.input_lexbuf := lexbuf;
    Parser.program Lexer.main !Location.input_lexbuf

  let compile () =
    let open L in
    let p = parse !source_file in
    if options.dump_pgm then 
      Format.printf "%a\n" Syntax.pp_program p;
    eval_program p

  let main () =
    let open Format in
    let open Location in
    let pp_loc fmt loc = Location.pp_location fmt loc in
    try
      Sys.catch_break true;
      (* Printexc.record_backtrace !Options.dump_backtrace; *)
      Arg.parse opt_specs anonymous usage;
      compile ()
    with
    | Parser.Error ->
       let pos1 = Lexing.lexeme_start !input_lexbuf in
       let pos2 = Lexing.lexeme_end !input_lexbuf in
       let loc = Loc(!input_name,pos1, pos2) in
       eprintf "%aSyntax error\n" pp_loc loc;
       flush stderr;
       exit 1
    | Lexer.Lexical_error(Lexer.Illegal_character, pos1, pos2) ->
       eprintf "%aIllegal character.\n" pp_loc (Loc(!input_name,pos1, pos2)); flush stderr; exit 1
    | Sys_error msg ->
       eprintf "Input/output error: %s.\n" msg; flush stderr;
       exit 21
    | Sys.Break -> flush stderr; exit 20
    | End_of_file -> exit 0
end
