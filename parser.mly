%{
    open Ast
    open List
%}
// %token <string> LPAREN RPAREN LSQUARE RSQUARE COMMA DOT ASSIGN VAR CONST FUNC INT EOF

%token <string> VAR CONST FUNC PRED 
%token <int> INT
%token LPAREN RPAREN COMMA DOT EOF RSQUARE LSQUARE ASSIGN

%start program
%type <Ast.clause_list> program
%type <Ast.atomic_formula list> atomic_formula_list

%%

program:
   clause_list EOF { Clause_list ($1) }

clause_list:
    clause DOT{[$1] }
  | clause_list clause DOT { $2 :: $1 }
  
clause:
    fact { Fact ($1) }
  | rule { Rule ($1) }

fact:
    atomic_formula  { Fact ($1) }

rule:
    atomic_formula ASSIGN atomic_formula_list  { Rule ($1, $3) }

atomic_formula:
    FUNC LPAREN term_list RPAREN { Atm_form ($1, $3) }

atomic_formula_list:
    atomic_formula {[$1]}
  | atomic_formula COMMA atomic_formula_list {$1 :: $3} 

term_list:
    term {[$1] }
  | term COMMA term_list { $1 :: $3 }

term:
    VAR {Var ($1) }
  | CONST { Const $1 }
  | INT  {Int $1}
  | FUNC LPAREN term_list RPAREN {Func ($1, $3) }
  | LSQUARE RSQUARE { Empty }
  | LSQUARE term RSQUARE { Non_Empty }

goal:
    atomic_formula { Goal [$1] }
  | goal COMMA atomic_formula { match $1 with Goal lst -> Goal ($3 :: lst) }
