module lex.lexer;
import tokens.token;
import std.stdio;
import std.conv : to;
import std.ascii : isAlpha, isDigit;

class Lexer
{
    private ubyte[] source_file;
    private int index = 0;
    private Token*[] tokens = [];

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

    private bool match(char expected)
    {
        if (isAtEnd)
            return false;

        if (peek() != expected)
            return false;
        advance();
        return true;
    }

    private char peek()
    {
        return source_file[index];
    }

    void addToken(TokenType type, string literal)
    {
        this.tokens ~= initToken(type, literal);
    }

    Token*[] lexSource()
    {

        while (!isAtEnd())
        {
            char c = peek();
            switch (c)
            {
            case '+':
                advance();
                addToken(TokenType.Plus, "+");
                break;
            case '-':
                advance();
                addToken(TokenType.Minus, "-");
                break;
            case '!':
                advance();
                if (match('='))
                    addToken(TokenType.NotEqual, "!=");
                else
                    addToken(TokenType.Bang, "!");
                break;
            case '*':
                advance();
                addToken(TokenType.Asterisk, "*");
                break;
            case '/':
                advance();
                addToken(TokenType.Slash, "/");
                break;
            case '>':
                advance();
                addToken(TokenType.GreaterThan, ">");
                break;
            case '<':
                advance();
                addToken(TokenType.LessThan, "<");
                break;
            case '=':
                advance();
                if (match('='))
                    addToken(TokenType.EqualEqual, "==");
                else
                    addToken(TokenType.Assign, "=");
                break;
            case ';':
                advance();
                addToken(TokenType.Semicolon, ";");
                break;
            case ',':
                advance();
                addToken(TokenType.Comma, ",");
                break;
            case '{':
                advance();
                addToken(TokenType.LeftBrace, "{");
                break;
            case '}':
                advance();
                addToken(TokenType.RightBrace, "}");
                break;
            case '(':
                advance();
                addToken(TokenType.LeftParen, "(");
                break;
            case ')':
                advance();
                addToken(TokenType.RightParen, ")");
                break;
            case ' ', '\t', '\n': // skip whitespaces 
                advance();
                break;
            default:
                if (isDigit(c))
                {
                    lexNumber();
                }
                else if (isAlpha(c))
                {
                    lexIdent();
                }
                else if (c == '"')
                {
                    lexString();
                }
                else
                {
                    // skip unknown characters
                    addToken(TokenType.Illegal, advance().to!string);
                }
                break;
            }
        }

        // EOF token
        addToken(TokenType.Eof, "");
        return tokens;
    }

    private void lexNumber()
    {
        int start = index;
        while (!isAtEnd() && isDigit(peek()))
        {
            index++;
        }

        auto literal = cast(string) source_file[start .. index];
        addToken(TokenType.Int, literal);
    }

    private void lexIdent()
    {

        int start = index;
        while (isAlpha(peek()))
        {
            advance();
        }
        auto literal = cast(string) source_file[start .. index];
        auto type = lookUpIdent(literal);
        addToken(type, literal);
    }

    private void lexString()
    {
        advance(); // consume '"' opening quote
        int start = index;

        while (!isAtEnd() && peek() != '"')
        {
            advance();
        }

        auto literal = cast(string) source_file[start .. index];
        advance(); // comsume '"' closing quote

        addToken(TokenType.String, literal);
    }

}
