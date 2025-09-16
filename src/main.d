module main;
import lex.lexer;
import std.stdio;
import std.string;
import tokens.token;
import parse.parser;
import syntax.ast;

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
        writefln("TOKENS: %d", tokens.length);
        auto parser = new Parser(tokens).parseProgram();
        writeln(parser.statements.length);
    }

}
