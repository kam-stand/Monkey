module lex.lexer;
import tokens.token;
import std.stdio;

class Lexer
{
    ubyte[] source_file;

    this(ubyte[] source_file)
    {
        this.source_file = source_file;
    }

    void lexSource()
    {
        foreach (ubyte key; source_file)
        {
            writeln(key);
        }
    }

}
