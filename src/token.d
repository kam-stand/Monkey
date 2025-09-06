module token;

enum TokenType
{
    Illegal,
    Eof,

    Ident,
    Int,

    Assign,
    Plus,

    Comma,
    Semicolon,

    LeftParent,
    RightParent,
    LeftBrace,
    RightBrace,

    Function,
    Let
}

struct Token
{
    TokenType type;
    string literal;
}

Token newToken(TokenType type, string literal)
{
    Token t = Token();
    t.type = type;
    t.literal = literal;
    return t;
}

unittest
{
    Token t = Token(TokenType.Eof, null);

    assert(t.type == TokenType.Eof);

    Token b = Token(TokenType.Assign, "=");

    // assert reading strings are of correct length
    assert(b.type == TokenType.Assign);
    assert(b.literal == "=");
    assert(b.literal.length == 1);

}
