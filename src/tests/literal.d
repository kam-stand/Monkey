module tests.literal;
import syntax.literal;

unittest
{
    auto literal = makeIntegerLiteral("12");
    assert(literal !is null);
    assert(literal.type == LiteralType.Int);
    assert(literal.num == 12);

}

unittest
{
    auto literal = makeBooleanLiteral("true");
    assert(literal !is null);
    assert(literal.type == LiteralType.Bool);
    assert(literal.val == true);

}

unittest
{
    auto literal = makeStringLiteral("Hello world");
    assert(literal !is null);
    assert(literal.type == LiteralType.String);
    assert(literal.str == "Hello world");
    assert(literal.str.length == "Hello world".length);

}
