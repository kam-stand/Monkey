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
    Minus,
    Bang,
    Asterisk,
    Slash,
    NotEqual, // !=
    EqualEqual, // ==

    GreaterThan, // >
    LessThan, // <

    // Delimitters
    Comma,
    Semicolon,

    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,

    // keywords
    Function,
    Let,
    If,
    Else,
    Return,
    True,
    False

}

struct Token
{
    TokenType type;
    string literal;
}

static const TokenType[string] keywords = [
    "fn": TokenType.Function,
    "let": TokenType.Let,
    "true": TokenType.True,
    "false": TokenType.False,
    "if": TokenType.If,
    "else": TokenType.Else,
    "return": TokenType.Return,
    "true": TokenType.True,
    "false": TokenType.False

];

Token* initToken(TokenType type, string literal)
{
    return new Token(type, literal);
}

TokenType lookUpIdent(string ident)
{
    return ident in keywords ? keywords[ident] : TokenType.Ident;
}
