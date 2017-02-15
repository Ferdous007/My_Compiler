/* C Declarations */

%{
	#include<stdio.h>
	#include "main.tab.h"
	#include<stdlib.h>
	extern int yylval;
%}

/*RE and Action*/

%%
"int"	{ return INT; }
"float"	{ return FLOAT; }
"char"	{ return CHAR; }

[0-9]+	{ 
		yylval = atoi(yytext);
		return NUM;
	}

[a-z]	{
		yylval = *yytext - 'a';
		return	VAR;
	}

"either"		{ return IC;		}
"or"		{ return OW;		}

[=] {
		yylval = yytext[0];
		return *yytext;
		}

[+][+]		{
 return PLUS ;
		}
[-][-]		{
 return MINUS ;
		}
[*][*]		{
 return MUL ;
		}				
[/][/]		{
 return DIV ;
		}
"LT" { return LT ; }
"GT" { return GT ; }
"LP" { return LP ; }
"RP" { return RP ; }
"LB" { return LB ; }
"RB" { return RB ; }
"CMM" { return CM ; }
"SMM" { return SM ; }		
"sin" { return SIN ; }
"cos" { return COS ; }	
"tan" { return TAN ; }	
"log" { return LOG ; }			

"void main"	{ return main_function; }

[ \t\n]*	;

.	{
		yyerror("Unknown Character.\n");
	}
%%

/* user subroutines */

int main()
{
	yyin = freopen("a.txt","r",stdin);
	yyout = freopen("pi.txt","w",stdout);
	yyparse();

}

