module print;
import ast;
import std.stdio;
import value;

/// Entry point
void printProgram(Program program)
{
    foreach (i, stmt; program.statements)
    {
        writeln("Statement ", i, ":");
        printStatement(stmt, "");
    }
}

/// Dispatch on statement type
void printStatement(Statement* stmt, string prefix)
{
    final switch (stmt.type)
    {
    case StatementType.Let:
        writeln(prefix, "|- LetStatement");
        printLetStatement(stmt.let, prefix ~ "   ");
        break;

    case StatementType.Expression:
        writeln(prefix, "|- ExpressionStatement");
        printExpressionStatement(stmt.expressionStmt, prefix ~ "   ");
        break;

    case StatementType.Value:
        writeln(prefix, "|- ValueStatement (TODO)");
        break;
    }
}

void printLetStatement(LetStatement* let, string prefix)
{
    writeln(prefix, "|- Identifier: ", let.name.literal);
    writeln(prefix, "|- Expression:");
    printExpression(let.expression, prefix ~ "   ");
}

void printExpressionStatement(ExpressionStatement* exprStmt, string prefix)
{
    printExpression(exprStmt.expression, prefix);
}

/// Recursive expression printer
void printExpression(Expression* expr, string prefix)
{
    final switch (expr.type)
    {
    case ExpressionType.Literal:
        printLiteral(expr.literal, prefix);
        break;

    case ExpressionType.Identifier:
        writeln(prefix, "|- IdentifierExpr: ", expr.identifier.name.literal);
        break;

    case ExpressionType.Unary:
        writeln(prefix, "|- UnaryExpr: ", expr.unary.negation.literal);
        printExpression(expr.unary.expression, prefix ~ "   ");
        break;

    case ExpressionType.Binary:
        writeln(prefix, "|- BinaryExpr: ", expr.binary.operator.literal);
        writeln(prefix, "   |- Left:");
        printExpression(expr.binary.left, prefix ~ "      ");
        writeln(prefix, "   |- Right:");
        printExpression(expr.binary.right, prefix ~ "      ");
        break;
    }
}

void printLiteral(LiteralExpression* lit, string prefix)
{
    final switch (lit.value.type)
    {
    case ValueType.Int:
        writeln(prefix, "|- Literal(Int): ", lit.value.number);
        break;

    case ValueType.String:
        writeln(prefix, "|- Literal(String): \"", lit.value.str, "\"");
        break;

    case ValueType.Boolean:
        writeln(prefix, "|- Literal(Boolean): ", lit.value.val);
        break;
    }
}
