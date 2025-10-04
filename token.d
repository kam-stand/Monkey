module token;

enum TokenType
{
    Illegal,
    Eof,
    // Identifiers + literals
    Ident,
    Int,
    // Operators
    Assign,
    Plus,
    Minus,
    Asterisk,
    Slash,
    // Delimitters
    Comma,
    Semicolon,

    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,

    // Keywords
    Function,
    Let

}

struct Token
{
    TokenType type;
    string lexeme;
}

unittest
{
    Token t = Token(TokenType.Int, "1");
    assert(t.lexeme == "1");

}
