module tests.token;
import tokens.token;

unittest
{
    auto t = initToken(TokenType.Int, "12");

    static assert(is(typeof(t) == Token*)); // compile-time type check

    assert(t.type == TokenType.Int); // runtime semantic check
    assert(t.literal == "12");
}

unittest
{
    auto t = initToken(TokenType.Ident, "X");

    assert((t.type == TokenType.Ident));
    assert(t.literal.length > 0);

}

unittest
{
    auto t = initToken(TokenType.Eof, "");

    assert((t.type == TokenType.Eof));
    assert(t.literal.length == 0);

}
