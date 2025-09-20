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
            return parseReturnStatement();
        default:
            return parseExpressionStatement();
        }
        throw new Exception("Parse error: cannot parse statement.");
    }

    private Statement* parseLetStatement()
    {
        // We are at "let"
        auto letTok = peek();
        advance(); // consume 'let'

        // Exprect 'Ident'
        if (!match(TokenType.Ident))
        {
            throw new Exception("Parse error: expected identifier after 'let'.");
        }
        auto identTok = previous();

        // Expect '='
        if (!match(TokenType.Assign))
        {
            throw new Exception("Parse error: expected '=' after identifier in let statement.");
        }

        // Parse the RHS 
        auto expr = parseExpression();

        // Expect semicolon
        if (!match(TokenType.Semicolon))
        {

            throw new Exception("Parse error : expected';' after expression.");
        }
        // Construct the AST node
        auto letStmt = makeLetStatement(letTok, expr, identTok);

        return letStmt;
    }

    private Statement* parseReturnStatement()
    {
        auto ret_ = peek(); // we are at 'return'
        advance(); // consume 'return'

        auto expr = parseExpression(); // parse Expression

        // Exprect ';'
        if (!match(TokenType.Semicolon))
        {
            throw new Exception("Parse errorL expected ';' after expression in return statement.");
        }
        return makeReturnStatement(ret_, expr);
    }

    private Statement* parseExpressionStatement()
    {
        auto expr = parseExpression();
        if (!match(TokenType.Semicolon))
        {

            throw new Exception("Parse error expected ';' after expression in return statement.");
        }

        return makeExpressionStatement(expr);
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

        // TODO: parse booleans
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
        if (match(TokenType.Null))
        {
            auto lit = makeNullLiteral(previous().literal);
            return makeLiteralExpression(lit);
        }
        if (match(TokenType.LeftParen))
        {
            auto expr = parseExpression();
            if (!match(TokenType.RightParen))
            {
                throw new Exception("Parse error: expected ')' after expression.");
            }
            return expr;
        }

        if (match(TokenType.True) || match(TokenType.False))
        {
            auto lit = makeBooleanLiteral(previous().literal);
            return makeLiteralExpression(lit);
        }

        if (match(TokenType.Ident))
        {
            auto ident = makeIdentifier(previous());
            return makeIdentExpression(ident);
        }

        throw new Exception("Parse error: cannot parse primary");
    }

}
