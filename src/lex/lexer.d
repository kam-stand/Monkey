module lex.lexer;
import tokens.token;
import std.stdio;
import std.conv : to;
import std.ascii : isAlpha, isDigit;

class Lexer
{
    ubyte[] source_file;
    int index = 0;
    int start = 0;

    this(ubyte[] source_file)
    {
        this.source_file = source_file;
    }

    Token*[] lexSource()
    {
        Token*[] tokens;

        while (index < source_file.length)
        {
            start = index;
            char ch = cast(char) source_file[index];
            writefln("LITERAL: %c, START: %d END: %d", ch, start, index);
            switch (ch)
            {
            case '+':
                tokens ~= initToken(TokenType.Plus, "+");
                index++;
                break;
            case '=':
                tokens ~= initToken(TokenType.Plus, "=");
                index++;
                break;
            case '{':
                tokens ~= initToken(TokenType.Plus, "+");
                index++;
                break;
            case '}':
                tokens ~= initToken(TokenType.Plus, "+");
                index++;
                break;
            case '(':
                tokens ~= initToken(TokenType.Plus, "+");
                index++;
                break;
            case ')':
                tokens ~= initToken(TokenType.Plus, "+");
                index++;
                break;
            case ' ':
                index++;
                break;
            case '\t':
                index++;
                break;
            case '\n':
                index++;
                break;
            default:

                if (isDigit(ch))
                {
                    int numberStart = index;
                    while (index < source_file.length && isDigit(cast(char) source_file[index]))
                    {
                        index++;
                    }
                    tokens ~= initToken(TokenType.Int, cast(string) source_file[numberStart .. index]);
                }
                else
                {
                    index++; // skip unknown/illegal character
                    tokens ~= initToken(TokenType.Illegal, cast(string) source_file[start .. index]);
                }

            }

        }

        // EOF token
        tokens ~= initToken(TokenType.Eof, "");

        return tokens;
    }

}
