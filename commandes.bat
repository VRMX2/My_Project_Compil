flex lexical.l
bison -d syntaxique.y
gcc lex.yy.c  syntaxique.tab.c -lfl -ly -o vrmx_compil.exe