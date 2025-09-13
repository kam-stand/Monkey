module ast;
import token;
import value;

struct IdentifierExpression
{
    Token* name;
}

IdentifierExpression* makeIdentifierExpression(Token* name)
{
    return new IdentifierExpression(name);
}

struct LiteralExpression
{
    Value* value;
}

LiteralExpression* makeLiteralExpression(Value* value)
{
    return new LiteralExpression(value);
}

struct UnaryExpression
{
    Token* negation;
    Expression* expression;
}

UnaryExpression* makeUnaryExpression(Token* negation, Expression* expr)
{
    return new UnaryExpression(negation, expr);
}

struct BinaryExpression
{
    Expression* left;
    Token* operator;
    Expression* right;
}

BinaryExpression* makeBinaryExpression(Expression* left, Token* op, Expression* right)
{
    return new BinaryExpression(left, op, right);
}

Expression* newBinary(Expression* left, Token* op, Expression* right)
{
    Expression* e = new Expression();
    e.type = ExpressionType.Binary;
    e.binary = makeBinaryExpression(left, op, right);
    return e;
}

Expression* newUnary(Token* op, Expression* right)
{
    Expression* e = new Expression();
    e.type = ExpressionType.Unary;
    e.unary = makeUnaryExpression(op, right);
    return e;
}

Expression* newLiteral(Value* v)
{
    Expression* e = new Expression();
    e.type = ExpressionType.Literal;
    e.literal = makeLiteralExpression(v);
    return e;
}

Expression* newIdentifier(Token* name)
{
    Expression* e = new Expression();
    e.type = ExpressionType.Identifier;
    e.identifier = makeIdentifierExpression(name);
    return e;
}

enum ExpressionType
{
    Unary,
    Binary,
    Literal,
    Identifier
}

struct Expression
{
    ExpressionType type;
    union
    {
        UnaryExpression* unary;
        BinaryExpression* binary;
        LiteralExpression* literal;
        IdentifierExpression* identifier;
    }
}

struct LetStatement
{
    Token* name;
    Expression* expression;
}

LetStatement* makeLetStatement(Token* name, Expression* expr)
{
    return new LetStatement(name, expr);
}

enum StatementType
{
    Let,
    Expression,
    Value
}

struct Statement
{
    StatementType type;
    union
    {
        LetStatement* let;
        Expression* expression;
        Value* value;
    }
}

struct Program
{
    Statement*[] statements;
}
