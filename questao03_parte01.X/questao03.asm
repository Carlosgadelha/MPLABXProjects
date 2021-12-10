; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include <p18f4550.inc>
    
VARIAVEIS UDATA_ACS 0x20
    NUMERO RES 1	;variavel que conta os bitsn --> possui 8 bits 
    CONT RES 1	        ;variavel para contar os bits 1
    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START

    MOVLW  0x33        ;coloca o valor  no registro W
    MOVWF NUMERO       ;coloca valor de W na posiçao NUMERO da memória RAM
    
    BTFSC NUMERO, 0    ; se o bit 0 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 1    ; se o bit 1 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 2    ; se o bit 2 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 3    ; se o bit 3 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 4    ; se o bit 4 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 5    ; se o bit 5 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 6    ; se o bit 6 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    BTFSC NUMERO, 7    ; se o bit 7 de NUMERO for zero a proxima instrução sera pulada 
    INCF  CONT	       ; incrementa a variavel CONT
    
    NOP                
    END
    

    