module tokens.token;

enum TokenType
{
    Illegal,
    Eof,
    // Identifier, Literals
    Ident,
    Int,
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
