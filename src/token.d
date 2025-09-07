module token;

// enum TokenType
// {
//     Illegal,
//     Eof,

//     // literals
//     Ident,
//     Int,
//     // operators
//     Assign,
//     Plus,
//     Minus,
//     Slash,
//     Bang,
//     Asterisk,

//     LessThan,
//     GreaterThan,
//     EqualEqual,
//     NotEqual,
//     // delimmmetters
//     Comma,
//     Semicolon,
//     // blocks
//     LeftParen,
//     RightParen,
//     LeftBrace,
//     RightBrace,
//     // keyowrds
//     Function,
//     Let,
//     True,
//     False,
//     If,
//     Else,
//     Return
// }

enum TokenType
{
    Illegal = "Illegal",
    Eof = "Eof",
    // literals
    Ident = "Ident",
    Int = "Int",
    // operators
    Assign = "Assign",
    Plus = "Plus",
    Minus = "Minus",
    Slash = "Slash",
    Bang = "Bang",
    Asterisk = "Asterisk",
    LessThan = "LessThan",
    GreaterThan = "GreaterThan",
    EqualEqual = "EqualEqual",
    NotEqual = "NotEqual",
    // delimmetter
    Comma = "Comma",
    Semicolon = "Semicolon",
    // blocks
    LeftParen = "LeftParen",
    RightParen = "RightParen",
    LeftBrace = "LeftBrace",
    RightBrace = "RightBrace",
    // keywords
    Function = "Function",
    Let = "Let",
    True = "True",
    False = "False",
    If = "If",
    Else = "Else",
    Return = "Return"
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

TokenType[string] keywords = [
    "fn": TokenType.Function,
    "let": TokenType.Let,
    "true": TokenType.True,
    "false": TokenType.False,
    "if": TokenType.If,
    "else": TokenType.Else,
    "return": TokenType.Return

];

TokenType lookUpIdent(string ident)
{
    if (ident in keywords)
    {
        return keywords[ident];
    }

    return TokenType.Ident;
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
