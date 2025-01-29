typedef struct
{
char NomEntite[20];
char CodeEntite[20];
char TypeEntite[20];
char Constante[20];
int taille;
int Value;
} TypeTS;

//initiation d'un tableau qui va contenir les elements de la table de symbole
TypeTS ts[100]; 

// un compteur global pour la table de symbole
int CpTabSym=0;


//une fonctione recherche: pour chercher est ce que l'entité existe ou non déjà dans la table de symbole.
// i: l'entite existe dejà dans la table de symbole, et sa position est i, -1: l'entité n'existe pas dans la table de symbole.

int SEARCH(char entite[])
{
int i=0;
while(i<CpTabSym)
{
if (strcmp(entite,ts[i].NomEntite)==0) return i;
i++;
}

return -1;
}

//une fontion qui va insérer les entités de programme dans la table de symbole
void INSERT(char entite[], char code[])
{

if ( SEARCH(entite)==-1)
{
strcpy(ts[CpTabSym].NomEntite,entite); 
strcpy(ts[CpTabSym].CodeEntite,code);
strcpy(ts[CpTabSym].Constante,"No");


//printf("lentite est %s, sont type est %s %d\n",ts[CpTabSym].NomEntite,ts[CpTabSym].TypeEntite,CpTabSym);
CpTabSym++;
}
}

//une fonction pour afficher la table de symbole
void SHOW ()
{
printf("\n--------------->TABLE OF SYMBOLES<-------------\n");
printf("____________________________________________________________________________________________\n");
printf("\t| NomEntite |  CodeEntite  |  TypeEntite | Constante   | Value_const |    Taille   |  \n");
printf("____________________________________________________________________________________________ \n");
int i=0;
while(i<CpTabSym)
{

printf("\t|%10s |%12s  |%12s |%12s |%12d |%12d |\n",ts[i].NomEntite,ts[i].CodeEntite,ts[i].TypeEntite,ts[i].Constante,ts[i].Value,ts[i].taille);

i++;
}
}


// fonction qui change le type d'une etité une fois il va être reconu dans la syntaxe 

void INSERT_TYPE(char entite[], char type[])
{

int posEntite=SEARCH(entite);
if (posEntite!=-1)
{ 

strcpy(ts[posEntite].TypeEntite,type);

//printf("lentite est %s, sont type est %s %d\n",ts[CpTabSym].NomEntite,ts[CpTabSym].TypeEntite,CpTabSym);

}
}





//////////////////////////////////////////////////////
////Les routines sémantiques

int DOUBLE_DECLARATION (char entite[])
{
int posEntite=SEARCH(entite);

//printf ("\nposi %d\n",posEntite);
if (strcmp(ts[posEntite].TypeEntite,"")==0) return 1;  // j'ai pas trouvé le type associé à l'entité dans le table de symbole et donc elle est pas encore déclarée
else return 0; // le type de l'entité existe dejà dans la TS et donc c'est une double déclaration
}


// function to insert constant 
void insert_constante(char entite[], int value){
    int posEntite = SEARCH(entite);
    strcpy(ts[posEntite].Constante,"yes");
    ts[posEntite].Value=atoi(value);
}



// function const vall 
int Const_val(char entite[]){
    int pos = SEARCH(entite);
    if(strcmp(ts[pos].Constante,"No")==0) return -1;
    else {if(strcmp(ts[pos].Constante,"")==0) return -1;
    else return 1;
    }
}



//function to add a taille of elemnts
void INSERT_TAILLE(char entite[],int taille)
{
    // if we have just simple elemnts we insert 1 if nonn we insert the taille of table
    int posEntite = SEARCH(entite);
    ts[posEntite].taille=atoi(taille);
}

int Idf_not_declared(char entite[]){
    int pos = SEARCH(entite);
    if (pos == -1) {return -1;}
    if(strcmp(ts[pos].TypeEntite,"")==0){return -1;}
    else{return 1;}
}

// // fonction pour verifier le formatage
// int verify_formatage(char format_chaine[],char entite){
//     int pos = SEARCH(entite);
//     int i=0;
//     int taille_chaine = strlen(format_chaine);
//     char copy[20];
//     char format[20];
//     for(i=0;i<taille_chaine;i++){
//         if(format_chaine[i]=='%'){
//             if(format_chaine[i+1]=='d'){
//                 strcpy(copy,'%');
//                 strcat(copy,'d');
//                 strcpy(format,copy);
//             }
//             else if(format_chaine[i+1]=='s'){
//                 strcpy(copy,'%');
//                 strcat(copy,'s');
//                 strcpy(format,copy);
//             }
//             else if(format_chaine[i+1]=='f'){
//                 strcpy(copy,'%');
//                 strcat(copy,'f');
//                 strcpy(format,copy);
//             }
//         }
//     }
//     if(pos!=-1){
//         if(strcmp(format,ts[i].TypeEntite)==0){return 0;}
//         else{return 1;}
//     }
// }
