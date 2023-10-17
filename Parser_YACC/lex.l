%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <ctype.h>
	#include "y.tab.h"
	#define MAX_LINE_LENG 31
	#define MAX_FUNCTION_NAME 30
	typedef struct Symbol_Table{
		char symbol[MAX_FUNCTION_NAME];
		struct Symbol_Table* next;
	}Table_Node;
	typedef Table_Node* TablePtr;
	TablePtr symbol_table = NULL;
	TablePtr temp_table = NULL;
	void lookup();
	void add_temp(char* s);
	void insert(char* s);
	void delete();
	void dump();
	int isEmpty(TablePtr symbol_table);
	char line_text[MAX_LINE_LENG];
	int token_index = 0;
	void print_line();
	int lineNum=0;
	int charCount = 0;
	int idCount = 0;
	int lineCount = 1;
	int lineChar = 1;
	char string_buffer[MAX_FUNCTION_NAME];
	void add_line(void );
	char* errorMessage;
	void add_errorMessage(char* s);
	char finish_line[MAX_LINE_LENG];
	int comment_or_not = 0;
%}
enter \n
integer_digit (0|{non_zero_digit}{digit}*)
invalid_integer_digit [+-]?(0+{non_zero_digit}{digit}*)
float_digit \.(0|{digit}*{non_zero_digit})
sign  [+-]
signed_integer {sign}{digits}
exponent (E|e){integer_digit}
non_zero_digit [1-9]
digit 0|{non_zero_digit}
digits {digit}+
invalid_exponent (E|e){invalid_integer_digit}
identifier [A-Za-z_0-9$]+
invalid_identifier [^A-Za-z_ \t\r\n;,'()]{identifier}
null_character null
commentt \(\*([a-z]|\ |\n|\r)+\*\)
program [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
var [Vv][Aa][Rr]
begin [Bb][Ee][Gg][Ii][Nn]
end [Ee][Nn][Dd]
array [Aa][Rr][Rr][Aa][Yy]
do [Dd][Oo]
if [Ii][Ff]
of [Oo][Ff]
then [Tt][Hh][Ee][Nn]
write [Ww][Rr][Ii][Tt][Ee]
writeln [Ww][Rr][Ii][Tt][Ee][Ll][Nn]
for [Ff][Oo][Rr]
to [Tt][Oo]
read [Rr][Ee][Aa][Dd]
integer [Ii][Nn][Tt][Ee][Gg][Ee][Rr]
realtype [Rr][Ee][Aa][Ll][Tt][Yy][Pp][Ee]
stringtype [Ss][Tt][Rr][Ii][Nn][Gg]
Whitespace [ \t]
eol [\r\n]
LETTER [A-Za-z_]
Operator [+\-]
Sign [+-]
DIGIT [0-9]
DIGITS [0-9]+
INTNUM {Sign}?(0|([1-9][0-9]*))
DotDigit [\.](0|([0-9]*[1-9]))
Exponent [E|e]{Sign}{DIGITS}
REAL {INTNUM}({DotDigit}|{Exponent}|{DotDigit}{Exponent})
COLON \:
SEMICOLON \;
LQ \(
RQ \)
UPCOMMA \'
COLONEQ \:\=
COMMA \,
LBRACKET \[
RBRACKET \]
dotdot \.\.
dot \.
ID {LETTER}({LETTER}|{DIGIT})*
PLUS \+
MINUS \-
MULTIPLY \*
DIVID \/
BT \>
LT \<
BE \>\=
LE \<\=
NEQ \<\>
EQ \=
MOD [Mm][Oo][Dd]
sstring ['][A-Za-z0-9 !"#$%&'()*+,-./:;<=>?@\[\]^_`{|}~]*[']
UNDEFINED   .
invalid_comment {left_p}([\n]*[^\n]*[\n]*)*({right_p})(([^;\r\n \t]+)({right_p}))+
%%
{commentt} {
	int print = 0;
	for(int i = 0; ;i++){
		if((yytext[i] == '*') && (yytext[i+1] == ')')){
			if(print == 1){
				lineCount++;
				comment_or_not++;
			}
			break;
		}
		else if((yytext[i] == '(') && (yytext[i+1] == '*'))
			continue;
		if(yytext[i] == '\n'){
			if(print == 0){
				printf("\n");
				print = 1;
			}
			else{
				comment_or_not++;
				lineCount++;
			}
		}
	}
}
{Whitespace} {lineChar++; printf("%s",yytext);}
{eol} {
	if(yytext[0]!='\r')
		lineCount++;
	lineChar=1;
	//if(comment_or_not != 0)
	//{
		printf("%sLine %d: ",yytext,lineCount);
		//comment_or_not = 0 ;
	//}
		
}

{BT} {add_line(); lineNum=0; printf("%s",yytext); return bt;}
{LT} {add_line(); lineNum=0; printf("%s",yytext); return lt;}
{BE} {add_line(); lineNum=0; printf("%s",yytext); return be;}
{LE} {add_line(); lineNum=0; printf("%s",yytext); return le;}
{NEQ} {add_line(); lineNum=0; printf("%s",yytext); return neq;}
{EQ} {add_line(); lineNum=0; printf("%s",yytext); return eq;}
{program} {printf("%s",yytext); add_line(); lineNum=0; return PROGRAM; }
{var} {printf("%s",yytext); add_line(); lineNum=0; return VAR; }
{begin} {printf("%s",yytext); add_line(); lineNum=0; return BEGINN; }
{end} {printf("%s",yytext); add_line(); lineNum=0; return END; }
{array} {printf("%s",yytext); add_line(); lineNum=0; return ARRAY; }
{for} {printf("%s",yytext); add_line(); lineNum=0; return FOR; }
{to} {printf("%s",yytext); add_line(); lineNum=0; return TO; }
{do} {printf("%s",yytext); add_line(); lineNum=0; return DO; }
{if} {printf("%s",yytext); add_line(); lineNum=0; return IF; }
{of} {printf("%s",yytext); add_line(); lineNum=0; return OF; }
{then} {printf("%s",yytext); add_line(); lineNum=0; return THEN; }
{write} {printf("%s",yytext); add_line(); lineNum=0; return WRITE; }
{writeln} {printf("%s",yytext); add_line(); lineNum=0; return WRITELN; }
{read} {printf("%s",yytext); add_line(); lineNum=0; return READ; }
{integer} {printf("%s",yytext); add_line(); lineNum=0; return INTEGER; }
{realtype} {printf("%s",yytext); add_line(); lineNum=0; return REALTYPE; }
{stringtype} {printf("%s",yytext); add_line(); lineNum=0; return STRINGTYPE;}
{PLUS} {printf("%s",yytext); add_line(); lineNum=0; return plus; }
{MINUS} {printf("%s",yytext); add_line(); lineNum=0; return minus; }
{REAL}/[^0-9] {add_line(); lineNum=0; printf("%s",yytext); return reall;}
{INTNUM}/[^0-9] {add_line(); lineNum=1; printf("%s",yytext);return int_digit;}
{LQ} {printf("%s",yytext); add_line(); lineNum=0; return lq; }
{RQ} {printf("%s",yytext); add_line(); lineNum=0; return rq; }
{SEMICOLON} {printf("%s",yytext); add_line(); lineNum=0; return semicolon; }
{COMMA} {printf("%s",yytext); add_line(); lineNum=0; return comma; }
{COLON} {printf("%s",yytext); add_line(); lineNum=0; return colon; }
{LBRACKET} {printf("%s",yytext); add_line(); lineNum=0; return lbracket; }
{RBRACKET} {printf("%s",yytext); add_line(); lineNum=0; return rbracket; }
{dotdot} {printf("%s",yytext); add_line(); lineNum=0; return DOTDOT; }
{COLONEQ} {printf("%s",yytext); add_line(); lineNum=0; return assignop; }
{MULTIPLY} {printf("%s",yytext); add_line(); lineNum=0; return multiply; }
{DIVID} {printf("%s",yytext); add_line(); lineNum=0; return DIV; }
{MOD} {printf("%s",yytext); add_line(); lineNum=0; return MOD;}
{ID} {
	if(yyleng < MAX_LINE_LENG){
		printf("%s",yytext); 
		add_line(); 
		lineNum=0; 
		return id;
	}
}
{dot} {printf("%s",yytext); add_line(); lineNum=0; return DOT; }
{sstring} {printf("%s",yytext); add_line(); lineNum=0; return sstring; }
{UNDEFINED} {add_line(); lineNum=0;}

%%

void add_line(void){
	int i;
	for(i=0;i<yyleng;i++,charCount++)
			lineChar++;
	idCount++;
}
int isEmpty(TablePtr symbol_table){
	if(symbol_table == NULL)
		return 0;
	return -1;
}
void lookup(){
	if(isEmpty(symbol_table) == 0)
		return;
	TablePtr local = symbol_table;
	TablePtr now = symbol_table;
	TablePtr temp_ptr = temp_table,pre_ptr = temp_table;
	
	while(temp_ptr != NULL){
		if(strcmp(now->symbol, "{") == 0){
			break;
		}
		if(strcmp(now->symbol, temp_ptr->symbol) == 0){
			printf("Line %d : > \'%s\' is a duplicate identifier.\n",lineNum,temp_ptr->symbol);
			temp_ptr = temp_ptr->next;
			if(pre_ptr == temp_table){
				temp_table = temp_ptr;
				pre_ptr = temp_table;
			}
			else{
				pre_ptr->next = temp_ptr;
			}
			now = symbol_table;
			continue;
		}
		now = now->next;
		if(now == NULL){
			now = local;
			pre_ptr = temp_ptr;
			temp_ptr = temp_ptr->next;
			if(temp_ptr == NULL)
				break;
		}
	}
}
void add_temp(char* s){
	TablePtr new_node = (TablePtr)malloc(sizeof(Table_Node));
	strcpy(new_node->symbol,s);
	new_node->next = temp_table;
	temp_table = new_node;
}
void insert(char* s){
	if(strcmp("{",s) == 0){
		lookup();
		insert("1");
		TablePtr new_node = (TablePtr)malloc(sizeof(Table_Node));
		strcpy(new_node->symbol,s);
		new_node->next = symbol_table;
		symbol_table = new_node;
	}
	else{
		TablePtr now = temp_table;
		if(temp_table != NULL){
			while(now->next != NULL)
				now = now->next;
			now->next = symbol_table;
			symbol_table = temp_table;
			temp_table = NULL;
		}
	}
}
void delete(){
	TablePtr now = symbol_table;
	if(symbol_table == NULL)
		return;
	while(strcmp(now->symbol,"{") != 0){
		now = now->next;
		if(symbol_table == NULL)
			return;
	}
	symbol_table = now->next;
}
void dump(){	
	printf("The symbol table contains:\n");
	if(isEmpty(symbol_table) == 0){
		//return;
	}
	else{
		TablePtr now = symbol_table;
		while(now != NULL){
			if(now->next != NULL)
				printf("%s, ",now->symbol);
			else
				printf("%s\n",now->symbol);
			now = now->next;
		}
	}
	
	printf("The temp table contains:\n");
	if(isEmpty(temp_table) == 0){
		//return;
	}
	else{
		TablePtr now = temp_table;
		while(now != NULL){
			if(now->next != NULL)
				printf("%s, ",now->symbol);
			else
				printf("%s\n",now->symbol);
			now = now->next;
		}
	}
	printf("\n");
}
void print_line(){
	printf("hi\n");
	printf("Line %d : %s\n", lineNum, line_text);
	line_text[0] = '\0';
	++lineNum;
}
/*program {add_line(yytext); yylval.sval = strdup(yytext); return (PROGRAM);}
array  {add_line(yytext);yylval.sval = strdup(yytext); return (ARRAY);}
var {add_line(yytext); yylval.sval = strdup(yytext); return (VAR);}
integer {add_line(yytext); yylval.sval = strdup(yytext); return (INTEGER);}
begin {add_line(yytext); yylval.sval = strdup(yytext); return (CBEGIN);}
for {add_line(yytext); yylval.sval = strdup(yytext); return (FOR);}
do {add_line(yytext); yylval.sval = strdup(yytext); return (DO);}
if {add_line(yytext); yylval.sval = strdup(yytext); return (IF);}
then {add_line(yytext); yylval.sval = strdup(yytext); return (THEN);}
of {add_line(yytext); yylval.sval = strdup(yytext); return (OF);}
to {add_line(yytext); yylval.sval = strdup(yytext); return (TO);}
read {add_line(yytext); yylval.sval = strdup(yytext); return (READ);}
write {add_line(yytext); yylval.sval = strdup(yytext); return (WRITE);}
end {add_line(yytext); yylval.sval = strdup(yytext); return (END);}
"[" {add_line(yytext); return '[';}
"]" {add_line(yytext); return ']';}
".." {add_line(yytext); return ARRAY_INDEX;}
";" {add_line(yytext); return ';';}
":" {add_line(yytext); return ':';}
"," {add_line(yytext); return ',';}
"+" {add_line(yytext); return '+';}
"-" {add_line(yytext); return '-';}
"*" {add_line(yytext); return '*';}
"/" {add_line(yytext); return '/';}
"(" {add_line(yytext); return '(';}
")" {add_line(yytext); return ')';}
"." {add_line(yytext); return '.';}
:= {add_line(yytext); return ASSIGN;}
"=" {add_line(yytext); return EQ;}
">" {add_line(yytext); return GT;}
"<" {add_line(yytext); return LT;}
">=" {add_line(yytext); return GE;}
"<=" {add_line(yytext); return LE;}
"<>" {add_line(yytext); return NE;}
{space_chararcter} {add_line(yytext);}
{integer_digit} {add_line(yytext); return integer_digit;}
{identifier} {add_line(yytext); return identifier;}
{real} {add_line(yytext); return real;}
. {printf("%c is error \n", yytext[0]);}
{mod} {printf("%s",yytext); add_line(); lineNum=0; return MOD;}
UPCOMMA {printf("%s",yytext); add_line(); lineNum=0; return upcomma; }
{stringtype} {printf("%s",yytext); add_line(); lineNum=0; return STRINGTYPE;}
*/
