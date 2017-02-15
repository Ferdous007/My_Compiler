/* C Declarations */

%{
	#include<stdio.h>
	#include <math.h>
	int sym[26];
	#define P 3.1416
%}

/* BISON Declarations */

%token NUM VAR IC OW main_function INT FLOAT CHAR PLUS MINUS MUL DIV SIN TAN COS LOG LT GT LP RP LB RB CM SM
%nonassoc IFX
%nonassoc ELSE
%left LT GT
%left PLUS MINUS
%left MUL DIV

/* Simple grammar rules */

%%

program: 
       main_function LB RB LP cstatement RP
	 ;	 

cstatement: /* empty */

	| cstatement statement
	
	| cdeclaration
	;
	
cdeclaration:	TYPE ID1 SM	{ printf("\nvalid declaration\n"); }
			;
			
TYPE : INT

     | FLOAT

     | CHAR
     ;

ID1  : ID1 CM VAR

     |VAR
     ;

statement: SM


	| expression SM 			{ printf("value of expression: %d\n", $1); }

        | VAR '=' expression SM 		{ 
							sym[$1] = $3; 
							printf("Value of the variable: %d\t\n",$3);
						}

	| IC LB expression RB expression SM %prec IFX {
								if($3)
								{
									printf("\nvalue of expression in IF: %d\n",$5);
								}
								else
								{
									printf("condition value zero in IF block\n");
								}
							}

	| IC LB expression RB expression SM OW expression SM {
								 	if($3)
									{
										printf("value of expression in IF: %d\n",$5);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$8);
									}
								   }
	;

expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = sym[$1]; }

	| expression PLUS expression	{ $$ = $1 + $3; }

	| expression MINUS expression	{ $$ = $1 - $3; }

	| expression MUL expression	{ $$ = $1 * $3; }

	| expression DIV expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    	}

	| expression LT expression	{ $$ = $1 < $3; }

	| expression GT expression	{ $$ = $1 > $3; }

	| LB expression RB		{ $$ = $2;	}

	| SIN LB expression RB 	{ $$ = sin($3 * P / 180); }

	| COS LB expression RB 	{ $$ = cos($3 * P / 180); }

	| TAN LB expression RB 	{ $$ = tan($3 * P / 180); }

	| LOG LB expression RB 	{ $$ = log($3); }
	;
%%

int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}

