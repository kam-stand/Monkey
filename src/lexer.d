module lexer;
import token;
import std.ascii;
import std.stdio;

class Lexer
{
    byte[] source;
    int current; // current position in the source file
    Token[] tokens;

    this(byte[] source)
    {
        this.source = source;
        this.current = 0;
    }

    Token[] lexTokens()
    {
        tokens = [];

        while (!isAtEnd())
        {
            char ch = advance();

            switch (ch)
            {
            case '+':
                tokens ~= newToken(TokenType.Plus, "+");
                break;
            case '=':
                if (match('='))
                    tokens ~= newToken(TokenType.EqualEqual, "==");
                else
                    tokens ~= newToken(TokenType.Assign, "=");
                break;
                tokens ~= newToken(TokenType.Assign, "=");
                break;
            case '-':
                tokens ~= newToken(TokenType.Minus, "-");
                break;
            case '/':
                tokens ~= newToken(TokenType.Slash, "/");
                break;
            case '*':
                tokens ~= newToken(TokenType.Asterisk, "*");
                break;
            case '!':
                if (match('='))
                    tokens ~= newToken(TokenType.NotEqual, "!=");
                else
                    tokens ~= newToken(TokenType.Bang, "!");
                break;
            case '>':
                tokens ~= newToken(TokenType.GreaterThan, ">");
                break;
            case '<':
                tokens ~= newToken(TokenType.LessThan, "<");
                break;
            case '{':
                tokens ~= newToken(TokenType.LeftBrace, "{");
                break;
            case '}':
                tokens ~= newToken(TokenType.RightBrace, "}");
                break;
            case '(':
                tokens ~= newToken(TokenType.LeftParen, "(");
                break;
            case ')':
                tokens ~= newToken(TokenType.RightParen, ")");
                break;
            case ';':
                tokens ~= newToken(TokenType.Semicolon, ";");
                break;
            case ',':
                tokens ~= newToken(TokenType.Comma, ",");
                break;
            case ' ', '\t', '\n': // skip white spaces
                break;
            default:
                if (isDigit(ch))
                {
                    tokens ~= lexNumber();
                    break;
                }
                else if (isAlpha(ch)) // TODO: Make sure to add '"' support and white spaces
                {
                    tokens ~= lexString();
                    break;
                }
                break;
            }

        }
        tokens ~= newToken(TokenType.Eof, null); // append eof 
        return tokens;
    }

    char advance()
    {
        return source[current++];
    }

    char peek()
    {
        if (isAtEnd())
            return '\0'; // sentinel
        return cast(char) source[current];
    }

    bool match(char expected)
    {
        if (isAtEnd())
            return false;
        if (source[current] != expected)
            return false;

        current++; // consume it
        return true;
    }

    bool isAtEnd()
    {
        return current >= source.length;
    }

    Token lexNumber()
    {
        int start = current - 1;
        while (!isAtEnd() && isDigit(peek()))
        {
            advance();
        }
        // Slice out the number string
        string value = cast(string) source[start .. current];
        return newToken(TokenType.Int, value);

    }

    Token lexString()
    {
        int start = current - 1;
        while (!isAtEnd() && isAlpha(peek()))
        {
            advance();
        }

        string literal = cast(string) source[start .. current];

        TokenType type = lookUpIdent(literal);

        return newToken(type, literal);
    }

}
