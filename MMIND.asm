section .data               
;Canviar Nom i Cognom per les vostres dades.
developer db "_Abril_ _Pérez_"

;Constants que també estan definides en C.
DimVector equ 5		

section .text            
;Variables definides en Assemblador.
global developer                        

;Subrutines d'assemblador que es criden des de C.
global printTriesP1, checkSecretP1, getSecretP1, getPlayP1
global checkHitsP1, printSecretP1, playP1

;Variables definides en C.
extern charac, tecla, rowScreen, colScreen
extern vSecret, vPlay, tries, state

;Funcions de C que es criden des de assemblador
extern clearScreen_C, gotoxyP1_C, printchP1_C, getchP1_C
extern printMenuP1_C, printBoardP1_C, printMessage_C


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ATENCIÓ: Recordeu que les variables i els paràmetres de tipus 'char',
;;   en assemblador s'han d'assignar a registres de tipus BYTE (1 byte): 
;;   al, ah, bl, bh, cl, ch, dl, dh, sil, dil, ...
;;   i les de tipus 'int' s'han d'assignar a registres 
;;   de tipus DWORD (4 bytes): eax, ebx, ecx, edx, esi, edi, ....
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Les subrutines en assemblador que heu d'implementar són:
;;   printTriesP1, checkSecretP1, getSecretP1, getPlayP1
;;   checkHitsP1, printSecretP1  
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aquesta subrutina es dóna feta. NO LA PODEU MODIFICAR.
; Situar el cursor a la fila indicada per la variable (rowScreen) i a 
; la columna indicada per la variable (colScreen) de la pantalla,
; cridant la funció gotoxyP1_C.
; 
; Variables globals utilitzades:	
; rowScreen: fila de la pantalla on posicionem el cursor.
; colScreen: columna de la pantalla on posicionem el cursor.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gotoxyP1:
   push rbp
   mov  rbp, rsp
   ;guardem l'estat dels registres del processador perquè
   ;les funcions de C no mantenen l'estat dels registres.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8;Constants que també estan definides en C.
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call gotoxyP1_C
 
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax

   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aquesta subrutina es dóna feta. NO LA PODEU MODIFICAR.
; Mostrar un caràcter guardat a la variable (charac) a la pantalla, 
; en la posició on està el cursor, cridant la funció printchP1_C
; 
; Variables globals utilitzades:	
; charac   : caràcter que volem mostrar.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printchP1:
   push rbp
   mov  rbp, rsp
   ;guardem l'estat dels registres del processador perquè
   ;les funcions de C no mantenen l'estat dels registres.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call printchP1_C
 
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax

   mov rsp, rbp
   pop rbp
   ret
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aquesta subrutina es dóna feta. NO LA PODEU MODIFICAR.
; Llegir una tecla i guarda el caràcter associat a la variable (charac)
; sense mostrar-lo per pantalla, cridant la funció getchP1. 
; 
; Variables globals utilitzades:	
; charac   : caràcter que llegim de teclat.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getchP1:
   push rbp
   mov  rbp, rsp
   ;guardem l'estat dels registres del processador perquè
   ;les funcions de C no mantenen l'estat dels registres.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call getchP1_C
 
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax
   
   mov rsp, rbp
   pop rbp
   ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Imprimir els intents que queden (tries) per encertar la combinació 
