module syntax.statements;
import tokens.token;
import syntax.identifier;
import syntax.expressions;

enum StatementType
{
    LetStatement,
    ReturnStatement,
}

struct ReturnStatement
{
    // TODO: Implement return statement 
}

struct LetStatement
{
    Token* let; // `Let` Token
    Identifier* name; // `Ident` Token
    Expression* expr; // expr --> evaluate to a value type
}

struct Statement
{
    StatementType type;
    union
    {
        ReturnStatement* return_;
        LetStatement* let_;
    }
}
