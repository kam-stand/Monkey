module lexer;
import token;
import std.ascii;
import std.stdio;

class Lexer
{
    byte[] source;
    int current; // current position in the source file
    int start;

    this(byte[] source)
    {
        this.source = source;
        this.current = 0;
        this.start = 0;
    }

    Token[] lexTokens()
    {

        Token[] tokens = [];
        return tokens;
    }

    Token lexDigit()
    {
        return Token(TokenType.Int, literal);

    }

}

unittest  // test lexer class creation
{

    auto source = cast(byte[])['{', '+', '='];
    Lexer lex = new Lexer(source);

    // assert source length is the same and it exists
    assert(lex.source.length == source.length);
}

unittest  // test lexer ability to parse
{
    import std.file;

    auto file_path = "test.monkey";
    write(file_path, "{}()+=");
    auto source = cast(byte[]) read(file_path);

    Lexer lex = new Lexer(source);

    auto tokens = lex.lexTokens();
    assert(tokens[0].type == TokenType.LeftBrace);

    assert(tokens[1].type == TokenType.RightBrace);

    assert(tokens[6].type == TokenType.Eof);

    assert(tokens[4].type == TokenType.Plus);

    assert(tokens.length == 7);
    scope (exit)
    {
        assert(exists(file_path));
        remove(file_path);
    }
}

// unittest  // test lex numbers
// {
//     import std.file;

//     auto file_path = "test.monkey";
//     write(file_path, "12 100 45");
//     auto source = cast(byte[]) read(file_path);

//     Lexer lex = new Lexer(source);

//     auto tokens = lex.lexTokens();

//     assert(tokens.length == 4);

//     assert(tokens[0].type == TokenType.Int);
//     assert(tokens[0].literal == "12");

//     assert(tokens[1].type == TokenType.Int);
//     assert(tokens[1].literal == "100");

//     assert(tokens[2].type == TokenType.Int);
//     assert(tokens[2].literal == "45");

//     assert(tokens[3].type == TokenType.Eof);

//     scope (exit)
//     {
//         assert(exists(file_path));
//         remove(file_path);
//     }
// }

// unittest  // test lexer statements: ident and keywords
// {
//     import std.file;

//     auto file_path = "test.monkey";
//     write(file_path, "let x  = 12;");
//     auto source = cast(byte[]) read(file_path);

//     Lexer lex = new Lexer(source);

//     auto tokens = lex.lexTokens();

//     assert(tokens.length == 6);

//     assert(tokens[0].type == TokenType.Let);

//     assert(tokens[1].type == TokenType.Ident);

//     assert(tokens[2].type == TokenType.Assign);

//     assert(tokens[3].type == TokenType.Int);

//     assert(tokens[4].type == TokenType.Semicolon);

//     scope (exit)
//     {
//         assert(exists(file_path));
//         remove(file_path);
//     }
// }
