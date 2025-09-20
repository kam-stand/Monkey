module syntax.ast;
import syntax.statements;
import syntax.expressions;
import syntax.literal;

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
        case StatementType.ReturnStatement:
            printReturnStatement(stmt.return_);
            break;
        default:
            writeln("ExpressionStatement: ");
            printExpression(stmt.expr_.expr);
            break;
        }
    }
}

void printLetStatement(LetStatement* let_)
{
    writeln("\tKeyword: ", let_.let.literal);
    writeln("\tIdentifier: ", let_.name.ident.literal);
    writeln("\tInitializer:");
    printExpression(let_.expr, 2);

}

void printReturnStatement(ReturnStatement* ret_)
{

    writeln("\tKeyword: ", ret_.ret.literal);
    writeln("\tValue:");
    printExpression(ret_.expr, 2);

}

void printExpression(Expression* expr, int indent = 0)
{
    auto pad = "\t".repeat(indent);

    switch (expr.type)
    {
    case ExpressionType.Binary:
        printBinaryExpression(expr.binary, indent + 1);
        break;
    case ExpressionType.Unary:
        printUnaryExpression(expr.unary, indent + 1);
        break;
    case ExpressionType.Literal:
        printLiteral(expr.literal, indent);
        break;
    case ExpressionType.Ident:
        writefln("%sIdentifier: %s", pad, expr.ident.ident.literal);
        break;
    default:
        writefln("%s<unknown expr>", pad);
        break;
    }
}

void printBinaryExpression(BinaryExpression* bin, int indent = 0)
{
    auto pad = "\t".repeat(indent);
    writeln(pad, "BinaryExpression:");
    writefln("%sOperator: %s", pad, bin.operator.literal); // prefix expression
    printExpression(bin.left, indent + 1);
    printExpression(bin.right, indent + 1);
}

void printUnaryExpression(UnaryExpression* unary, int indent = 0)
{
    auto pad = "\t".repeat(indent);
    writeln(pad, "UnaryExpression:");
    writefln("%sOperator: %s", pad, unary.operator.literal);
    printExpression(unary.expr, indent + 1);
}

void printLiteral(Literal* lit, int indent = 0)
{
    auto pad = "\t".repeat(indent);
    final switch (lit.type)
    {
    case LiteralType.Int:
        writefln("%sLiteral[Int]: %d", pad, lit.num);
        break;
    case LiteralType.String:
        writefln("%sLiteral[String]: \"%s\"", pad, lit.str);
        break;
    case LiteralType.Bool:
        writefln("%sLiteral[Bool]: %s", pad, lit.val ? "true" : "false");
        break;
    case LiteralType.Null:
        writefln("%sLiteral[Null]: %s", pad, lit.str);
        break;

    }
}
