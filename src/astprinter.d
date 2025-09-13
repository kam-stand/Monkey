module astprinter;

import ast;
import std.stdio;

void printAst(Program program)
{
    writeln("Program {");
    foreach (i, stmt; program.statements)
    {
        printStatement(stmt, "  ");
    }
    writeln("}");
}

void printStatement(Statements stmt, string indent)
{
    final switch (stmt.type)
    {
    case StatementType.LetStatement:
        writeln(indent, "|- LetStatement {");
        writeln(indent, "  |- Identifier: ", stmt.let_.ident.literal);
        writeln(indent, "  |- Expression:");
        printExpression(stmt.let_.expression, indent ~ "    ");
        writeln(indent, "}");
        break;

    case StatementType.ReturnStatement:
        writeln(indent, "|- ReturnStatement { ... }");
        break;

    case StatementType.ExpressionStatement:
        writeln(indent, "|- ExpressionStatement { ... }");
        break;
    }
}

void printExpression(Expression expr, string indent)
{
    switch (expr.type)
    {
    case ValueType.Integer:
        writeln(indent, "|- IntegerLiteral: ", expr.integer);
        break;
    case ValueType.Boolean:
        writeln(indent, "|- BooleanLiteral: ", expr.val ? "true" : "false");
        break;
    default:
        writeln(indent, "|- <unknown expression>");
        break;
    }
}
