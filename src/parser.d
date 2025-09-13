module parser;
import ast;
import token;
import std.stdio;
import std.conv;
import value;

class Parser
{
    Token*[] tokens;
    int current = 0;

    this(Token*[] tokens)
    {
        this.tokens = tokens;
    }

    bool check(TokenType type)
    {
        if (isAtEnd())
            return false;
        return peek().type == type;
    }

    bool match(TokenType[] types)
    {
        foreach (t; types)
        {
            if (check(t))
            {
                advance();
                return true;
            }
        }
        return false;
    }

    bool isAtEnd()
    {
        return peek().type == TokenType.Eof;
    }

    Token* previous()
    {
        return tokens[current - 1];
    }

    Token* peek()
    {
        return tokens[current];
    }

    Token* advance()
    {
        if (!isAtEnd())
            current++;
        return previous();
    }

    Program parseProgram()
    {
        Statement*[] statements;

        while (!isAtEnd())
        {
            statements ~= parseStatement();
            writefln("[TYPE: %s LITERAL: %s", peek().type, peek().literal);
        }

        return Program(statements);
    }

    Statement* parseStatement()
    {
        return new Statement();
    }

    Expression* parseExpression()
    {
        return new Expression();
    }

    Expression* parseEquality()
    {
        Expression* expr = parseComparison();
        while (match([TokenType.NotEqual, TokenType.EqualEqual]))
        {
            Token* operator = previous();
            Expression* right = parseComparison();

            expr = newBinary(expr, operator, right);
        }

        return expr;
    }

    Expression* parseComparison()
    {
        Expression* expr = parseTerm();
        while (match([TokenType.GreaterThan, TokenType.LessThan]))
        {
            Token* op = previous();
            Expression* right = parseTerm();
            expr = newBinary(expr, op, right);
        }
        return expr;

    }

    Expression* parseTerm()
    {
        Expression* expr = parseFactor();
        while (match([TokenType.Minus, TokenType.Plus]))
        {
            Token* op = previous();
            Expression* right = parseFactor(); // ✅ not parseTerm
            expr = newBinary(expr, op, right);
        }
        return expr;
    }

    Expression* parseFactor()
    {
        Expression* expr = parseUnary();
        while (match([TokenType.Slash, TokenType.Asterisk]))
        {
            Token* op = previous();
            Expression* right = parseUnary(); // ✅ not parseFactor
            expr = newBinary(expr, op, right);
        }
        return expr;
    }

    Expression* parseUnary()
    {
        if (match([TokenType.Bang, TokenType.Minus]))
        {
            Token* op = previous();
            Expression* right = parseUnary();
            return newUnary(op, right);
        }

        return parsePrimary();
    }

    Expression* parsePrimary()
    {
        if (match([TokenType.Int]))
        {
            int val = to!int(previous().literal);
            return newLiteral(makeValue(ValueType.Int, val));
        }

        if (match([TokenType.String]))
        {
            return newLiteral(makeValue(ValueType.String, previous().literal));
        }

        if (match([TokenType.True]))
        {
            return newLiteral(makeValue(ValueType.Boolean, true));
        }

        if (match([TokenType.False]))
        {
            return newLiteral(makeValue(ValueType.Boolean, false));
        }

        if (match([TokenType.Ident]))
        {
            return newIdentifier(previous()); // similar helper for identifiers
        }

        if (match([TokenType.LeftParen]))
        {
            Expression* expr = parseExpression();
            if (!match([TokenType.RightParen]))
                throw new Exception("Expected ')'");
            return expr;
        }

        throw new Exception("Expected expression");
    }

}

// expression     → equality ;
// equality       → comparison ( ( "!=" | "==" ) comparison )* ;
// comparison     → term ( ( ">" | "<"  ) term )* ;
// term           → factor ( ( "-" | "+" ) factor )* ;
// factor         → unary ( ( "/" | "*" ) unary )* ;
// unary          → ( "!" | "-" ) unary
//                | primary ;
// primary        → NUMBER | STRING | "true" | "false" | "nil"
//                | "(" expression ")" ;
