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
                    int start = index;
                    while (isDigit(source_file[index]))
                    {
                        index++;
                    }

                    tokens ~= initToken(TokenType.Int, cast(string) source_file[start .. index]);
                }
                else if (isAlpha(source_file[index]))
                {
                    int start = index;
                    while (isAlpha(source_file[index]))
                    {
                        index++;
                    }
                    tokens ~= initToken(TokenType.Ident, cast(string) source_file[start .. index]);
                }
                break;
            }
            index++;
        }

        // EOF token
        tokens ~= initToken(TokenType.Eof, "");

        return tokens;
    }

}
