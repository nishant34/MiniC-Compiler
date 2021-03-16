%{
int num_tokens = 0;
%}

/* Rules section*/
%%
"!"|"+"|"*"|"-"|"="|"|"|"<"|">"|"/" {num_tokens++; fprintf(yyout,"<OP,%s>\n", yytext);}
"+="|"*="|"-="|"/="|"<="|">=" {num_tokens++; fprintf(yyout,"<OP,%s>\n", yytext);}
"++"|"--"|"!="|"==" {num_tokens++; fprintf(yyout,"<OP,%s>\n", yytext);}
[(){},;] {num_tokens++; fprintf(yyout,"<SP,%s>\n", yytext);}
"char"|"else"|"if"|"while"|"return"|"void"|"int" {num_tokens++; fprintf(yyout,"<KY,%s>\n", yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {num_tokens++; fprintf(yyout,"<ID,%s>\n", yytext);}
\'(\\.|[^"\\])\'  {num_tokens++; fprintf(yyout,"<CT,%s>\n", yytext);}
\"(\\.|[^"\\])*\" {num_tokens++; fprintf(yyout,"<CT,%s>\n", yytext);}
[0-9]+|\-[0-9]+ {num_tokens++; fprintf(yyout,"<CT,%s>\n", yytext);}


%%
int yywrap(){}
int main(){
    extern FILE *yyin, *yyout;

    yyin = fopen("input.txt","r");
    yyout = fopen("output.txt", "w");
    yylex();
    fprintf(yyout,"Total number of tokens in the above program is %d\n", num_tokens);

    
}