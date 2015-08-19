
/*
 * Custom Lexer implementation to deal with overlapping sets of terminals
 */
lexer grammar CrsxCustomLexer;


@header {
package net.sf.crsx.xtext.lexer;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;

import java.util.Stack;
}


@members {
    
    enum State {
        DEFAULT,
        EMBEDDED_TEXT,
        EMBEDDED_TEXT_BEFORE_BRACKET,
        EMBEDDED_OTHER
    };
    
    Stack<State> stack = new Stack<State>();
    
    State getCurrentState(){
        if(stack.empty()){
            return State.DEFAULT;
        }else{
            return stack.peek();
        }
    }
    
    public void switchCurrentState(State state){
        if(!stack.empty()){
            stack.pop();
        }
        stack.push(state);
    }
    
    public void processEmbeddingOpen(){
        switch( getCurrentState() ){
            case EMBEDDED_OTHER:
            case EMBEDDED_TEXT:
                stack.push(State.DEFAULT);
                break;
            case EMBEDDED_TEXT_BEFORE_BRACKET:
                switchCurrentState(State.EMBEDDED_TEXT);
                break;
            case DEFAULT:
            default:
                //Copy current state on stack
                stack.push(getCurrentState());
        }
    }
}




RULE_LID : { getCurrentState() == State.DEFAULT }?=> RULE_LINEAR? RULE_LOWER (RULE_ALPHANUMERIC|RULE_OTHER)* RULE_LINEAR? RULE_FUNCTIONAL?;

RULE_UID : { getCurrentState() == State.DEFAULT }?=> (RULE_UPPER RULE_ALPHANUMERIC*|('@'|'^'|'*'|'+'|'`'|'|'|'#'|'/'|'!'|'?'|'='|'~')+);

fragment RULE_LINEAR : { getCurrentState() == State.DEFAULT }?=> '\u00B9';

fragment RULE_FUNCTIONAL : { getCurrentState() == State.DEFAULT }?=> '\u1D47';

RULE_INTERNAL : { getCurrentState() == State.DEFAULT }?=> '$' (RULE_UID|RULE_LID);

RULE_EVALUATOR : { getCurrentState() == State.DEFAULT }?=> '$';

RULE_METAVARIABLE : { getCurrentState() == State.DEFAULT }?=> '#' (RULE_LOWER|RULE_UPPER|RULE_DIGIT|RULE_OTHER)*;

RULE_NUMERIC : { getCurrentState() == State.DEFAULT }?=> RULE_DIGIT+ ('.' RULE_DIGIT+)? (('E'|'e') RULE_DIGIT+)?;

RULE_NOT : { getCurrentState() == State.DEFAULT }?=> '\u00AC';

RULE_ATOM : { getCurrentState() == State.DEFAULT }?=> '\'' ( options {greedy=false;} : . )*'\'';

RULE_STRING : { getCurrentState() == State.DEFAULT }?=> '"' ('\\' ('b'|'t'|'n'|'f'|'r'|'u'|'"'|'\''|'\\')|~(('\\'|'"')))* '"';

RULE_ARROW : { getCurrentState() == State.DEFAULT }?=> '\u2192';

RULE_POLY : { getCurrentState() == State.DEFAULT }?=> '\u2200';

RULE_DOT : { getCurrentState() == State.DEFAULT }?=> '.';
/*
RULE_PERCENT : '%';
*/
RULE_EMBEDDED_TEXT  : { getCurrentState() == State.DEFAULT }?=> '%n' { stack.push(State.EMBEDDED_TEXT_BEFORE_BRACKET); };
RULE_EMBEDDED_OTHER : { getCurrentState() == State.DEFAULT }?=> '%' ~('n');

RULE_LT : { getCurrentState() == State.DEFAULT }?=> '<';

RULE_GT : { getCurrentState() == State.DEFAULT }?=> '>';

RULE_LTEX : { getCurrentState() == State.DEFAULT }?=> '<!';

RULE_LTEXDASH : { getCurrentState() == State.DEFAULT }?=> '<!-';

RULE_EXGT : { getCurrentState() == State.DEFAULT }?=> '!>';

RULE_DASHEXGT : { getCurrentState() == State.DEFAULT }?=> '-!>';

