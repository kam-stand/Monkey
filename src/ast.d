module ast;
import token;

struct Program
{
    Statements[] statements;
}

enum StatementType
{
    LetStatement,
    ReturnStatement,
    ExpressionStatement
}

struct Statements
{
    StatementType type;
    union
    {
        LetStatement let_;
        ReturnStatement return_;
        ExpressionStatement expression_;
    }

}

struct LetStatement
{
    Token ident;
    Expression expression;
}

struct ReturnStatement
{
    Expression expression;
}

struct ExpressionStatement
{
    Expression expression;
}

struct Expression
{

}
