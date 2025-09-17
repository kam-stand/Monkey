The Monkey programming language written in D lang

# Expression Grammer

expression → equality ;
equality → comparison ( ( "!=" | "==" ) comparison )_ ;
comparison → term ( ( ">" | ">=" | "<" | "<=" ) term )_ ;
term → factor ( ( "-" | "+" ) factor )_ ;
factor → unary ( ( "/" | "_" ) unary )\* ;
unary → ( "!" | "-" ) unary
| primary ;
primary → NUMBER | STRING | "true" | "false" | "nil"
| "(" expression ")" ;
