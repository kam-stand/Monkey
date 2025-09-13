module value;

enum LiteralType
{
    Identifier,
    Integer,
    Boolean,
    String,
    Function,
    Hash
}

struct Literal
{
    LiteralType type;
    union
    {
        string ident;
        int integer;
        bool val;
        string str;
    }
}
