module syntax.identifier;
import tokens.token;
import syntax.identifier;
import syntax.literal;

struct Identifier
{
    Token* ident;
}

Identifier* makeIdentifier(Token* ident)
{
    return new Identifier(ident);
}
