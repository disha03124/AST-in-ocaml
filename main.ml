open Ast
open Parser
open Lexing

(* Function to parse input string *)
let parse_string input =
  let lexbuf = Lexing.from_string input in
  Parser.program Lexer.token lexbuf

(* Sample input *)
let input = "apple(Red, Sweet):- hello(H, I), straw(90)."

(* Define string conversion functions *)
(* let rec string_of_term term =
  match term with
  | Var v -> v
  | Const c -> c
  | Func (f, args) ->
    let args_str = String.concat ", " (List.map string_of_term args) in
    Printf.sprintf "%s(%s)" f args_str

let string_of_term_list terms =
  String.concat ", " (List.map string_of_term terms)

let string_of_atomic_formula (predicate, terms) =
  let terms_str = string_of_term_list terms in
  Printf.sprintf "%s(%s)" predicate terms_str *)

(* Parse the input *)
let clauses = parse_string input

(* Display the parsed clauses *)
(* let () =
  List.iter (function
    | Fact f -> Printf.printf "Fact: %s\n" (string_of_atomic_formula f)
    | Rule (head, body) -> 
        let head_str = string_of_atomic_formula head in
        let body_str = String.concat ", " (List.map string_of_atomic_formula body) in
        Printf.printf "Rule: %s :- %s\n" head_str body_str
  ) clauses *)
