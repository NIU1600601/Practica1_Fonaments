/**
 * Implementació en C de la pràctica, per a què tingueu una
 * versió funcional en alt nivell de totes les funcions que heu 
 * d'implementar en assemblador.
 * Des d'aquest codi es fan les crides a les subrutines de assemblador. 
 * AQUEST CODI NO ES POT MODIFICAR I NO S'HA DE LLIURAR.
 **/
 
#include <stdio.h>
#include <termios.h>    //termios, TCSANOW, ECHO, ICANON
#include <unistd.h>     //STDIN_FILENO

extern int developer;	//Variable declarada en assemblador que indica el nom del programador

/**
 * Constants
 */
#define DimVector 5


/**
 * Definició de variables globals
 */
char tecla;        //caràcter llegit de teclat.
char charac;        // per a escriure a pantalla.
int  rowScreen;	    //fila per a posicionar el cursor a la pantalla.
int  colScreen;	    //columna per a posicionar el cursor a la pantalla

char vSecret[DimVector]; //Vector amb la combinació secreta
char vPlay[DimVector];   //Vector amb la jugada
int  tries=5;       //Nombre d'intents que queden
int  state=0;       //0: Estem entrant la combinació secreta, 
                    //1: Estem entrant la jugada.
                    //3: La combinació secreta té espais o nombres repetits.
                    //5: S'ha guanyat, jugada = combinació secreta.
                    //6: S'han esgotat les jugades
                    //7: S'ha premut ESC per sortir

/**
 * Definició de les subrutines d'assemblador que es criden des de C
 */
extern void printTriesP1();
extern void checkSecretP1();
extern void getSecretP1();
extern void getPlayP1();
extern void checkHitsP1();
extern void printSecretP1();
extern void playP1();

/**
 * Definició de les funcions de C
 */
void clearscreen_C();
void gotoxyP1_C();
void printchP1_C();
void getchP1_C();
void printMessage_C();


/**
 * Esborrar la pantalla
 * 
 * Variables globals utilitzades:	
 * Cap
 * 
 * Aquesta funció no es crida des d'assemblador
 * i no hi ha definida una subrutina d'assemblador equivalent.
 */
void clearScreen_C(){
	
    printf("\x1B[2J");
    
}


/**
 * Situar el cursor a la fila indicada per la variable (rowScreen) i a 
 * la columna indicada per la variable (colScreen) de la pantalla.
 * 
 * Variables globals utilitzades:	
 * rowScreen: fila de la pantalla on posicionem el cursor.
 * colScreen: columna de la pantalla on posicionem el cursor.
 * 
 * S'ha definit un subrutina en assemblador equivalent 'gotoxyP1' per a 
 * poder cridar aquesta funció guardant l'estat dels registres del 
 * processador.
 * Això es fa perquè les funcions de C no mantenen l'estat dels registres.
 */
void gotoxyP1_C(){
	
   printf("\x1B[%d;%dH",rowScreen,colScreen);
   
}


/**
 * Mostrar un caràcter guardat a la variable (charac) a la pantalla, 
 * en la posició on està el cursor.
 * 
 * Variables globals utilitzades:	
 * charac   : caràcter que volem mostrar.
 * 
 * S'ha definit un subrutina en assemblador equivalent 'printchP1' per a
 * cridar aquesta funció guardant l'estat dels registres del processador.
 * Això es fa perquè les funcions de C no mantenen l'estat dels registres.
 */
void printchP1_C(){

   printf("%c",charac);
   
}


/**
 * Llegir una tecla i guarda el caràcter associat a la variable (charac)
 * sense mostrar-lo per pantalla. 
 * 
 * Variables globals utilitzades:	
 * charac   : caràcter que llegim de teclat.
 * 
 * S'ha definit un subrutina en assemblador equivalent 'getchP1' per a
 * cridar aquesta funció guardant l'estat dels registres del processador.
 * Això es fa perquè les funcions de C no mantenen l'estat dels 
 * registres.
 */
