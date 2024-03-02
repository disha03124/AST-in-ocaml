(* ast.ml *)

type variable = string
type constant = string
type function_symbol = string
type predicate_symbol = string

type term =
  | Var of variable
  | Const of constant
  | Func of function_symbol * term list

type atomic_formula = predicate_symbol * term list

type fact = atomic_formula

type rule = atomic_formula * atomic_formula list

type clause =
  | Fact of fact
  | Rule of rule

type goal = atomic_formula list
