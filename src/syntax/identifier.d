module syntax.identifier;
import tokens.token;
import syntax.identifier;

struct Identifier
{
    Token* ident;
}

Identifier* makeIdentifier(Token* ident)
{
    return new Identifier(ident);
}
