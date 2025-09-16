module syntax.expressions;
import tokens.token;

enum ExpressionType
{
    Unary,
    Binary
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
        int val;
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
