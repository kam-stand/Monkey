module syntax.expressions;

enum ExpressionType
{
    Unary,
    Binary
}

struct UnaryExpression
{

}

struct BinaryExpression
{

}

struct Expression
{
    ExpressionType type;
    union
    {
        UnaryExpression* unary;
        BinaryExpression* binary;
    }
}
