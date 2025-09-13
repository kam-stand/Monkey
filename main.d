import token;
import lexer;
import std.stdio;
import std.string;
import parser;
import ast;

void main(string[] args)
{
    const prompt = ">> ";
    while (1)
    {
        write(prompt);
        string line = strip(readln());
        if (line is null)
        {
            break;
        }
        import std.file;

        auto source = cast(byte[]) line;
        Lexer lex = new Lexer(source);
        auto tokens = lex.lexTokens();
        writeln(tokens.length);
        foreach (t; tokens)
        {
            writefln("[TYPE: %s, LITERAL: %s]", t.type, t.literal);
        }

    }
}
