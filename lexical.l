%{
    extern int nb_ligne;
    #include "syntaxique.tab.h"
    extern YYSTYPE yylval;
    #include "compFonction.h"
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre}|_)*
cst {chiffre}+

%%
program {return mc_program;}
begin {return mc_begin;}
for {return mc_for;}
For {return mc_For;}
end {return mc_end;}
In {return mc_in;}
Out {return mc_out;}
const {yylval.str=strdup(yytext); return mc_const;}
float {yylval.str=strdup(yytext); return mc_float;}
integer {yylval.str=strdup(yytext); return mc_integer;}
String {yylval.str=strdup(yytext); return mc_string;}
real {yylval.str=strdup(yytext); return mc_real;}
%s {return mc_s;}
%d {return mc_d;}
%f {return mc_f;}
{idf} {if (yyleng<12) {
                   INSERT(yytext,"idf");
                   yylval.str=strdup(yytext);
                   return idf;}
                   else printf("le mot trop long %s\n sur la ligne %d\n",yytext,nb_ligne);
}
{cst} {yylval.entier=atoi(yytext); return cst;}
"(" return par_ouv;
")" return par_ferm;
"{" return acc_ouv;
"}" return acc_ferm;
"[" return cr_ouv;
"]" return cr_ferm;
"/" return division;
":=" return affectaion;
"=" return egale;
"!=" return not_egal;
"<=" return inf_eg;
">=" return sup_eg;
"<" return inf;
">" return sup;
"#" return hashtag;
"+" return plus;
"," return vg;
"-" return moins;
"%" return porsontage;
"*" return mult;
";" return pvg;
"'" return oo;
[ \t]
\n nb_ligne++;
. printf("   _____________________________________________ \n");
    printf("|               --> ERROR LEXICAL             |\n");
    printf("|               LINE : %d , ENTITE: %s         |\n",nb_ligne);
    printf("|_____________________________________________|\n");                                        
