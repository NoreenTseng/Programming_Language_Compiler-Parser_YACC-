/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROGRAM = 258,
    VAR = 259,
    BEGINN = 260,
    END = 261,
    ARRAY = 262,
    OF = 263,
    DOTDOT = 264,
    DOT = 265,
    INTEGER = 266,
    REALTYPE = 267,
    STRINGTYPE = 268,
    id = 269,
    sstring = 270,
    DO = 271,
    IF = 272,
    THEN = 273,
    FOR = 274,
    TO = 275,
    assignop = 276,
    semicolon = 277,
    comma = 278,
    colon = 279,
    upcomma = 280,
    READ = 281,
    WRITE = 282,
    WRITELN = 283,
    reall = 284,
    bt = 285,
    lt = 286,
    be = 287,
    le = 288,
    neq = 289,
    eq = 290,
    lbracket = 291,
    rbracket = 292,
    lq = 293,
    rq = 294,
    multiply = 295,
    DIV = 296,
    plus = 297,
    minus = 298,
    MOD = 299,
    int_digit = 300
  };
#endif
/* Tokens.  */
#define PROGRAM 258
#define VAR 259
#define BEGINN 260
#define END 261
#define ARRAY 262
#define OF 263
#define DOTDOT 264
#define DOT 265
#define INTEGER 266
#define REALTYPE 267
#define STRINGTYPE 268
#define id 269
#define sstring 270
#define DO 271
#define IF 272
#define THEN 273
#define FOR 274
#define TO 275
#define assignop 276
#define semicolon 277
#define comma 278
#define colon 279
#define upcomma 280
#define READ 281
#define WRITE 282
#define WRITELN 283
#define reall 284
#define bt 285
#define lt 286
#define be 287
#define le 288
#define neq 289
#define eq 290
#define lbracket 291
#define rbracket 292
#define lq 293
#define rq 294
#define multiply 295
#define DIV 296
#define plus 297
#define minus 298
#define MOD 299
#define int_digit 300

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 35 "B051010001.y" /* yacc.c:1909  */

char *str;	//%union和lex共享記憶體(token的type, yylval)

#line 148 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