; secreta. 
; Situar el cursor a la fila 21, columna 5 cridant la subrutina gotoxyP1.
; Mostra el caràcter associat al valor de la variable (tries) 
; cridant a la subrutina printchP1.
; Per a obtenir el caràcter associat als intents, codi ASCII del número,
; cal sumar al valor numèric dels intents (tries) 48(codi ASCII de '0').
; (charac=tries+'0' o charac=tries+48).
; 
; Variables globals utilitzades:	
; rowScreen: fila de la pantalla on posicionem el cursor.
; colScreen: columna de la pantalla on posicionem el cursor.
; charac   : caràcter que volem imprimir per pantalla.
; tries    : nombre d'intents que queden
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
printTriesP1:
   push rbp
   mov  rbp, rsp
   
   push rax
   
   mov DWORD[rowScreen],21
   mov DWORD[colScreen], 5
   
   call gotoxyP1
   
   mov eax,DWORD[tries]
   add al, "0"
   mov BYTE[charac],al
   
   call printchP1
   
   pop rax
     

   mov rsp, rbp
   pop rbp
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Llegir la combinació secreta i guardar-la en un vector de DimVector(5) posicions.
;
; · Inicialitzar amb espais el vector (vSecret) si estem entrant
;   per primer cop la combinació secreta (state=0).
; · Inicialitzar la posició del cursor a la pantalla (rowScreen=3) i
;   (colScreen=22)
; · Posicionar el cursor a la pantalla cridant a la subrutina gotoxyP1,
;   segons el valor de les variables (rowScreen i colScreen).
; · Llegir un caràcter de teclat cridant la subrutina getchP1
;   que deixa a la variable (tecla) el codi ASCII del caràcter llegit.
;    - Si s'ha llegit un caràcter vàlid ['0'-'9'] el guardem al vector
;      (vSecret).
;      Posarem un '*' a (charac) per a que no es vegi la combinació
;      secreta que escrivim(charc='*').
;      I mostrem el caràcter (charac) per pantalla a la posició on
;      està el cursor cridant al subrutina printchP1 i avançar el cursor a
;      la següent posició.
;
; NOTA: Cal tindre en compte que si es prem ENTER sense haver assignat
; valors a totes les posicions del vector, hi haurà posicions que seran
; un espai (valor utilitzat per inicialitzar els vectors).
;
; Variables globals utilitzades:	
; rowScreen: fila de la pantalla on posicionem el cursor.
; colScreen: columna de la pantalla on posicionem el cursor.
; tecla   : caràcter que llegim de teclat.
; charac   : caracter que imprimim per pantalla
; vSecret  : vector on guardem la combinació secreta
; state    : estat del joc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
getSecretP1:
   push rbp
   mov  rbp, rsp
   
			mov DWORD[rowScreen], 3
			mov DWORD[colScreen], 22
			
			call gotoxyP1

			mov EBX,0 ;Comparació bucle2
			cmp DWORD[state],0
			jne bucle2 ;Si state no és 0, no inicialitzar vSecret
			mov EAX,0
   bucle: 	cmp EAX,5 ;Bucle: Inicialitza vSecret amb espais blancs
			jge bucle2
			mov BYTE[vSecret+EAX],' '
			inc EAX
			jmp bucle

   
   bucle2:  cmp EBX, 5 ;Bucle2: Guarda el codi secret i posa asteriscs
			jge final2
			call getchP1
			cmp BYTE[tecla],'0' ;comparem amb el 0
			jl bucle2
			cmp BYTE[tecla],'9' ;comparem amb el 9
			jg bucle2
			mov bl, BYTE[tecla] 
			mov BYTE[vSecret+EBX], bl ;posem el número introduït per teclat a vSecret
			inc EBX ;incrementem ebx
			mov BYTE[charac],'*'
			
			call printchP1
			
			add DWORD[colScreen],2 ;movem el cursor dues posicions
			call gotoxyP1
			jmp bucle2

   final2:
   
   	
		
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar la combinació secreta a la part superior dels tauler 
; quan finalitza el joc.
; 
; Variables globals utilitzades:	
; rowScreen: fila de la pantalla on posicionem el cursor.
; colScreen: columna de la pantalla on posicionem el cursor.
; tecla    : caràcter que llegim de teclat.
; charac   : caracter que imprimim per pantalla
; vSecret  : vector on guardem la combinació secreta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
printSecretP1:
   push rbp
   mov  rbp, rsp
	
   

   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Llegir la jugada i guardar-la en un vector de DimVector(5) posicions.
