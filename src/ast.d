module ast;
import token;
import literal;

struct Program
{
    Statements*[] statements;
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
        LetStatement* let_;
        ReturnStatement* return_;
        ExpressionStatement* expression_;
    }

}

struct LetStatement
{
    Token* let; // 'let'
    Token* ident; // 'x'
    Expression* expression; // 'expression'
}

struct ReturnStatement
{
    Token* return_; // 'return'
    Expression* expression; // 'expression'
}

struct ExpressionStatement
{
    Expression* expression;
}

struct UnaryExpression
{
    Token* operator;
    Literal literal;
}

struct BinaryExpression
{
    Expression* left;
    Token* operator;
    Expression* right;
}

struct Expression
{
    union
    {
        UnaryExpression* unary;
        BinaryExpression* binary;
    }
}
