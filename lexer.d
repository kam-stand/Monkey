module lexer;
import token;
import std.ascii;

class Lexer
{

public:
    byte[] input;
    Token*[] tokens;
    this(byte[] input)
    {
        this.input = input;
        tokenize();
    }

private:
    size_t position = 0;

    // MAIN FUNCTION
    void tokenize()
    {

        while (position < input.length)
        {
            switch (input[position])
            {
            case '+':
                tokens ~= new Token(TokenType.Plus, "+");
                break;
            case '-':
                tokens ~= new Token(TokenType.Minus, "-");
                break;
            case '*':
                tokens ~= new Token(TokenType.Asterisk, "*");
                break;
            case '/':
                tokens ~= new Token(TokenType.Slash, "/");
                break;
            case '(':
                tokens ~= new Token(TokenType.LeftParen, "(");
                break;
            case ')':
                tokens ~= new Token(TokenType.RightParen, ")");
                break;
            default:
                if (isDigit(input[position]))
                {
                    string lexeme = cast(string) input[position .. position + 1];
                    tokens ~= new Token(TokenType.Int, lexeme);
                }
                break;

            }
            position++;
        }

        tokens ~= new Token(TokenType.Eof, "\0");
    }
}

unittest
{
    byte[] input = ['1', '+', '2'];
    Lexer lex = new Lexer(input);
    assert(
        lex.tokens.length > 0);
}

unittest
{
    byte[] input = ['1', '+', '2'];
    Lexer lex = new Lexer(input);
    auto tokens = lex.tokens;

    import std.stdio;

    foreach (t; tokens)
    {
        writefln("type: %s, lex: %s", t.type, t.lexeme);
    }

    assert(tokens[0].type == TokenType.Int);
    assert(tokens[1].type == TokenType.Plus);
    assert(tokens[2].type == TokenType.Int);
}