;
; · Primer indicar la posició del cursor a la pantalla
;   (rowScreen=9+(DimVector-tries)*2) i (colScreen = 8)
;   i inicialitzar amb espais el vector (vPlay).
; · Inicialitzar la variable que utilitzarem com a índex del vector
;   (i) a 0.
; · Decrementar el nombre d'intents (tries=tries-1)
; · Posicionar el cursor a la pantalla cridant a la subrutina gotoxyP1,
;   segons el valor de les variables (rowScreen i colScreen).
; · Llegir un caràcter de teclat cridant la subrutina getchP1
;   que deixa a la variable (tecla) el codi ASCII del caràcter llegit.
;    - Si s'ha llegit un caràcter vàlid ['0'-'9'] el guardem al vector
;      (vPlay).
;      I mostrem el caràcter (charac) per pantalla a la posició on
;      està el cursor cridant al subrutina printchP1 i fem avança el curaor
;      a la següent posició.
;
; Variables globals utilitzades:	
; rowScreen: fila de la pantalla on posicionem el cursor.
; colScreen: columna de la pantalla on posicionem el cursor.
; tecla    : caràcter que llegim de teclat.
; vPlay    : vector on guardem cada jugada.
; tries    : nombre d'intents que queden
; state    : estat del joc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
getPlayP1:
   push rbp
   mov  rbp, rsp
	
   push eax
   push esi
   push ebx

      mov DWORD[rowScreen], 9
      mov eax, DWORD[tries]
      sub eax, 5
      mul eax, 2
      add DWORD[rowScreen], eax
      mov DWORD[colScreen], 8

      mov ebx, 0

      bucle4:
      cmp ebx, 5
      jg final4
      mov BYTE[vPlay+ebx], ' ' 
      inc ebx
      jmp bucle4
      
      final4:
      mov esi, 0

      dec BYTE[tries]

      call getchP1
      
      call gotoxyP1
      mov eax, 0
      bucle5:
      cmp eax, 5
      jge final5
      cmp BYTE[tecla], '0'
      jl bucle5
      cmp BYTE[tecla], '9'
      jg bucle5
      mov al, BYTE[tecla]
      mov BYTE[playP1+eax] , al
      mov BYTE[charac], al
      call printchP1
      add DWORD[colScreen], 2
      call gotoxyP1

   mov rsp, rbp
   pop rbp
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mirar si la jugada (vPlay) és igual (posició a posició) a la
; combinació secreta (vSecret), per cada posició que sigui igual
; incrementar els encerts a lloc (hitsX++).
; Si totes posicions de la combinació secreta (vSecret) i de la jugada
; (vPlay) són iguals (hitsX=5) hem guanyat (state=5).
; 
; S’han d’identificar i marcar amb una ‘x’ en el Hits aquelles posicions que
; coincideixin amb el Número secret i amb el Play
;
; Variable Local de C (en assemblador utilitzar un registre):
; hitsX    : Encerts a lloc.
;
; Variables globals utilitzades:	
; vSecret  : vector on guardem la combinació secreta
; vPlay    : vector on guardem cada jugada.
; state    ; estat del joc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
checkHitsP1:
   push rbp
   mov  rbp, rsp
	
    

   mov rsp, rbp
   pop rbp
   ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Verifica que la combinació secreta (vSecret) no tingui espais, 