RULE_COLONCOLONEQ : { getCurrentState() == State.DEFAULT }?=> '::=';

RULE_COLONCOLON : { getCurrentState() == State.DEFAULT }?=> '::';

RULE_COLON : { getCurrentState() == State.DEFAULT }?=> ':';

RULE_SEMICOLON : { getCurrentState() == State.DEFAULT }?=> ';';

RULE_COMMA : { getCurrentState() == State.DEFAULT }?=> ',';

RULE_LCURLY : { getCurrentState() == State.DEFAULT }?=> '{';

RULE_RCURLY : { getCurrentState() == State.DEFAULT }?=> '}';

RULE_LSQUARE : { getCurrentState() == State.DEFAULT }?=> '[';

RULE_RSQUARE : { getCurrentState() == State.DEFAULT }?=> ']';

RULE_LPAR : { getCurrentState() == State.DEFAULT }?=> '(';

RULE_RPAR : { getCurrentState() == State.DEFAULT }?=> ')';

//RULE_LESCAPE : '\u201C';

//RULE_RESCAPE : '\u201D';

RULE_LEMBEDDED3 : '\u27E6' {
 if( getCurrentState() == State.EMBEDDED_TEXT ){
    stack.push(State.EMBEDDED_TEXT);
 }else{
    processEmbeddingOpen();
 }
 
};

RULE_LEMBEDDED4 : '\u27E8' { processEmbeddingOpen(); };

RULE_LEMBEDDED5 : '\u27EA' { processEmbeddingOpen(); };

RULE_LEMBEDDED6 : '\u2983' {
 if( getCurrentState() == State.EMBEDDED_TEXT ){
    stack.push(State.EMBEDDED_TEXT);
 }else{
    processEmbeddingOpen();
 }
};

RULE_LEMBEDDED7 : '\u2308' { processEmbeddingOpen(); };

RULE_LEMBEDDED8 : '\u230A' { processEmbeddingOpen(); };

RULE_LEMBEDDED9 : '\u2768' { processEmbeddingOpen(); };

RULE_LEMBEDDED10 : '\u00AB' { processEmbeddingOpen(); };

RULE_LEMBEDDED11 : '\u2039' { processEmbeddingOpen(); };

RULE_LEMBEDDED12 : '\u29FC' { processEmbeddingOpen(); };

RULE_LEMBEDDED13 : '\u2018' { processEmbeddingOpen(); };

RULE_REMBEDDED3 : '\u27E7' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED4 : '\u27E9' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED5 : '\u27EB' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED6 : '\u2984' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED7 : '\u2309' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED8 : '\u230B' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED9 : '\u2769' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED10 : '\u00BB' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED11 : '\u203A' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED12 : '\u29FD' { if (!stack.empty()){ stack.pop();}; } ;

RULE_REMBEDDED13 : '\u2019' { if (!stack.empty()){ stack.pop();}; } ;

RULE_START_XML : '<!--';

RULE_END_XML : '-->';

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_XML_COMMENT : RULE_START_XML ( options {greedy=false;} : . )*RULE_END_XML;

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_TEXT_TOKEN : { getCurrentState() == State.EMBEDDED_TEXT }?=> 
              ~(('\u27E6'|'\u27E8'|'\u27EA'|'\u2983'|'\u2308'|'\u230A'
                |'\u2768'|'\u00AB'|'\u2039'|'\u29FC'|'\u2018'|'\u27E7'
                |'\u27E9'|'\u27EB'|'\u2984'|'\u2309'|'\u230B'|'\u2769'
                |'\u00BB'|'\u203A'|'\u29FD'|'\u2019'|'\u201C'|'\u201D'))+;

RULE_TEXT_ESCAPED_TOKEN: '\u201C' ( options {greedy=false;} : . )* '\u201D';

fragment RULE_ALPHANUMERIC : (RULE_UPPER|RULE_LOWER|RULE_DIGIT);

fragment RULE_DIGIT : '0'..'9';

fragment RULE_UPPER : ('A'..'Z'|'_'|'-');

fragment RULE_LOWER : 'a'..'z';

fragment RULE_OTHER : ('@'|'^'|'*'|'+'|'-'|'`'|'|'|'#'|'/'|'!'|'?'|'%'|'='|'~'|'\u2190'..'\u21FF');



