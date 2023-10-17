all:	y.tab.c lex.yy.c 
	gcc lex.yy.c y.tab.c -ly -lfl

y.tab.c:
	bison -y -d yacc.y

lex.yy.c:	
	flex lex.l

clean:
	rm a.out lex.yy.c y.tab.c y.tab.h
