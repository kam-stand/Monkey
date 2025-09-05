The Monkey programming language written in D lang

# Grammar

statement → | letStatement
| returnStatement
| expressionStatement ;

letStatement → "let" IDENT "=" expression ";" ;
returnStatement → "return" expression ";" ;
expressionStatement → expression ";" ;

expression → assignment ;

assignment → equality ;

equality → comparison (("==" | "!=") comparison)_ ;
comparison → term ((">" | "<") term)_ ;
term → factor (("+" | "-") factor)_ ;
factor → unary (("_" | "/") unary)\* ;
unary → ("!" | "-") unary | primary ;

primary → | INTEGER
| BOOLEAN
| IDENT
| "(" expression ")"
| ifExpression
| functionLiteral
| callExpression ;

functionLiteral → "fn" "(" parameters? ")" blockStatement ;
parameters → IDENT ("," IDENT)_ ;
callExpression → expression "(" arguments? ")" ;
arguments → expression ("," expression)_ ;

ifExpression → "if" "(" expression ")" blockStatement ("else" blockStatement)? ;

blockStatement → "{" statement\* "}" ;
