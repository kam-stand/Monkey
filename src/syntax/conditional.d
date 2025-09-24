module syntax.conditional;
import syntax.block_statement;
import syntax.expressions;
import tokens.token;

/** 
 *   IF (EXPR) { TRUE: BLOCK_STMT}  FALSE: blo
 */

struct Conditional
{
    Token* if_;
    Expression* condition;
    BlockStatement* true_stmts;
    BlockStatement* alt_stmts;
}
