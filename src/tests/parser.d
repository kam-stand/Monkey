module tests.parser;
import parse.parser;
import lex.lexer;
import syntax.statements;
import syntax.expressions;

unittest
{
    string content = "let x = 12;";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);
    auto tokens = lexer.lexSource();
    auto program = new Parser(tokens).parseProgram();

    assert(program.statements.length == 1);

}

unittest
{
    string content = "let x = 12;";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);
    auto tokens = lexer.lexSource();
    auto program = new Parser(tokens).parseProgram();

    auto stmt = program.statements[0];
    assert(stmt.type == StatementType.LetStatement);
    assert(stmt.let_.expr.type == ExpressionType.Literal);

}

unittest
{
    string content = "return 12;";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);
    auto tokens = lexer.lexSource();
    auto program = new Parser(tokens).parseProgram();

    auto stmt = program.statements[0];
    assert(stmt.type == StatementType.ReturnStatement);

}

unittest
{
    string content = "10 + 12;";
    auto source_file = cast(ubyte[]) content;
    Lexer lexer = new Lexer(source_file);
    auto tokens = lexer.lexSource();
    auto program = new Parser(tokens).parseProgram();

    auto stmt = program.statements[0];
    assert(stmt.type == StatementType.ExpressionStatement);

}
