module syntax.expressions;
import tokens.token;
import syntax.literal;

enum ExpressionType
{
    Unary,
    Binary,
    Literal
}

struct UnaryExpression
{
    Token* operator;
    Expression* expr;
}

struct BinaryExpression
{
    Expression* right;
    Token* operator;
    Expression* left;

}

struct Expression
{
    ExpressionType type;
    union
    {
        UnaryExpression* unary;
        BinaryExpression* binary;
        Literal* literal;
    }
}

Expression* makeUnaryExpression(Token* operator, Expression* expr)
{
    auto unary = new Expression();
    unary.type = ExpressionType.Unary;
    unary.unary = new UnaryExpression(operator, expr);
    return unary;
}

Expression* makeBinaryExpression(Expression* left, Token* operator, Expression* right)
{
    auto binary = new Expression();
    binary.type = ExpressionType.Binary;
    binary.binary = new BinaryExpression(left, operator, right);
    return binary;
}

Expression* makeLiteralExpression(Literal* lit)
{
    auto literal = new Expression();
    literal.type = ExpressionType.Literal;
    literal.literal = lit;
    return literal;
}
