module main;
import lex.lexer;
import std.stdio;
import std.string;
import tokens.token;

enum PROMPT = ">> ";
enum WELCOME = "Welcome to monkey!";

void main(string[] args)
{
    writeln(WELCOME);
    while (1)
    {
        write(PROMPT);
        auto source_file = cast(ubyte[]) strip(readln());
        if (source_file is null)
            break;
        auto lexer = new Lexer(source_file);
        auto tokens = lexer.lexSource();

        foreach (key; tokens)
        {
            writeln(key.literal, key.type);
        }

    }

}
