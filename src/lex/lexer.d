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

    Token*[] lexSource()
    {
        Token*[] tokens;

        while (index < source_file.length)
        {
            switch (source_file[index])
            {
            case '+':
                tokens ~= initToken(TokenType.Plus, "+");
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
                if (isDigit(source_file[index]))
                {
                    tokens ~= lexNumber();
                }
                else if (isAlpha(source_file[index]))
                {
                    tokens ~= lexLetter();
                }
                else if (source_file[index] == '"')
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
        while (index < source_file.length && isDigit(source_file[index]))
        {
            index++;
        }

        return initToken(TokenType.Int, cast(string) source_file[start .. index]);
    }

    Token* lexLetter()
    {

        int start = index;
        while (index < source_file.length && isAlpha(source_file[index]))
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

        while (index < source_file.length && source_file[index] != '"')
        {
            index++;
        }

        return initToken(TokenType.String, cast(string) source_file[start .. index]);

        index++; // skip closing quote
    }
}
