module parse.parser;
import tokens.token;
import syntax.statements;
import syntax.program;

class Parser
{
    Token*[] tokens;
    int index = 0;

    this(Token*[] tokens)
    {
        this.tokens = tokens;
    }

    Token* peek()
    {
        return tokens[index];
    }

    bool isAtEnd()
    {
        return peek().type == TokenType.Eof;
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

    Statement* parseStatement()
    {
        switch (peek().type)
        {
        case TokenType.Let:
            break;
        case TokenType.Return:
            break;
        default:
            break;
        }

        return new Statement();
    }

}
