module tests.lexer;
import tokens.token;
import lex.lexer;

unittest
{
    string content = "{}()+/*-;,";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    assert(lexer.source_file !is null); // MUST INSTANTIATE WITH SOURCE_FILE
    assert(lexer.index == 0);
}

unittest
{
    string content = "{}()+/*-   ;,";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    auto tokens = lexer.lexSource();
    assert(tokens !is null);
    assert(tokens.length == 11); // MUST HAVE EOF
}

unittest
{
    string content = "{(!=;,";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    auto tokens = lexer.lexSource();
    assert(tokens !is null);
    assert(tokens.length == 6);
    assert(tokens[2].type == TokenType.NotEqual);
    assert(tokens[2].literal == "!=");

    assert(tokens[4].type == TokenType.Comma);
    assert(tokens[4].literal == ",");

}

unittest
{
    string content = "return \"hello\";";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    auto tokens = lexer.lexSource();
    assert(tokens !is null);
    assert(tokens.length == 4);
    assert(tokens[1].type == TokenType.String);
    assert(tokens[1].literal == "hello");
    assert(tokens[1].literal.length == "hello".length); // String length literal are of same size
    assert(tokens[0].type == TokenType.Return);
    assert(tokens[0].literal == "return");

}

unittest
{
    string content = "let x = 12;";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    auto tokens = lexer.lexSource();
    assert(tokens.length == 6);
    assert(tokens[0].type == TokenType.Let); // MUST BE IDENT
    assert(tokens[3].type == TokenType.Int); // MUST BE Int

}

unittest
{
    string content = "let add = fn(x,y) {x + y; };";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    auto tokens = lexer.lexSource();

    assert(tokens.length == 17);

    assert(tokens[0].type == TokenType.Let);
    assert(tokens[1].type == TokenType.Ident);
    assert(tokens[2].type == TokenType.Assign);
    assert(tokens[3].type == TokenType.Function);
    assert(tokens[4].type == TokenType.LeftParen);
    assert(tokens[5].type == TokenType.Ident);
}

unittest
{
    string content = "@?$";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);

    auto tokens = lexer.lexSource();
    assert(tokens.length == 4);
    assert(tokens[0].type == TokenType.Illegal); // MUST BE Illegal
    assert(tokens[1].type == TokenType.Illegal); // MUST BE Illegal
    assert(tokens[2].type == TokenType.Illegal); // MUST BE Illegal

}
