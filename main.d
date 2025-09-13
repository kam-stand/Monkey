import token;
import lexer;
import std.stdio;
import std.string;

void main(string[] args)
{
    writeln("Welcome to the monkey programming language");
    const prompt = ">> ";
    while (1)
    {
        write(prompt);
        string line = strip(readln());

        Lexer lexer = new Lexer(cast(byte[]) line);
        auto tokens = lexer.lexTokens();

    }
}
