import token;
import lexer;

void main(string[] args)
{

    import std.file;

    auto file_path = "test.monkey";
    write(file_path, "12 100");
    auto source = cast(byte[]) read(file_path);

    Lexer lex = new Lexer(source);

    auto tokens = lex.lexTokens();

    import std.stdio;

    writeln(tokens.length);

}
