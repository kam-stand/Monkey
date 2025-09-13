import token;
import lexer;
import parser;

import std.stdio;
import std.string;

void main(string[] args)
{
    const prompt = ">> ";
    while (1)
    {
        write(prompt);
        string line = strip(readln());

        Lexer lexer = new Lexer(cast(byte[]) line);
        auto tokens = lexer.lexTokens();
        Parser parser = new Parser(tokens);
        parser.parseProgram();

    }
}
