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
                advance();
                continue;
            }
            switch (c)
            {
            case '+':
                advance();
                tokens ~= initToken(TokenType.Plus, "+");
                break;
            case '-':
                advance();
                tokens ~= initToken(TokenType.Minus, "-");
                break;
            case '!':
                advance();
                if (peek() == '=')
                {
                    advance();
                    tokens ~= initToken(TokenType.NotEqual, "!=");
                }
                else
                {
                    tokens ~= initToken(TokenType.Bang, "!");
                }
                break;
            case '*':
                advance();
                tokens ~= initToken(TokenType.Asterisk, "*");
                break;
            case '/':
                advance();
                tokens ~= initToken(TokenType.Slash, "/");
                break;
            case '>':
                advance();
                tokens ~= initToken(TokenType.GreaterThan, ">");
                break;
            case '<':
                advance();
                tokens ~= initToken(TokenType.LessThan, "<");
                break;
            case '=':
                advance();
                if (peek() == '=')
                {
                    advance();
                    tokens ~= initToken(TokenType.EqualEqual, "==");
                }
                else
                {
                    tokens ~= initToken(TokenType.Assign, "=");
                }
                break;
            case ';':
                advance();
                tokens ~= initToken(TokenType.Semicolon, ";");
                break;
            case ',':
                advance();
                tokens ~= initToken(TokenType.Comma, ",");
                break;
            case '{':
                advance();
                tokens ~= initToken(TokenType.LeftBrace, "{");
                break;
            case '}':
                advance();
                tokens ~= initToken(TokenType.RightBrace, "}");
                break;
            case '(':
                advance();
                tokens ~= initToken(TokenType.LeftParen, "(");
                break;
            case ')':
                advance();
                tokens ~= initToken(TokenType.RightParen, ")");
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
                    tokens ~= initToken(TokenType.Illegal, advance.to!string);
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
        while (isAlpha(peek()))
        {
            advance();
        }
        auto literal = cast(string) source_file[start .. index];
        auto type = lookUpIdent(literal);
        return initToken(type, literal);
    }

    private Token* lexString()
    {
        advance(); // consume '"' opening quote
        int start = index;

        while (!isAtEnd() && peek() != '"')
        {
            advance();
        }

        auto literal = cast(string) source_file[start .. index];
        advance(); // comsume '"' closing quote

        return initToken(TokenType.String, literal);
    }

}
