module syntax.block_statement;
import syntax.statements;

struct BlockStatement
{
    Statement*[] statements;
}

BlockStatement* makeBlock(Statement*[] stmts)
{
    return new BlockStatement(stmts);
}
