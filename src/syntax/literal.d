module syntax.literal;
import std.conv : to;

enum LiteralType
{
    Int,
    String,
    Bool
}

struct Literal
{
    LiteralType type;
    union
    {
        int num;
        string str;
        bool val;
    }
}

Literal* makeIntegerLiteral(string num)
{
    auto literal = new Literal();
    literal.type = LiteralType.Int;
    literal.num = to!int(num); // convert token literal (string) -> int
    return literal;
}

Literal* makeStringLiteral(string str)
{
    auto literal = new Literal();
    literal.type = LiteralType.String;
    literal.str = str;
    return literal;
}

Literal* makeBooleanLiteral(string val)
{
    auto literal = new Literal();
    literal.type = LiteralType.Bool;
    literal.val = to!bool(val); // convert token literal (string) --> boolean
    return literal;
}
