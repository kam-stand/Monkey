module value;

enum ValueType
{
    Int,
    String,
    Boolean
}

struct Value
{
    ValueType type;
    union
    {
        string str;
        int number;
        bool val;
    }
}

Value* makeValue(ValueType type, int val)
{
    auto v = new Value();
    v.type = ValueType.Int;
    v.number = val;
    return v;
}

Value* makeValue(ValueType type, string val)
{
    auto v = new Value();
    v.type = ValueType.String;
    v.str = val;
    return v;
}

Value* makeValue(ValueType type, bool val)
{
    auto v = new Value();
    v.type = ValueType.Boolean;
    v.val = val;
    return v;
}
