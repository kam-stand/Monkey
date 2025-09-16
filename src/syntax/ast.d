module syntax.ast;
import syntax.statements;
import syntax.expressions;

import std.stdio;
import tokens.token;

string repeat(string str, int index)
{
    string repeated_string = "";
    while (index > 0)
    {
        repeated_string ~= str;
        index--;
    }

    return repeated_string;
}

void printAst(Statement*[] statements)
{
    foreach (stmt; statements)
    {
        switch (stmt.type)
        {
        case StatementType.LetStatement:
            printLetStatement(stmt.let_);
            break;
        default:
            writeln("Unknown statement");
            break;
        }
    }
}

void printLetStatement(LetStatement* let_)
{
    writeln("LetStatement:");
    writefln("\t%s %s =", let_.let.literal, let_.name.ident.literal);
    printExpression(let_.expr, 2);
}

void printExpression(Expression* expr, int indent = 0)
{
    auto pad = "\t".repeat(indent);
    writeln(pad, "Expression:");

    switch (expr.type)
    {
    case ExpressionType.Binary:
        printBinaryExpression(expr.binary, indent + 1);
        break;
    case ExpressionType.Unary:
        printUnaryExpression(expr.unary, indent + 1);
        break;
        // case ExpressionType.Literal:
        //     writefln("%sLiteral: %s", pad, expr.literal.value.toString());
        //     break;
        // case ExpressionType.Identifier:
        //     writefln("%sIdentifier: %s", pad, expr.ident.literal);
        //     break;
    default:
        writefln("%s<unknown expr>", pad);
        break;
    }
}

void printBinaryExpression(BinaryExpression* bin, int indent = 0)
{
    auto pad = "\t".repeat(indent);
    writeln(pad, "BinaryExpression:");
    printExpression(bin.left, indent + 1);
    writefln("%sOperator: %s", pad, bin.operator.literal);
    printExpression(bin.right, indent + 1);
}

void printUnaryExpression(UnaryExpression* unary, int indent = 0)
{
    auto pad = "\t".repeat(indent);
    writeln(pad, "UnaryExpression:");
    writefln("%sOperator: %s", pad, unary.operator.literal);
    printExpression(unary.expr, indent + 1);
}
