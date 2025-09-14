module tokens.token;

enum TokenType
{
    Illegal,
    Eof,
    // Identifier, Literals
    Ident,
    Int,
    String,
    // operators
    Assign,
    Plus,
    // Delimitters
    Comma,
    Semicolon,

    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,

    // keywords
    Function,
    Let
}

struct Token
{
    TokenType type;
    string literal;
}

Token* initToken(TokenType type, string literal)
{
    return new Token(type, literal);
}
