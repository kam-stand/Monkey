module syntax.statements;
import tokens.token;
import syntax.identifier;
import syntax.expressions;
import syntax.block_statement;

enum StatementType
{
    LetStatement,
    ReturnStatement,
    ExpressionStatement,
    BlockStatement
}

struct ExpressionStatement
{
    Expression* expr;
}

struct ReturnStatement
{
    Token* ret;
    Expression* expr;
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
        ExpressionStatement* expr_;
        BlockStatement* block_;
    }
}

Statement* makeReturnStatement(Token* ret, Expression* expr)
{
    auto statement = new Statement();
    statement.type = StatementType.ReturnStatement;
    statement.return_ = new ReturnStatement(ret, expr);
    return statement;
}

Statement* makeLetStatement(Token* let, Expression* expr, Token* ident)
{
    auto statement = new Statement();
    statement.type = StatementType.LetStatement;
    auto name = makeIdentifier(ident);
    statement.let_ = new LetStatement(let, name, expr);
    return statement;
}

Statement* makeExpressionStatement(Expression* expr)
{
    auto statement = new Statement();
    statement.type = StatementType.ExpressionStatement;
    statement.expr_ = new ExpressionStatement(expr);
    return statement;
}

Statement* makeBlockStatement(BlockStatement* block)
{
    auto statement = new Statement();
    statement.type = StatementType.BlockStatement;
    statement.block_ = block;
    return statement;
}
