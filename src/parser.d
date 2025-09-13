module parser;
import ast;
import token;
import std.conv;
import literal;

class Parser
{

    Token*[] tokens;
    int current;
    this(Token*[] tokens)
    {
        this.tokens = tokens;
        this.current = 0;
    }

    Token* peek()
    {
        return tokens[current];
    }

    Token* advance()
    {
        return !isAtEnd() ? tokens[current++] : previous();
    }

    Token* previous()
    {
        return tokens[current - 1];
    }

    Token* consume(TokenType type)
    {
        if (check(type))
        {
            return advance();
        }
        return new Token(TokenType.Illegal, null);
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
        Statements*[] stmts;
        while (!isAtEnd())
        {
            stmts ~= parseStatement();
        }
        return Program(stmts);
    }

    Statements* parseStatement()
    {
        auto statement = new Statements();
        return statement;

    }

}
