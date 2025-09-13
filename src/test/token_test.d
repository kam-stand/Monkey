module test.token_test;

import token;

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
