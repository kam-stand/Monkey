module parser;
import token;
import ast;
import std.stdio;
import lexer;
import std.conv;

class Parser
{
    Token[] tokens;
    int current;

    this(Token[] tokens)
    {
        this.tokens = tokens;
        this.current = 0;
    }

    Token advance()
    {
        return isAtEnd() ? Token(TokenType.Illegal, null) : tokens[current++];
    }

    Token peek()
    {
        return tokens[current];
    }

    Token peekNext()
    {
        return (current + 1 < tokens.length) ? tokens[current + 1] : Token(TokenType.Eof, null);
    }

    bool isAtEnd()
    {
        return peek().type == TokenType.Eof;
    }

    bool check(TokenType type)
    {
        return isAtEnd() ? false : peek().type == type;
    }

    Token consume(TokenType expected)
    {
        if (check(expected))
        {
            return advance();
        }

        return Token(TokenType.Illegal, null);
    }

    Program parseProgram()
    {
        Program program;
        program.statements = [];

        while (!isAtEnd())
        {
            auto stmt = parseStatements();
            program.statements ~= stmt;
        }

        return program;
    }

    Statements parseStatements()
    {
        Statements stmt;

        switch (peek().type)
        {
        case TokenType.Let:
            stmt.type = StatementType.LetStatement;
            stmt.let_ = parseLetStatement();
            break;

        case TokenType.Return:
            stmt.type = StatementType.ReturnStatement;
            stmt.return_ = parseReturnStatement();
            break;

        default:
            stmt.type = StatementType.ExpressionStatement;
            stmt.expression_ = parseExpressionStatement();
            break;
        }

        return stmt;
    }

    LetStatement parseLetStatement()
    {
        consume(TokenType.Let); // consume "let"
        auto ident = consume(TokenType.Ident); // variable name
        consume(TokenType.Assign); // consume "="

        auto expression = parseExpression(); // TODO: implement
        consume(TokenType.Semicolon);

        return LetStatement(ident, expression);
    }

    ReturnStatement parseReturnStatement()
    {
        consume(TokenType.Return); // consume "return"

        auto expression = parseExpression(); // TODO: implement
        consume(TokenType.Semicolon);

        return ReturnStatement(expression);
    }

    ExpressionStatement parseExpressionStatement()
    {
        auto expr = parseExpression();

        if (check(TokenType.Semicolon))
            consume(TokenType.Semicolon);

        return ExpressionStatement(expr);
    }

    Expression parseExpression()
    {
        Expression expr = Expression();

        switch (peek().type)
        {
        case TokenType.Ident:
            break;
        case TokenType.Int:
            break;
        case TokenType.True:
        case TokenType.False:
            break;
        case TokenType.Function:
            break;
        default:
            break;
        }

        return expr;

    }

}
