module main;
import lexer;
import ast;
import parser;
import token;
import std.stdio;

enum PROMPT = ">> ";

int main(string[] args)
{

    while (true)
    {
        write(PROMPT);
        string line = readln();
        if (line.length < 1)
            return 1;
        Lexer lex = new Lexer(cast(byte[]) line);
        Parser p = new Parser(lex.tokens);
        auto ast = p.parse();
        p.display(ast);
        writeln();
    }

    return 0;
}
