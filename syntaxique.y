%{
int nb_ligne=1;
char sauv [20];
char tempvalue [20];
char temp[20];
%}
%union{
char* str;
int entier; 
}
%token mc_begin mc_d mc_f deux oo mc_s mult  mc_For par_ferm par_ouv mc_end plus mc_for mc_in mc_out mc_program <str>mc_float <str>mc_const <str>mc_real <str>mc_integer <str>mc_string <str>idf idf_tab <entier>cst acc_ferm acc_ouv cr_ferm cr_ouv division affectaion egale not_egal inf_eg sup_eg sup inf hashtag vg moins pvg porsontage
%%
S:The_programm{
                                       printf(" ____________________________________________\n ");
                                       printf("|   \n  --> YOUR SYNTAX IS CORRECT EXCELLENT<3     |\n");
                                       printf(" |___________________________________________|\n");  
                                                                  YYACCEPT;
              }         
;










The_programm: mc_program idf acc_ouv Corsp_programme acc_ferm
;





Corsp_programme:Liste_declaration  Liste_insertion Liste_affichage_write
;





Liste_declaration: Dec_type Liste_declaration
                   |
;






Dec_type: Dec_variables
           |Dec_Constante 
             |Dec_tableaux
;







Dec_variables:Type_variables Liste_variables pvg
;






