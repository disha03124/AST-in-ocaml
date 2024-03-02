(* parser.mly *)

%token <string> VAR CONST FUNC PRED
%token LPAREN RPAREN COMMA DOT EOF 

%start program
%type <Ast.clause list * Ast.goal> program
%type <Ast.clause list> clause_list
%type <Ast.atomic_formula list> atomic_formula_list
%type <Ast.clause> clause
%type <Ast.goal> goal
%type <Ast.atomic_formula > atomic_formula
%type <Ast.term list> term_list
%type <Ast.term> term
%type <Ast.fact> fact
%type <Ast.rule> rule


%%

program:
  | clause_list goal EOF { ($1, $2) }

clause_list:
  | clause { [$1] }
  | clause_list clause { $2 :: $1 }
  
atomic_formula_list:
  | atomic_formula {[$1]}
  | atomic_formula_list atomic_formula {$2 :: $1} 
clause:
  | fact { Fact $1 }
  | rule { Rule $1 }

fact:
  | atomic_formula DOT { $1 }

rule:
  | atomic_formula LPAREN atomic_formula_list RPAREN DOT { $1, $3 }

atomic_formula:
  | PRED LPAREN term_list RPAREN { ($1, $3) }

term_list:
  | term { [$1] }
  | term_list COMMA term { $3 :: $1 }

term:
  | VAR { Var $1 }
  | CONST { Const $1 }
  | FUNC LPAREN term_list RPAREN { Func ($1, $3) }

goal:
  | { [] }
  | atomic_formula { [$1] }
  | goal COMMA atomic_formula { $3 :: $1 }
