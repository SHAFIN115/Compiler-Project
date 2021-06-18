%{
#include <stdio.h>

#include "1.tab.h"

%}


%%

[ \t]	; // ignore all whitespace
[0-9]+[.][0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"++"            {return T_INCREMENT;}
"--"            {return T_DECREMENT;}
"//"            {return T_COMMENT;}
"sqrt"          {return T_SQRT;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"loop"          {return T_LOOP;}
"pow"           {return T_POWER;}
","             {return T_MAX;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"fact"          {return T_FACT;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
int yywrap()
{

   return 1;
}