# Compiler-Project
This project is the mini calculator where you can learn the basic of bison and flex and their parsing.



To run the following code, you must put them in same folder and then put the command in the upper cmd button on black screen.You may change the exe name on shafin if you want.


bison -d 1.y
flex 1.l
gcc lex.yy.c 1.tab.c -o shafin
shafin
