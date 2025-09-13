module parser;
import ast;
import token;
import std.conv;
import literal;

class Parser
{

    Token[] tokens;
    int current;
    this(Token[] tokens)
    {
        this.tokens = tokens;
        this.current = 0;
    }

    Token peek()
    {
        return tokens[current];
    }

    Token advance()
    {
        return !isAtEnd() ? tokens[current++] : previous();
    }

    Token previous()
    {
        return tokens[current - 1];
    }

    Token consume(TokenType type)
    {
        if (check(type))
        {
            return advance();
        }
        return Token(TokenType.Illegal, null);
    }

    bool check(TokenType type)
    {
        return isAtEnd() ? false : peek().type == type;
    }

    bool isAtEnd()
    {
        return peek().type == TokenType.Eof;
    }

    Program parseProgram()
    {
        Statements[] stmts;
        while (!isAtEnd())
        {
            stmts ~= parseStatement();
        }
        return Program(stmts);
    }

    Statements parseStatement()
    {
        Statements stmt;
        switch (peek().type)
        {
        case TokenType.Let:
            auto let = parseLetStatement();
            stmt.type = StatementType.LetStatement;
            stmt.let_ = let;
            break;
        default:
            // could skip or return an empty statement
            advance();
            break;
        }
        return stmt;
    }

    LetStatement parseLetStatement()
    {
        LetStatement let;

        consume(TokenType.Let); // 'let'
        auto ident = consume(TokenType.Ident);
        consume(TokenType.Assign); // '='

        auto expr = parseExpression();
        consume(TokenType.Semicolon); // ';'

        let.ident = ident;
        let.expression = expr;
        return let;
    }

    Expression parseExpression()
    {
        Expression expr;

        switch (peek().type)
        {
        case TokenType.Int:
            expr.type = ValueType.Integer;
            auto lit = parseIntegerLiteral();
            expr.integer = lit.integer;
            advance();
            break;
        case TokenType.True:
        case TokenType.False:
            expr.type = ValueType.Boolean;
            auto lit = parseBooleanLiteral();
            expr.val = lit.val;
            advance();
            break;
        default:
            advance(); // skip unknowns for now
            break;
        }

        return expr;
    }

    Literal parseIntegerLiteral()
    {
        auto value = Literal();
        auto integer = to!int(peek().literal);
        value.type = LiteralType.Integer;
        value.integer = integer;
        return value;
    }

    Literal parseBooleanLiteral()
    {
        auto value = Literal();
        value.type = LiteralType.Boolean;
        value.val = (peek().type == TokenType.True);
        return value;
    }

    // TODO: Implement parse all other expression types
}
