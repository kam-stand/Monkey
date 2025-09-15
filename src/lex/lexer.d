module lex.lexer;
import tokens.token;
import std.stdio;
import std.conv : to;
import std.ascii : isAlpha, isDigit;

class Lexer
{
    ubyte[] source_file;
    int index = 0;

    this(ubyte[] source_file)
    {
        this.source_file = source_file;
    }

    bool isAtEnd()
    {
        return index >= source_file.length;
    }

    char peek()
    {
        return source_file[index];
    }

    Token*[] lexSource()
    {
        Token*[] tokens;

        while (!isAtEnd())
        {

            switch (peek())
            {
            case '+':
                tokens ~= initToken(TokenType.Plus, "+");
                break;
            case '-':
                tokens ~= initToken(TokenType.Minus, "-");
                break;
            case '!':
                tokens ~= initToken(TokenType.Bang, "!");
                break;
            case '*':
                tokens ~= initToken(TokenType.Asterisk, "*");
                break;
            case '>':
                tokens ~= initToken(TokenType.GreaterThan, ">");
                break;
            case '<':
                tokens ~= initToken(TokenType.LessThan, "<");
                break;
            case '=':
                tokens ~= initToken(TokenType.Assign, "=");
                break;
            case ';':
                tokens ~= initToken(TokenType.Semicolon, ";");
                break;
            case ',':
                tokens ~= initToken(TokenType.Comma, ",");
                break;
            case '{':
                tokens ~= initToken(TokenType.LeftBrace, "{");
                break;
            case '}':
                tokens ~= initToken(TokenType.RightBrace, "}");
                break;
            case '(':
                tokens ~= initToken(TokenType.LeftParen, "(");
                break;
            case ')':
                tokens ~= initToken(TokenType.RightParen, ")");
                break;
            default:
                if (isDigit(peek()))
                {
                    tokens ~= lexNumber();
                }
                else if (isAlpha(peek()))
                {
                    tokens ~= lexLetter();
                }
                else if (peek() == '"')
                {
                    tokens ~= lexString();
                }
                break;
            }
            index++;
        }

        // EOF token
        tokens ~= initToken(TokenType.Eof, "");

        return tokens;
    }

    Token* lexNumber()
    {
        int start = index;
        while (!isAtEnd() && isDigit(peek()))
        {
            index++;
        }

        auto literal = cast(string) source_file[start .. index];
        return initToken(TokenType.Int, literal);
    }

    Token* lexLetter()
    {

        int start = index;
        while (!isAtEnd() && isAlpha(peek()))
        {
            index++;
        }
        auto literal = cast(string) source_file[start .. index];
        auto type = lookUpIdent(literal);
        return initToken(type, literal);
    }

    Token* lexString()
    {
        int start = index + 1; // skip the opening quote
        index++;

        while (!isAtEnd() && peek() != '"')
        {
            index++;
        }

        auto literal = cast(string) source_file[start .. index];
        return initToken(TokenType.String, literal);

        index++; // skip closing quote
    }
}
