module syntax.literal;

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

Literal* makeIntegerLiteral(int num)
{
    auto literal = new Literal();
    literal.type = LiteralType.Int;
    literal.num = num;
    return literal;
}

Literal* makeStringLiteral(string str)
{
    auto literal = new Literal();
    literal.type = LiteralType.String;
    literal.str = str;
    return literal;
}

Literal* makeBooleanLiteral(bool val)
{
    auto literal = new Literal();
    literal.type = LiteralType.Bool;
    literal.val = val;
    return literal;
}
