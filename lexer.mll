(* lexer.mll *)

{
  open Parser
}

let digit = ['0' - '9']
let letter = ['a' - 'z' 'A' - 'Z']
let alphanumeric = digit | letter
let variable = ('_' | letter) (alphanumeric | '_')*
let constant = letter (alphanumeric | '_')*
let functor_symbol = letter (alphanumeric | '_')*
let predicate_symbol = letter (alphanumeric | '_')*

exception Lexical_error of string  (* Define Lexical_error exception *)

rule token = parse
  | [' ' '\t' '\n']  { token lexbuf }         (* Skip whitespace *)
  | '('               { LPAREN }
  | ')'               { RPAREN }
  | ','               { COMMA }
  | '.'               { DOT }
  | variable as v     { VAR v }
  | constant as c     { CONST c }
  | functor_symbol as f { FUNC f }
  | predicate_symbol as p { PRED p }
  | eof               { EOF }
  | _                 { failwith ("Unexpected character: " ^ Lexing.lexeme lexbuf) }
