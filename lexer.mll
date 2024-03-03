(* lexer.mll *)

{
  open Parser
}
(* ocamlyacc -v  parser.mly 
    export OCAMLRUNPARAM='p'
*)

let digit = ['0' - '9']
let int = '-'? digit+
let letter = ['a' - 'z' 'A' - 'Z'] 
let alphanumeric = digit | letter
let variable = ('_'|['A'-'Z']) (alphanumeric | '_')*
let constant = "\"" letter (alphanumeric | '_')* "\""
let functor_symbol = ['a' - 'z' ] (alphanumeric | '_')*
let predicate_symbol = letter (alphanumeric | '_')*

rule token = parse
  | [' ' '\t' '\n']+  { token lexbuf }         (* Skip whitespace *)
  | '('               { LPAREN }
  | ')'               { RPAREN }
  | '['               { LSQUARE }
  | ']'               { RSQUARE }
  | ','               { COMMA }
  | '.'               { DOT }
  | ":-"              { ASSIGN }
  | variable as v     { VAR v }
  | int as i          { INT (int_of_string(i))}
  | constant as c     { CONST c }
  | functor_symbol as f { FUNC f }
  (* | predicate_symbol as p { PRED p } *)
  | eof               { EOF }
  | _                 { failwith ("Unexpected character: " ^ Lexing.lexeme lexbuf) }
