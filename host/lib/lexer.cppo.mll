{
open Parser

module Location = Host.Location

type lexical_error =
    Illegal_character

exception Lexical_error of lexical_error * int * int

(* The table of keywords *)

let keyword_table = [
#include "guest_kw.mll"
]

type token = Parser.token
}

rule main = parse
  | [' ' '\t' '\010' '\013' ] +
      { main !Location.input_lexbuf }
  | ['a'-'z' ] ( ['A'-'Z' 'a'-'z' '0'-'9' '_' ] ) *
      { let s = Lexing.lexeme !Location.input_lexbuf  in
        try List.assoc s keyword_table
        with Not_found -> ID s }
  | "=" { EQUAL }
#include "guest_rules.mll"
  | eof { EOF }
  | _
      { raise (Lexical_error(Illegal_character,
                            Lexing.lexeme_start !Location.input_lexbuf, Lexing.lexeme_end !Location.input_lexbuf)) }
