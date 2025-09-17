module lex.lexer;
import tokens.token;
import std.stdio;
import std.conv : to;
import std.ascii : isAlpha, isDigit;

class Lexer
{
    private ubyte[] source_file;
    private int index = 0;

    this(ubyte[] source_file)
    {
        this.source_file = source_file;
    }

    private bool isAtEnd()
    {
        return index >= source_file.length;
    }

    private bool isWhiteSpace(char c)
    {
        if (c == ' ' || c == '\t' || c == '\n')
            return true;

        return false;
    }

    private char advance()
    {
        if (!isAtEnd())
        {
            return source_file[index++];
        }
        return '\0';
    }

    private char peek()
    {
        return source_file[index];
    }

    private char peekNext()
    {
        return source_file[index + 1];
    }
    // TODO: Improve moving token.
    Token*[] lexSource()
    {
        Token*[] tokens;

        while (!isAtEnd())
        {
            char c = peek();

            if (isWhiteSpace(c)) // skip white spaces
            {
                index++;
                continue;
            }
            switch (c)
            {
            case '+':
                tokens ~= initToken(TokenType.Plus, "+");
                index++;
                break;
            case '-':
                tokens ~= initToken(TokenType.Minus, "-");
                index++;
                break;
            case '!':
                if (!isAtEnd() && peekNext() == '=')
                {
                    tokens ~= initToken(TokenType.NotEqual, "!=");
                    index += 2; // consume both '!' and '='
                }
                else
                {
                    tokens ~= initToken(TokenType.Bang, "!");
                    index++;
                }
                break;
            case '*':
                tokens ~= initToken(TokenType.Asterisk, "*");
                index++;
                break;
            case '/':
                tokens ~= initToken(TokenType.Slash, "/");
                index++;
                break;
            case '>':
                tokens ~= initToken(TokenType.GreaterThan, ">");
                index++;
                break;
            case '<':
                tokens ~= initToken(TokenType.LessThan, "<");
                index++;
                break;
            case '=':
                if (!isAtEnd() && peekNext() == '=')
                {
                    tokens ~= initToken(TokenType.EqualEqual, "==");
                    index += 2;
                }
                else
                {
                    tokens ~= initToken(TokenType.Assign, "=");
                    index++;
                }
                break;
            case ';':
                tokens ~= initToken(TokenType.Semicolon, ";");
                index++;
                break;
            case ',':
                tokens ~= initToken(TokenType.Comma, ",");
                index++;
                break;
            case '{':
                tokens ~= initToken(TokenType.LeftBrace, "{");
                index++;
                break;
            case '}':
                tokens ~= initToken(TokenType.RightBrace, "}");
                index++;
                break;
            case '(':
                tokens ~= initToken(TokenType.LeftParen, "(");
                index++;
                break;
            case ')':
                tokens ~= initToken(TokenType.RightParen, ")");
                index++;
                break;
            default:
                if (isDigit(c))
                {
                    tokens ~= lexNumber(); // lexNumber advances index
                }
                else if (isAlpha(c))
                {
                    tokens ~= lexLetter(); // lexLetter advances index
                }
                else if (c == '"')
                {
                    tokens ~= lexString(); // lexString advances index
                }
                else
                {
                    // skip unknown characters
                    tokens ~= initToken(TokenType.Illegal, c.to!string);
                    index++;
                }
                break;
            }
        }

        // EOF token
        tokens ~= initToken(TokenType.Eof, "");
        return tokens;
    }

    private Token* lexNumber()
    {
        int start = index;
        while (!isAtEnd() && isDigit(peek()))
        {
            index++;
        }

        auto literal = cast(string) source_file[start .. index];
        return initToken(TokenType.Int, literal);
    }

    private Token* lexLetter()
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

    private Token* lexString()
    {
        int start = index + 1; // skip opening quote
        index++;

        while (!isAtEnd() && peek() != '"')
        {
            index++;
        }

        auto literal = cast(string) source_file[start .. index];
        index++; // skip closing quote

        return initToken(TokenType.String, literal);
    }

}
