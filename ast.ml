(* ast.ml *)

type variable = string
type constant = string
type function_symbol = string
type predicate_symbol = string

type term =
  | Var of variable
  | Const of constant
  | Int of int
  | Func of function_symbol * (term list)
  | Empty 
  | Non_Empty 
  
type term_list = Terms of term list

type atomic_formula = Atm_form of predicate_symbol * (term list)

(* type atomic_formula_list = Atm_formulas of atomic_formula list *)

type fact = Fact of atomic_formula

type rule = Rule of atomic_formula * (atomic_formula list)

type clause =
  | Fact of fact
  | Rule of rule

type goal = Goal of (atomic_formula list)
type clause_list = Clause_list of clause list
