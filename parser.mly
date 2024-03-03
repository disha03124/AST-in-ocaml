%{
    open Ast
    open List
    
    
%}
// %token <string> LPAREN RPAREN LSQUARE RSQUARE COMMA DOT ASSIGN VAR CONST FUNC INT EOF

%token <string> VAR CONST FUNC PRED KEYWORD 
%token <int> INT
%token<char> CUT UNDERSCORE
%token LPAREN RPAREN COMMA DOT EOF RSQUARE LSQUARE ASSIGN GOAL

%start program
%type <Ast.clause_list> program
%type <Ast.atomic_formula list> atomic_formula_list

%%

program:
   clause_list EOF {Printf.printf ":::program:::\n"; Clause_list ($1) }
   | clause_list goal DOT EOF { Prog ($1, $2)}

clause_list:
    clause DOT{Printf.printf ":::one    clause :::\n" ; [$1] }
  | clause_list clause DOT {Printf.printf ":::clause list:::\n"; $2 :: $1 }
  // | clause_list goal DOT {Prog ($1, $2)}
  
clause:
    fact { Printf.printf ":::fact:::\n"; Fact ($1) }
  | rule { Printf.printf ":::rule:::\n";  Rule ($1) }
  // | rule {Truth($1)}

fact:
    atomic_formula  {  Printf.printf ":::atomic formula1:::\n"; Fact ($1) }

rule:
    atomic_formula ASSIGN atomic_formula_list  { Printf.printf ":::found a rule:::\n";  Rule ($1, $3) }
    // | atomic_formula ASSIGN CUT {Printf.printf ":::atomic formula rule truth:::\n"; Truth($1, $3)}

atomic_formula:
    FUNC LPAREN term_list RPAREN { Printf.printf "Function %s\n" $1; Atm_form ($1, $3) }
    | CUT { Printf.printf "found ! %c\n" $1 ;Cut($1)}

atomic_formula_list:
    atomic_formula {Printf.printf "atomic formula3\n "; [$1]}
  | atomic_formula COMMA atomic_formula_list { Printf.printf ":::atomic formula list2:::\n"; $1 :: $3} 

term_list:
    term { Printf.printf "found one term \n" ; [$1] }
  | term COMMA term_list { Printf.printf "found more than one terms \n"; $1 :: $3 }

term:
    VAR { Printf.printf "var %s\n" $1 ; Var ($1) }
  | CONST { Printf.printf " const %s\n" $1 ; Const ($1) }
  | INT  { Printf.printf "int %d\n" $1 ;Int ($1)}
  | FUNC LPAREN term_list RPAREN {Printf.printf "function1 \n"; Func ($1, $3) }
  | LSQUARE RSQUARE { Printf.printf "found [] \n"; Empty }
  | LSQUARE term RSQUARE {  Printf.printf "found [ term ]\n";Non_Empty }
  | UNDERSCORE {Printf.printf "_\n" ; Underscore($1) }
  | FUNC {Printf.printf "Identifier %s\n" $1 ; Identifier ($1)}
  | term COMMA term      {MoreTerm ($1 , $3)}

goal:
    GOAL atomic_formula { Printf.printf "found a goal with one atomic formula\n";[$2] }
  // | goal COMMA atomic_formula { match $1 with Goal lst -> Goal ($3 :: lst) }
    | GOAL atomic_formula COMMA goal {  Printf.printf "found a goal with more atomic formula\n";$2 :: $4 }
