module parse.parser;
import tokens.token;
import syntax.statements;
import syntax.program;
import syntax.expressions;
import syntax.identifier;
import std.stdio;
import syntax.literal;

class Parser
{
    private Token*[] tokens;
    private int index = 0;

    this(Token*[] tokens)
    {
        this.tokens = tokens;
    }

    private Token* peek()
    {
        return tokens[index];
    }

    private bool isAtEnd()
    {
        return peek().type == TokenType.Eof;
    }

    private bool match(TokenType type)
    {
        if (peek().type == type)
        {
            advance();
            return true;
        }
        return false;
    }

    private Token* previous()
    {
        return tokens[index - 1];
    }

    private Token* advance()
    {
        if (!isAtEnd())
            index++;
        return previous();
    }

    Program parseProgram()
    {
        Statement*[] statements = [];

        while (!isAtEnd())
        {

            statements ~= parseStatement();
        }

        return Program(statements);
    }

    private Statement* parseStatement()
    {
        switch (peek().type)
        {
        case TokenType.Let:

            return parseLetStatement();
        case TokenType.Return:
            break;
            // TODO: parse Return and Expression statements
        default:
            break;
        }
        // TODO: better error handling
        return null;
    }

    private Statement* parseLetStatement()
    {
        // We are at "let"
        auto letTok = peek();
        advance(); // consume 'let'

        // Next should be an identifier
        auto identTok = peek();
        advance();

        // Expect '='
        if (!match(TokenType.Assign))
        {
            writeln("Parse error: expected '=' after identifier in let statement.");
            return null;
        }

        // Parse the RHS expression
        auto expr = parseExpression();

        // Optional semicolon
        match(TokenType.Semicolon);

        // Construct the AST node
        auto letStmt = makeLetStatement(letTok, expr, identTok);

        return letStmt;
    }

    private Expression* parseExpression()
    {
        return parseEquality();
    }

    private Expression* parseEquality()
    {
        auto expr = parseComparision();

        while (match(TokenType.NotEqual) || match(TokenType.EqualEqual))
        {
            Token* operator = previous();
            auto rhs = parseComparision();
            auto lhs = expr;
            expr = makeBinaryExpression(lhs, operator, rhs);
        }

        return expr;
    }

    private Expression* parseComparision()
    {
        auto expr = parseTerm();

        while (match(TokenType.GreaterThan) || match(TokenType.LessThan))
        {
            Token* operator = previous();
            auto rhs = parseTerm();
            auto lhs = expr;
            expr = makeBinaryExpression(lhs, operator, rhs);
        }

        return expr;
    }

    private Expression* parseTerm()
    {
        auto expr = parseFactor();
        while (match(TokenType.Minus) || match(TokenType.Plus))
        {
            Token* operator = previous();
            auto rhs = parseFactor();
            auto lhs = expr;
            expr = makeBinaryExpression(lhs, operator, rhs);
        }
        return expr;
    }

    private Expression* parseFactor()
    {
        auto expr = parseUnary();
        while (match(TokenType.Asterisk) || match(TokenType.Slash))
        {
            Token* operator = previous();
            auto rhs = parseUnary();
            auto lhs = expr;
            expr = makeBinaryExpression(lhs, operator, rhs);
        }

        return expr;
    }

    private Expression* parseUnary()
    {
        // match on '!' or '-'
        if (match(TokenType.Minus) || match(TokenType.Bang))
        {
            Token* operator = previous();
            auto rhs = parseUnary();
            return makeUnaryExpression(operator, rhs);
        }
        return parsePrimary();
    }

    private Expression* parsePrimary()
    {
        if (match(TokenType.Int))
        {
            auto lit = makeIntegerLiteral(previous().literal);
            return makeLiteralExpression(lit);
        }

        if (match(TokenType.String))
        {
            auto lit = makeStringLiteral(previous().literal);
            return makeLiteralExpression(lit);
        }
        // TODO: parse Parenthesis
        // TODO: use switch statement

        return null;
    }

}