Liste_variables:Liste_variables vg idf {if(Const_val($3)==1){ 
                                                             printf("\n----------------------------------------------------------------------------------------\n");
                                                             printf("\n-->Error semantique in the line %d, u have declare --> %s <-- is constant before\n",nb_ligne,$3);
                                                             printf("\n--------------------------------------------------------------------------------------------------\n");
                                                            }
                                                            else{
                                                              if(DOUBLE_DECLARATION($3)==1){
                                                                 INSERT_TYPE($3,sauv); 
                                                                         strcpy(temp,"1"); 
                                                                            INSERT_TAILLE($3,temp);
                                                              }
                                                              else{
                                                                  printf(" -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$3,nb_ligne);}
                                                              }
                                                            }
                  |idf {if(Const_val($1)==1){
                                             printf("\n----------------------------------------------------------------------------------------\n");
                                             printf("\n--->Error semantique in the line %d, u have declare --> %s <-- is constant before\n",nb_ligne,$1);
                                             printf("\n----------------------------------------------------------------------------------------\n");
                                            }
                                            else{
                                              if(DOUBLE_DECLARATION($1)==1){ 
                                                      INSERT_TYPE($1,sauv);  
                                                         strcpy(temp,"1"); 
                                                             INSERT_TAILLE($1,temp);
                                              }
                                              else {
                                                printf("____________________________________________\n");
                                                printf("| -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$1,nb_ligne);
                                                printf("____________________________________________\n");}
                                                
                                            }
                       }
;







Type_variables:mc_integer { strcpy(sauv,$1); }
                 |mc_float { strcpy(sauv,$1); } 
                   |mc_real { strcpy(sauv,$1); }
                     |mc_string { strcpy(sauv,$1); }
                      |mc_const { strcpy(sauv,$1); }
;







Liste_idf_tab:Idf_tab vg Liste_idf_tab
               |Idf_tab
;






Dec_Constante:mc_const Type_variables Liste_cnst pvg
;






Liste_cnst:idf affectaion cst vg Liste_cnst {
                                        if(Idf_not_declared($1)==1){
                                          printf("_______________________________________________________________________________\n");
                                          printf("ERROR IN THE LINE %d ,u don't declare the idf %s , please declare it before \n",nb_ligne,$1);
                                          printf("______________________________________________________________________________");}else{
                                         if(DOUBLE_DECLARATION($1)==1){ 
                                             INSERT_TYPE($1,sauv); 
                                                sprintf(tempvalue,"%d",$3); 
                                                   insert_constante($1,tempvalue);  
                                                      strcpy(temp,"1"); 
                                                          INSERT_TAILLE($1,temp); }
                                                              else{
                                                                printf("_______________________________________________\n");
                                                                printf("| -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$1,nb_ligne);
                                                                printf("_______________________________________________\n");}
                                                              }}
               |idf vg Liste_cnst  {
                                if(DOUBLE_DECLARATION($1)==1){
                                  INSERT_TYPE($1,sauv); 
                                    insert_constante($1,""); strcpy(temp,"1");
                                       INSERT_TAILLE($1,temp); }
                                       else{
                                        printf("____________________________________________________\n");
                                         printf("| -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$1,nb_ligne);
                                         printf("____________________________________________________\n");}
                                        }
                  |idf affectaion cst {
                                if(DOUBLE_DECLARATION($1)==1){
                                  INSERT_TYPE($1,sauv); 
                                    sprintf(tempvalue,"%d",$3); 
                                       insert_constante($1,tempvalue); 
                                         strcpy(temp,"1"); 
                                            INSERT_TAILLE($1,temp);}
                                             else{
                                              printf("______________________________________________\n");
                                               printf("| -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$1,nb_ligne);
                                               printf("_____________________________________________\n");}
                                               
                                              }
                      |idf {
                            if(DOUBLE_DECLARATION($1)==1){
                                INSERT_TYPE($1,sauv); 
                                  insert_constante($1,""); 
                                     strcpy(temp,"1"); 
                                          INSERT_TAILLE($1,temp);
                                            }
                                              else{
                                                printf("_____________________________________________\n");
                                                printf("| -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$1,nb_ligne);
                                                printf("_____________________________________________\n");}
                                                
                                              }
;





Dec_tableaux:Type_variables Liste_idf_tab pvg 
;




Idf_tab:idf cr_ouv cst cr_ferm {
                                if(DOUBLE_DECLARATION($1)==1){
                                    INSERT_TYPE($1,sauv);
                                        sprintf(temp,"%d",$3);
                                           INSERT_TAILLE($1,temp);
                                }
                                else{
                                  printf("___________________________________________\n");
                                  printf("| DOUBLE DELCLARATION %s SUR LA LIGNE %d\n",$1,nb_ligne);
                                  printf("___________________________________________\n");
                                } 
                              }
;




Liste_insertion:Ins_type Liste_insertion
                |
;




Ins_type:Ins_aff 
          |Ins_For
;




Ins_aff:idf affectaion Liste_op pvg {
          if(Idf_not_declared($1)==1){
            printf("ERROR SEMANTIQUE IN THE LINE %d ,IDF %s NOT DECLARED PLEASE DECLARED BEFORE\n");}else{
          strcpy(temp,"1"); INSERT_TAILLE($1,temp);}}
            |idf affectaion idf division cst pvg {if ($5==0){
                                                    printf(" ____________________________________________________\n");
                                                    printf("| -->ERROR SEMANTIQUE LINE %d ,--DIVISION PAR ZERO-- |\n",nb_ligne);
                                                    printf("|____________________________________________________|\n");
                                                    }}
              |Idf_tab affectaion Liste_op pvg
                   |Idf_tab affectaion idf division cst {if ($5==0){
                                                    printf(" ____________________________________________________\n");
                                                    printf("| -->ERROR SEMANTIQUE LINE %d ,--DIVISION PAR ZERO-- |\n",nb_ligne);
                                                    printf("|____________________________________________________|\n");
                                                    }}
;





Liste_op:Value Op Liste_op
        |Value
;

Value:idf {if(Idf_not_declared($1)==1){
            printf("ERROR SEMANTIQUE IN THE LINE %d ,IDF %s NOT DECLARED PLEASE DECLARED BEFORE\n");}
             else{strcpy(temp,"1"); 
               INSERT_TAILLE($1,temp);}}
                     |cst
                        |idf cr_ouv cst cr_ferm
;




Ins_For:Type_for par_ouv Tous_les_cas_for_declaration par_ferm mc_begin Corps_for mc_end 
;




Type_for:mc_for
         |mc_For
;



Tous_les_cas_for_declaration: idf affectaion cst pvg idf inf cst pvg idf plus plus {
                                     if($1==$5 && $1==$9){
                                       if(DOUBLE_DECLARATION($1)==1){
                                               INSERT_TYPE($1,sauv);  
                                                   strcpy(temp,"1"); 
                                                      INSERT_TAILLE($5,temp); 
                                                          INSERT_TAILLE($1,temp);
                                        }
                                        else{
                                          printf("_____________________________________________");
                                          printf("| -->DOUBLE DELCLARATION %s SUR LA LIGNE %d\n" ,$1,nb_ligne);
                                          printf("_____________________________________________");
                                        }
                                       }
                                       else("ERROR IN SYNATX FOR U DECLARED ANOTHER DIFFERENT IDENTIFIER\n");
                                      }
                                               |Type_variables idf affectaion cst pvg idf inf cst pvg idf plus plus {
                                                                       INSERT_TYPE($2,sauv);
                                                                         strcpy(temp,"1"); 
                                                                            INSERT_TAILLE($2,temp); 
                                                                              INSERT_TAILLE($6,temp);
                                                                                INSERT_TAILLE($9,temp);
                                                                 }
                                           |Type_variables idf affectaion cst pvg idf inf_eg cst pvg idf plus plus  {
                                                 if($2==$6 && $2==$10){
                                                               INSERT_TYPE($2,sauv);
                                                                     strcpy(temp,"1"); 
                                                                        INSERT_TAILLE($2,temp); 
                                                                          INSERT_TAILLE($6,temp);
                                                                            INSERT_TAILLE($10,temp);
                                                          }
                                                          else{
                                                                  printf("______________________________________________________________");
                                                                  printf("ERROR IN SYNATX FOR U DECLARED ANOTHER DIFFERENT IDENTIFIER\n");
                                                                  printf("______________________________________________________________");
                                                                  }
                                                              
                                                            }
                                                      |idf affectaion cst pvg idf inf_eg  {
                                                          if($1==$5){
                                                          INSERT_TYPE($1,sauv);
                                                             }
                                                             else{
                                                              printf("______________________________________________________________");
                                                              printf("ERROR IN SYNATX FOR U DECLARED ANOTHER DIFFERENT IDENTIFIER\n");
                                                              printf("______________________________________________________________");
                                                             }
                                                            }

; 





Corps_for:Dec_For_op Corps_for
           |
;




Dec_For_op:idf egale idf Op idf pvg {
                         strcpy(temp,"1"); 
                                    INSERT_TAILLE($1,temp);
                                       INSERT_TAILLE($3,temp); 
                                         INSERT_TAILLE($5,temp);
                          }

                   |idf egale idf Op cst pvg {
                              strcpy(temp,"1"); 
                                    INSERT_TAILLE($1,temp);
                                       INSERT_TAILLE($3,temp);
 
                          }
                                 |idf egale idf division cst pvg {if ($5==0){
                                                    printf(" ____________________________________________________\n");
                                                    printf("| -->ERROR SEMANTIQUE LINE %d ,--DIVISION PAR ZERO-- |\n",nb_ligne);
                                                    printf("|____________________________________________________|\n");
                                                    }
                                                    else{
                                                      strcpy(temp,"1"); 
                                                            INSERT_TAILLE($1,temp);
                                                               INSERT_TAILLE($3,temp);
                                                    }
                                                  }
;




Liste_affichage_write:Type_affichage Liste_affichage_write
                        |Type_write Liste_affichage_write
                         |
;





Type_affichage:mc_in par_ouv oo Type_formatage oo vg idf par_ferm pvg {
                                                      strcpy(temp,"1"); 
                                                            INSERT_TAILLE($7,temp);
                                                      }
;


Type_write:mc_out par_ouv oo idf Type_formatage oo vg idf par_ferm pvg
              |mc_out par_ouv oo Type_formatage oo vg idf par_ferm pvg
                   |mc_out par_ouv oo idf idf Type_formatage oo vg idf par_ferm pvg
;


Type_formatage:mc_d
                |mc_f 
                  |mc_s
;






Op:division
    |plus
      |mult
           |moins
;


;
%%
main ()
{
    yyparse();
    SHOW();
} 
yywrap()
{}


yyerror(char*msg){
            printf(" ________________________________________________ \n");
            printf("|               --> ERROR SYNTAXIQUE             |\n");
            printf("|                     LINE : %d                  |\n",nb_ligne);
            printf("|________________________________________________|\n"); 
}
