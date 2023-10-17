%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define MAX_LINE_LENG 255
	#define MAX_FUNCTION_NAME 30
	typedef struct Symbol_Table{
		char symbol[MAX_FUNCTION_NAME];
		struct Symbol_Table* next;
	}Table_Node;
	typedef Table_Node* TablePtr;
	extern TablePtr symbol_table;
	extern TablePtr temp_table;
	extern int token_index;
	extern char line_text[MAX_LINE_LENG];
	extern char finish_line[MAX_LINE_LENG];
	extern int lineNum;
	extern void print_line();
	extern void lookup();
	extern void insert(char* s);
	extern void dump();
	//char errorMessage[MAX_LINE_LENG] = "a";
	int error;
	void add_errorMessage(char* s);
	extern int charCount;
	extern int idCount;
	extern int lineCount;
	extern int lineChar;
	extern int yyleng;
	extern char *yytext;
	void yyerror(const char *str); //syntax error:自動呼叫yyerror()
	char my_msg[256]= "here";
	//my_msg="";
%}
%union{
char *str;	//%union和lex共享記憶體(token的type, yylval)
};
%type <str> prog prog_name dec_list dec type standtype arraytype id_list stmt_list stmt assign ifstmt exp relop simpexp term factor read write for index_exp varid body   
%token <str> PROGRAM VAR BEGINN END ARRAY OF DOTDOT DOT INTEGER REALTYPE STRINGTYPE
%token <str> id sstring
%token <str> DO IF THEN FOR TO
%token <str> assignop semicolon comma colon upcomma
%token <str> READ WRITE WRITELN
%token <str> reall
%token <str> bt lt be le neq eq lbracket rbracket lq rq
%token <str> multiply DIV plus minus MOD
%token <str> int_digit

%%
prog : PROGRAM prog_name semicolon VAR dec_list semicolon BEGINN stmt_list semicolon END DOT 
	/*{
	char* p =strstr(line_text+7, ";");
	*p='\0';
	printf("Line %d, syntax error! at 1st char : %d, at \';\'. Need \'.\' not \';\'\n", lineNum, token_index);
	}*/
	|  PROGRAM prog_name semicolon VAR dec_list semicolon BEGINN stmt_list semicolon END semicolon {yyerror("Need '.' after END not ';' ");}
	|  PROGRAM prog_name semicolon VAR dec_list semicolon BEGINN stmt_list END DOT {yyerror(" ';' not found");}//yyerrok;}
	|  PROGRAM prog_name semicolon VAR dec_list BEGINN stmt_list semicolon END DOT {yyerror(" ';' not found");}//yyerrok;}
	|  PROGRAM prog_name semicolon VAR dec_list semicolon BEGINN stmt_list semicolon END {yyerror("lack . after end");}//yyerrok;}
	;
//var : VAR;
//begin : BEGINN;
prog_name : id ;
dec_list : dec 
		 | dec_list semicolon dec 
		 ;
dec : id_list colon type 
	| id_list eq type {yyerror("Need ':' not '=' ");}//yyerrok;}
	| id_list error type {yyerror("Need ':' not this ");}//yyerrok;}
	;
/*error_dec : assign {
	char* p =strstr(line_text, ":=");
	*p='\0';
	printf("Line %d, syntax error! at 1st char : %d, at \":=\". Need \':\' not \':=\'\n", lineNum, token_index-yyleng+1);
	error=1;
} 
invaild_assign : ':' {
	char* p =strstr(line_text,":");
	*p='\0';
	printf("Line %d, syntax error! at 1st char: %d, . Need \":=\" not \':=\'\n", lineNum, token_index-yyleng+1);
	error=1;
} */
type : standtype | arraytype ;
standtype : INTEGER | REALTYPE | STRINGTYPE;
arraytype : ARRAY lbracket int_digit DOTDOT int_digit rbracket OF standtype ;
id_list : id 
		  | id_list comma id 
		  //| error {yyerrok;}
		  ;
stmt_list : stmt 
		  | stmt_list semicolon stmt
//		  | stmt_list empty_error stmt
		  ;
stmt : assign | read | write | for | ifstmt;
assign : varid assignop simpexp 
		| varid error simpexp {yyerror("Need ':=' not ':' or '=' ");}//yyerrok;}
		;
ifstmt : IF lq exp rq THEN body //{printf("%s\n", finish_line);}
		| IF lq exp rq  body {yyerror("lose then");}//{printf("lose then");} 
		//| error {yyerrok;}
	    ;
exp : simpexp 
	 | exp relop simpexp 
	 ;
relop : bt | lt | be | le | neq | eq ;
simpexp : term 
		 | simpexp plus term
		 | simpexp minus term
		 | simpexp MOD term
		 //| sign_digit minus term
		 | simpexp error term {yyerror("simpexp plus/minus term");}//yyerrok;}
		 ;
term : factor 
	  | term multiply factor 
	  | term DIV factor 
	  //| sign_digit multiply factor	//to detect the +7(sign number)
	  //| sign_digit DIV factor
	  ;
factor : varid | int_digit | reall //|sign_digit
		| lq simpexp rq 
		;
read : READ lq id_list rq ;
write : WRITE lq id_list rq
	   | WRITE lq sstring rq
	   //| WRITE lq all_string rq
	   //| error {yyerrok;}
	   ;

for : FOR index_exp DO body 
	| FOR index_exp body {yyerror("Need 'DO' after 'FOR'");}//yyerrok;}
	;
index_exp : varid assignop simpexp TO exp 
		  | varid assignop simpexp TO exp int_digit {yyerror("Don't Need int_digit after exp");}//yyerrok;}
		  ;
varid : id 
	   | id lbracket simpexp rbracket 
	   ;
body : stmt 
	  | BEGINN stmt_list semicolon END 
	  ;
/*print_line : ';' {
	if(error != 1)
		printf("%s\n",line_text);
	error=0;
}

empty_error: {
printf("%s\n", finish_line);
printf("Line %d, 1st char: %d, syntax error at \"%s\". Expect \';\' before \'%s\'\n", lineNum, token_index,yytext,yytext);
}*/

%%
int main()
{
	printf("Line 1: ");	//start to print
    yyparse();	//start parser
	printf("\n");
    return 0;
}
void yyerror(const char *str)
{ 
	fprintf(stderr,"Line %d,1st char: %d, %s '%s'\n",lineCount, lineChar-yyleng,my_msg,str);	//first to print the error line and charactor
}


