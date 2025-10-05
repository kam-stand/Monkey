module ast;
import token;

enum ExprType
{
    Unary,
    Binary,
    Primary
}

struct PrimaryExpression
{
    Token* literal;
}

struct UnaryExpression
{
    Token* op;
    Expression* rhs;
}

struct BinaryExpression
{
    Expression* lhs;
    Token* op;
    Expression* rhs;
}

struct Expression
{
    ExprType type;
    union
    {
        BinaryExpression* binary;
        UnaryExpression* unary;
        PrimaryExpression* primary;
    }
}

Expression* makeUnary(Token* op, Expression* rhs)
{
    auto unary = new UnaryExpression(op, rhs);
    auto expr = new Expression();
    expr.type = ExprType.Unary;
    expr.unary = unary;
    return expr;
}

Expression* makeBinary(Expression* lhs, Token* op, Expression* rhs)
{
    auto binary = new BinaryExpression(lhs, op, rhs);
    auto expr = new Expression();
    expr.type = ExprType.Binary;
    expr.binary = binary;
    return expr;
}

Expression* makePrimary(Token* literal)
{
    auto primary = new PrimaryExpression(literal);
    auto expr = new Expression();
    expr.type = ExprType.Primary;
    expr.primary = primary;
    return expr;
}
