open Ast
open Parser
open Lexing

let parse_with_error lexbuf =
  try
    Parser.program Lexer.token lexbuf
  with
  | Parsing.Parse_error ->
      let pos = lexbuf.Lexing.lex_curr_p in
      let line = pos.Lexing.pos_lnum in
      let col = pos.Lexing.pos_cnum - pos.Lexing.pos_bol in
      Printf.printf "Syntax error at line %d, column %d\n" line col;
      exit 1

(* Function to parse input string *)
let parse_string input =
  let lexbuf = Lexing.from_string input in
  try
    parse_with_error lexbuf
  with
  | Exit -> failwith "Parsing failed"  (* Removed () argument *)

(* Sample input *)
let input = " hello(H,as):-  hii(True).\n fun(9,). \n ?-fun(10)."

(* Parse the input *)
let clauses = parse_string input
