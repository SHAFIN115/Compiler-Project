%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
       
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT T_INCREMENT T_DECREMENT T_COMMENT T_MAX T_POWER T_LOOP T_POWER T_SQRT T_FACT
%token T_NEWLINE T_QUIT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expression
%type<fval> mixed_expression

%start calculation

%%

calculation:{printf("WELCOME USERS! \nput your instructions: ");}
	   | calculation line
;

line: T_NEWLINE
    | mixed_expression T_NEWLINE { printf("\tYOUR RESULT IS: %f\n", $1);}
    | expression T_NEWLINE { printf("\tYOUR RESULT IS: %i\n", $1); }
    | T_QUIT T_NEWLINE { printf("Thank you so much!!\nbye\n"); exit(0); }
    
;

mixed_expression: T_FLOAT                 		 { $$ = $1; }
	  | mixed_expression T_PLUS mixed_expression	 { $$ = $1 + $3; }
          | mixed_expression T_INCREMENT                 { $$ =$1+1;     }
          | mixed_expression T_DECREMENT                 { $$ =$1-1;     }
          | T_COMMENT mixed_expression                   { printf("\nITS A COMMENT");
                                                                    printf("\n");
                                                                    exit(0);     }
	  | mixed_expression T_MINUS mixed_expression	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY mixed_expression { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | T_LEFT mixed_expression T_RIGHT		 { $$ = $2; }
          | mixed_expression T_MAX mixed_expression      { if($1>$3)
                                                                  printf("\n%f is Bigger and %f is Smaller",$1,$3);
                                                           else if($1==$3)
                                                                  printf("\n THEY ALL SAME");
                                                           else
                                                                 printf("\n %f is Bigger and %f is Smaller",$3,$1);
                                                           exit(0);
                                                          }
	  | expression T_PLUS mixed_expression	 	 { $$ = $1 + $3; }
	  | expression T_MINUS mixed_expression	 	 { $$ = $1 - $3; }
          | T_SQRT mixed_expression                            {  float i=sqrt($2);
                                                            printf("%f",i);
                                                            exit(0);
                                                          }
	  | expression T_MULTIPLY mixed_expression 	 { $$ = $1 * $3; }
	  | expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | mixed_expression T_PLUS expression	 	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS expression	 	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY expression 	 { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE expression	 { $$ = $1 / $3; }
	  | expression T_DIVIDE expression		 { $$ = $1 / (float)$3; }
;

expression: T_INT				{ $$ = $1; }
	  | expression T_PLUS expression	{ $$ = $1 + $3; }
          | T_FACT expression                   {   int i,f=1;
                                                    for(i=1;i<=$2;i++){
                                                          f=f*i;
                                                    }
                                                    printf("FACTORIAL IS : %d",f);
                                                    exit(0);
                                                 }             
                                                    
          | T_POWER expression expression       { int i;
                                                  i=pow($2,$3);
                                                  printf("%d",i);
                                                  exit(0);
                                                 }
          | expression T_INCREMENT              { $$ =$1+1;     }
          | expression T_MAX expression      { if($1>$3)
                                                                  printf("\n %i is Bigger and %i is Smaller",$1,$3);
                                                           else if($1==$3)
                                                                  printf("\n THEY ALL SAME");
                                                           else
                                                                 printf("\n %i is Bigger and %i is Smaller",$3,$1);
                                                           exit(0);
                                                          }
          | expression T_DECREMENT              { $$= $1-1;     }
          | T_COMMENT  expression                   { printf("\nITS A COMMENT");
                                                             exit(0);     
                                                     }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
          | T_LOOP expression expression        {

						int i;
                                                 for(i=$2;i<=$3;i++)
                                                    {
                                                        printf("inside loop, value of i = %d\n",i);
                                                    }
                                                 exit(0);
                                                 }       
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
;

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}