void getchP1_C(){

   static struct termios oldt, newt;

   /*tcgetattr obtenir els paràmetres del terminal
   STDIN_FILENO indica que s'escriguin els paràmetres de l'entrada estàndard (STDIN) sobre oldt*/
   tcgetattr( STDIN_FILENO, &oldt);
   /*es copien els paràmetres*/
   newt = oldt;

   /* ~ICANON per a tractar l'entrada de teclat caràcter a caràcter no com a línia sencera acabada amb /n
      ~ECHO per a què no mostri el caràcter llegit*/
   newt.c_lflag &= ~(ICANON | ECHO);          

   /*Fixar els nous paràmetres del terminal per a l'entrada estàndard (STDIN)
   TCSANOW indica a tcsetattr que canvii els paràmetres immediatament. */
   tcsetattr( STDIN_FILENO, TCSANOW, &newt);

   /*Llegir un caràcter*/
   tecla = (char) getchar();                 
    
   /*restaurar els paràmetres originals*/
   tcsetattr( STDIN_FILENO, TCSANOW, &oldt);
   
}


/**
 * Mostrar a la pantalla el menú del joc i demana una opció.
 * Només accepta una de les opcions correctes del menú ('0'-'9')
 * 
 * Variables globals utilitzades:	
 * rowScreen: fila de la pantalla on posicionem el cursor.
 * colScreen: columna de la pantalla on posicionem el cursor.
 * charac   : caràcter que llegim de teclat.
 * developer:((char *)&developer): variable definida en el codi assemblador.
 * 
 * Aquesta funció no es crida des d'assemblador
 * i no hi ha definida una subrutina d'assemblador equivalent.
 */
void printMenuP1_C(){
	clearScreen_C();
    rowScreen = 1;
    colScreen = 1;
    gotoxyP1_C();
    printf("                                     \n");
    printf("            Developed by:            \n");
	printf("         ( %s )   \n",(char *)&developer);
    printf(" ___________________________________ \n");
    printf("|                                   |\n");
    printf("|          MENU MASTERMIND          |\n");
    printf("|___________________________________|\n");
    printf("|                                   |\n");
    printf("|          1. PrintTries            |\n");
    printf("|          2. GetSecret             |\n");
    printf("|          3. PrintSecret           |\n");
    printf("|          4. GetPlay               |\n");
    printf("|          5. CheckHits             |\n");
    printf("|          6. CheckSecret           |\n");
    printf("|          7. Play Game             |\n");
    printf("|                                   |\n");
    printf("|          0. Exit                  |\n");
    printf("|___________________________________|\n");
    printf("|                                   |\n");
    printf("|             OPTION:               |\n");
    printf("|___________________________________|\n"); 
    
    charac=' ';
    while (tecla < '0' || tecla> '7') {
      rowScreen = 20;
      colScreen = 23;
      gotoxyP1_C();           //posicionar el cursor
	  getchP1_C();            //Llegir una opció
	}
	
}


/**
 * Mostrar el tauler de joc a la pantalla. Les línies del tauler.
 * 
 * Variables globals utilitzades:	
 * rowScreen: fila de la pantalla on posicionem el cursor.
 * colScreen: columna de la pantalla on posicionem el cursor.
 * tries    : nombre d'intents que queden.
 *  
 * Aquesta funció es crida des de C i des d'assemblador,
 * i no hi ha definida una subrutina d'assemblador equivalent.
 */
void printBoardP1_C(){
   int i;
   clearScreen_C();
   rowScreen = 1;
   colScreen = 1;
   gotoxyP1_C();
   printf(" _______________________________\n");	//1
   printf("|                               |\n");	//2
   printf("| Secret Code :      _ _ _ _ _  |\n");	//3
   printf("|_______________________________|\n");	//4
   printf("|                 |             |\n");	//5
   printf("|      Play       |     Hits    |\n");	//6
   printf("|_________________|_____________|\n");	//7
   for (i=0;i<tries;i++){							//8-17
     printf("|   |             |             |\n");
     printf("| %d |  _ _ _ _ _  |  _ _ _ _ _  |\n",i+1);
   }
   printf("|___|_____________|_____________|\n");	//18
   printf("|       |                       |\n");	//19
   printf("| Tries |                       |\n");	//20
   printf("|   _   |                       |\n");	//21
   printf("|_______|_______________________|\n"); 	//22 
   printf(" (ENTER) next Try      (ESC)Exit \n");  //23
   printf("        (k)Left   (l)Right         ");  //24
   
}



