module parser;
import ast;
import lexer;
import token;
import std.stdio;
import std.conv;

/** 
 * https://www.less-bug.com/en/posts/pratt-parsing-introduction-and-implementation-in-typescript/
 */

enum Precedence
{
    Add = 0,
    Sub = 0,
    Mult = 1,
    Div = 1
}

class Parser
{

public:
    Token*[] tokens;

    this(Token*[] tokens)
    {
        this.tokens = tokens;
    }

    Expression* parse()
    {
        if (tokens[pos].type == TokenType.Eof)
            return null;
        return parseExpression(0);
    }

    void display(Expression* node)
    {
        if (node is null)
            return;

        final switch (node.type)
        {
        case ExprType.Primary:
            write(node.primary.literal.lexeme); // assuming your Token has a .value or .lexeme field
            break;

        case ExprType.Binary:
            write("(");
            write(node.binary.op.lexeme); // e.g. '+', '*', etc.
            write(" ");
            display(node.binary.lhs);
            write(" ");
            display(node.binary.rhs);
            write(")");
            break;

        case ExprType.Unary:
            write("(");
            write(node.unary.op.lexeme);
            write(" ");
            display(node.unary.rhs);
            write(")");
            break;
        }
    }

private:

    size_t pos = 0;

    Precedence getPrecedence(TokenType t)
    {
        switch (t)
        {
        case TokenType.Plus:
            return Precedence.Add;
        case TokenType.Minus:
            return Precedence.Sub;
        case TokenType.Asterisk:
            return Precedence.Mult;
        case TokenType.Slash:
            return Precedence.Div;
        default:
            return Precedence.min;
        }
    }

    Expression* parseNud(Token* token)
    {
        // Only literals for now
        if (token.type == TokenType.Int)
        {
            return makePrimary(token);
        }

        throw new Exception("Unexpected token in parseNud: " ~ token.type.to!string);
    }

    Expression* parseLed(Token* op, Expression* lhs)
    {
        pos++; // consume operator
        auto rhs = parseExpression(getPrecedence(op.type));
        return makeBinary(lhs, op, rhs);
    }

    Expression* parseExpression(int minPrecedence)
    {
        auto token = tokens[pos];
        pos++;

        auto lhs = parseNud(token);

        while (pos < tokens.length &&
            tokens[pos].type != TokenType.Eof &&
            minPrecedence <= getPrecedence(tokens[pos].type))
        {
            auto op = tokens[pos];
            pos++;
            auto rhs = parseExpression(getPrecedence(op.type));
            lhs = makeBinary(lhs, op, rhs);
        }

        return lhs;
    }

}

unittest
{
    import std.stdio;

    // 1. Input: represents "1 + 2"
    byte[] input = ['1', '+', '2'];

    // 2. Tokenize input
    Lexer lex = new Lexer(input);

    writeln(lex.tokens.length);

    // 3. Create parser with the tokens
    Parser p = new Parser(lex.tokens);

    // 4. Parse to get an AST
    auto ast = p.parse();

    assert(ast != null);

    // 5. Display the AST structure
    p.display(ast); // should print: (+ 1 2)
    writeln(); // newline for cleanliness

}