; ni números repetits.
; Per cada element del vector (vSecret) mirar que no hi hagi un espai
; i que no estigui repetit a la resta del vector (de la posició 
; següent a l'actual fins al final).
; Si la combinació secreta és correcte, posar (state=1) per a indicar 
; que la combinació secreta és correcte i que anem a llegir jugades.
; Si la combinació secreta és incorrecte, posar (state=3) per tornar-la
; a demanar sense inicialitzar-la.
; 
; Variables globals utilitzades:	
; vSecret  : vector on guardem la combinació secreta
; state    : estat del joc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
checkSecretP1:
   push rbp
   mov  rbp, rsp
	
;AQUESTA FUNCIO S'HA D'IMPLEMENTAR EN EL NIVELL INTERMIG   

   mov rsp, rbp
   pop rbp
   ret








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Aquesta subrutina es dóna feta. NO LA PODEU MODIFICAR.
; Subrutina principal del joc
; Llegeix la combinació secreta i verifica que sigui correcte.
; A continuació es llegeix una jugada, compara la jugada amb la
; combinació secreta per a determinar si són iguals.
; repetir el procés mentre no s'encerta la combinació secreta i mentre 
; queden intents. Si es prem la tecla 'ESC' durant la lectura de la 
; combinació secreta o d'una jugada sortir.
; 
; Pseudo codi:
; El jugador ha de disposar de 5 intents per encertar la combinació 
; secreta i l'estat inicial del joc és 0.
; Mostrar el tauler de joc cridant la funció printBoardP1_C.
; Mostrar els intents que queden cridant la subrutina printTriesP1.
; Mostrar un missatge indicant que s'ha d'entrar la combinació secreta
; cridant la funció printMessage_C;
; Mentre (state=0) llegir combinació secreta o (state=3) s'ha llegit 
; la combinació secreta però no és correcte:
;   - Llegir i verificar la combinació secreta cridant la subrutina
;     getSecretPlayP1.
;   - Si no s'ha premut la tecla (ESC) (state!=7)  Mostrar un missatge 
;     cridant la funció printMessage_C indicant que ja es poden entrar 
;     jugades (state=1).
; Mentre (state=1) estem introduint jugades:
;   - Mostrar el intents que queden cridant la subrutina printTriesP1.
;   - Llegir la jugada cridant la subrutina getSecretPlayP1.
;   - Si no s'ha premut (ESC) cridar la subrutina chekHitsP1 per mirar 
;     si la jugada (vPlay) és igual, posició a posició, a la 
;     combinació secreta (vSecret), si és igual (state=5).
;     Decrementem els intens, i si no queden intents (tries=0) i no 
;     hem encertat la combinació secreta (state=1), hem perdut (state=6).
; Per acabar, mostrar la combinació secreta cridant la subrutina
; printSecretP1 i el missatge indicant quin ha estat el motiu
; criant la funció printMessage_C.
; S'acaba el joc.
; 
; Variables globals utilitzades:	
; rowScreen: fila de la pantalla on posicionem el cursor.
; colScreen: columna de la pantalla on posicionem el cursor.
; tries    : nombre d'intents que queden.
; state    : estat del joc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
playP1:
   push rbp
   mov  rbp, rsp

   mov  DWORD[tries], 5  ;tries = 5;
   mov  DWORD[state], 0  ;state = 0;
   call printBoardP1_C   ;printBoardP1_C();
   call printTriesP1     ;printTriesP1_C();
   call printMessage_C   ;printMessage_C();
   ;// Llegir combinació secreta fins que sigui correcte
   p1_while0:       ;while (state == 0 || state==3) {
   cmp DWORD[state], 0
   je  p1_while0_ok
   cmp DWORD[state], 3
   jne p1_while0_end
     p1_while0_ok:
	 call getSecretP1    ;getSecretP1_C();
     p1_if1:             ;if (state!=7) {
     cmp DWORD[state], 7
     je  p1_if1_end
	   call printMessage_C;printMessage_C();
     p1_if1_end:
     jmp p1_while0
   p1_while0_end:
   
   ;// Llegir les jugades
   p1_while1:       ;while (state==1) {
   cmp DWORD[state], 1
   jne p1_while1_end
	 call printTriesP1  ;printTriesP1_C();
	 call getPlayP1     ;getPlayP1_C();
	 p1_if2:            ;if (state!=7) {
	 cmp DWORD[state], 7
	 je p1_if2_end
	   call checkHitsP1 ;checkHitsP1_C();
	   dec DWORD[tries] ;tries--;
	   p1_if3:          ;if (tries == 0 && state == 1) {
	   cmp DWORD[tries], 0
	   jne p1_if3_end
	   cmp DWORD[state], 1
	   jne p1_if3_end
         mov DWORD[state], 6  ;state = 6;//Hem perdut, no queden més intents.
       p1_if3_end:
     p1_if2_end:
     jmp p1_while1
   p1_while1_end:
   call printSecretP1    ;printSecretP1_C();
   call printMessage_C   ;printMessage_C();
   
   p1_end:	
   mov rsp, rbp
   pop rbp
   ret