/**
 * Mostra un missatge a la part inferior dreta del tauler segons el 
 * valor de la variable (state).
 * state: 0: Estem entrant la combinació secreta, 
 *        1: Estem entrant la jugada.
 *        3: La combinació secreta té espais o nombres repetits.
 *        5: S'ha guanyat, jugada = combinació secreta.
 *        7: S'ha premut ESC per sortir
 * S'espera que es premi una tecla per continuar. Mostrat un missatge a
 * sota al tauler per indicar-ho i al prémer una tecla l'esborra.
 * 
 * Variables globals utilitzades:	
 * rowScreen: fila de la pantalla on posicionem el cursor.
 * colScreen: columna de la pantalla on posicionem el cursor.
 * state    : estat del joc.
 * 
 * Aquesta funció es crida des de C i des d'assemblador.
 * No hi ha definida una subrutina d'assemblador equivalent.
 */
void printMessage_C(){
   rowScreen = 20;
   colScreen = 11;
   gotoxyP1_C();
   switch(state){
     break;
     case 0: 
       printf("Write the Secret Code");
     break;
     case 1:
       printf(" Write a combination ");
     break;
     case 3:
       printf("Secret Code ERROR!!! ");
     break;
     case 5:
       printf("YOU WIN: CODE BROKEN!");
     break;
     case 6:
       printf("GAME OVER: No tries! ");
     break;
     case 7:
       printf(" EXIT: (ESC) PRESSED ");
     break;
   }
   rowScreen = 21;
   colScreen = 11;
   gotoxyP1_C();  //Situar el cursor a sota del tauler
   printf("    Press any key ");
   getchP1_C();	  //Esperar que es premi una tecla
   rowScreen = 21;
   colScreen = 11;
   gotoxyP1_C();  //Situar el cursor a sota del tauler
   printf("                  ");
}




void main(void){   
   int op=' ';      

   while (op!='0') {
     printMenuP1_C();	  //Mostrar menú i demanar opció
     op = tecla;
     switch(op){
       case '0':
         rowScreen=22;
         colScreen=1;
         gotoxyP1_C(); 
         break;
       case '1':	          //Mostrar intents
         state=0;
         tries=5;			  
         printBoardP1_C();      
         //=======================================================
         printTriesP1();        
         //=======================================================
         rowScreen = 21;
         colScreen = 11;
         gotoxyP1_C();
         printf("    Press any key ");
         getchP1_C();
         break;
       case '2': 	     //Llegir combinació secreta
         state=0;
         tries=5;			  
         printBoardP1_C();      
         //=======================================================
         getSecretP1();
         //=======================================================
         rowScreen = 21;
         colScreen = 11;
         gotoxyP1_C();
         printf("    Press any key ");
         getchP1_C();
         break;
       case '3': 	     //Mostrar la combinació secreta
         state=0;
         tries=5;	
         printBoardP1_C();
         //=======================================================
         printSecretP1();
         //=======================================================
         rowScreen = 21;
         colScreen = 11;
         gotoxyP1_C();
         printf("    Press any key ");
         getchP1_C();
         break;
       case '4':         //Llegir una jugada
         state=1;
         tries=5;			 
         printBoardP1_C();     
         //=======================================================
         getPlayP1();
         //=======================================================
         rowScreen = 21;
         colScreen = 11;
         gotoxyP1_C();
         printf("    Press any key ");
         getchP1_C();
         break;
       case '5': 	//Comprovar si la jugada és igual a la combinació secreta  
         state=1;
         tries=5;
         printBoardP1_C();
         tries=1;
         //=======================================================
         checkHitsP1();
         //=======================================================
         tries--;
	     if (tries == 0 && state == 1) {
           state = 6;   //Hem perdut, no queden més intents.
         }
         printMessage_C();
         break;
        case '6': 	     //Verificar la combinació secreta
         state=0;
         tries=5;	
         printBoardP1_C();
         //=======================================================
         checkSecretP1();
         //=======================================================
         printMessage_C();
         break;
      case '7': 	//joc complet en assemblador
         //=======================================================
         playP1();
         //=======================================================
         break;

     }
   }

}
