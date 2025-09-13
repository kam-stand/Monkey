module test.lexer_test;
import lexer;
import token;

unittest
{
    auto source_file = "test.monnkey";
    string content = "{}+=";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);

    assert(lex.source.length == 4); // prior to lexing the content length must be same as original
    assert(lex.tokens.length == 0);
    assert(lex.current == 0);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{+=";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 4); // after lexing the number of tokens must be 4 for each token type not char

    assert(tokens[0].type == TokenType.LeftBrace);
    assert(tokens[1].type == TokenType.Plus);
    assert(tokens[2].type == TokenType.Assign);
    assert(tokens[3].type == TokenType.Eof);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{+= 12";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 5);

    assert(tokens[0].type == TokenType.LeftBrace);
    assert(tokens[1].type == TokenType.Plus);
    assert(tokens[2].type == TokenType.Assign);
    assert(tokens[3].type == TokenType.Int);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "{;, let 12";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 6);

    assert(tokens[0].type == TokenType.LeftBrace);
    assert(tokens[1].type == TokenType.Semicolon);
    assert(tokens[2].type == TokenType.Comma);

    assert(tokens[3].type == TokenType.Let);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "let x = 12";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 5);

    assert(tokens[0].type == TokenType.Let);
    assert(tokens[1].type == TokenType.Ident);
    assert(tokens[2].type == TokenType.Assign);

    assert(tokens[3].type == TokenType.Int);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "><*/!-";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 7); // after lexing the number of tokens must be 4 for each token type not char

    assert(tokens[0].type == TokenType.GreaterThan);
    assert(tokens[1].type == TokenType.LessThan);
    assert(tokens[2].type == TokenType.Asterisk);
    assert(tokens[3].type == TokenType.Slash);
    assert(tokens[4].type == TokenType.Bang);
    assert(tokens[5].type == TokenType.Minus);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "== != =";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 4); // after lexing the number of tokens must be 4 for each token type not char

    assert(tokens[0].type == TokenType.EqualEqual);
    assert(tokens[1].type == TokenType.NotEqual);
    assert(tokens[2].type == TokenType.Assign);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "()";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens.length == 3); // after lexing the number of tokens must be 4 for each token type not char

    assert(tokens[0].type == TokenType.LeftParen);
    assert(tokens[1].type == TokenType.RightParen);
    assert(tokens[2].type == TokenType.Eof);

}

unittest
{
    auto source_file = "test.monnkey";
    string content = "fn(x,y)";
    import std.file;

    write(source_file, content);
    scope (exit)
    {
        assert(exists(source_file));
        remove(source_file);
    }

    auto input = cast(byte[]) read(source_file);
    Lexer lex = new Lexer(input);
    auto tokens = lex.lexTokens();

    assert(tokens[0].type == TokenType.Function);
    assert(tokens[1].type == TokenType.LeftParen);
    assert(tokens[2].type == TokenType.Ident);

}
