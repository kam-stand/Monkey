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

        while (current < source.length)
        {
            char ch = cast(char) source[current];

            switch (ch)
            {
            case '+':
                tokens ~= newToken(TokenType.Plus, "+");
                break;
            case '=':
                tokens ~= newToken(TokenType.Assign, "=");
                break;
            case '{':
                tokens ~= newToken(TokenType.LeftBrace, "{");
                break;
            case '}':
                tokens ~= newToken(TokenType.RightBrace, "}");
                break;
            case '[':
                tokens ~= newToken(TokenType.LeftParen, "[");
                break;
            case ']':
                tokens ~= newToken(TokenType.RightParen, "]");
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
                }
                break;
            }

            current++; // advance
        }
        tokens ~= newToken(TokenType.Eof, null); // append eof 
        return tokens;
    }

    char peek()
    {
        if (isAtEnd())
            return '\0'; // sentinel
        return cast(char) source[current];
    }

    bool isAtEnd()
    {
        return current >= source.length;
    }

    Token lexNumber()
    {
        int start = current;
        while (!isAtEnd() && isDigit(peek()))
        {
            current++;
        }
        // Slice out the number string
        string value = cast(string) source[start .. current];
        return newToken(TokenType.Int, value);

    }

    Token lexString()
    {
        return Token(TokenType.Ident, null);
    }

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{}+=";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);

    assert(lex.source.length == 4); // prior to lexing the content length must be same as original
    assert(lex.tokens.length == 0);
    assert(lex.current == 0);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{+=";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 4); // after lexing the number of tokens must be 4 for each token type not char

    assert(tokens[0].type == TokenType.LeftBrace);
    assert(tokens[1].type == TokenType.Plus);
    assert(tokens[2].type == TokenType.Assign);
    assert(tokens[3].type == TokenType.Eof);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{+= 12";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 5);

    assert(tokens[0].type == TokenType.LeftBrace);
    assert(tokens[1].type == TokenType.Plus);
    assert(tokens[2].type == TokenType.Assign);
    assert(tokens[3].type == TokenType.Int);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{;, \"Let\" 12";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 5);

    assert(tokens[0].type == TokenType.LeftBrace);
    assert(tokens[1].type == TokenType.Semicolon);
    assert(tokens[2].type == TokenType.Comma);
    assert(tokens[3].type == TokenType.Ident);

}
