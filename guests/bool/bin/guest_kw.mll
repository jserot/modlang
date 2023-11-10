(* List of guest-specific keywords to be recognized by the lexer. *)
(* One line per keyword.
   For each keyword, the corresponding string and the associated token, separated by a comma and terminated  by a semi-colon
   See file ../../../../host/lib/lexer.cppo.mll for the list of keywords already defined by the host language *)

"true", TRUE;
"false", FALSE;
"and", AND;
"or", OR;
