    ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

variaveis udata_acs 0x20  ;reservando espaço de memória para as variaveis
    A RES 2    ;variavel de 16bits
    B RES 2    ;variavel de 16bits
    RESULTADO RES 2	    ;resultado de 16bits

    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
 
    ;ajustando os valores das variaveis
    MOVLW 0xFF	;numero arbtrario da parte menos significativa
    MOVWF A	;menos significativo da variavel A
    
    MOVLW 0xFF	;numero arbtrario da parte mais significativa
    MOVWF A+1	;mais significativo da variavel A
    
    MOVLW 0xFF	;numero arbtrario da parte menos significativa
    MOVWF B	;menos significativo da variavel B
    
    MOVLW 0xFF	;numero arbtrario da parte mais significativa
    MOVWF B+1	;mais significativo da variavel B
 
    MOVLW 0x00
    
    NOP			;ultilizado para parar utilizando o debuger
    
    MOVF A, 0		;move o valor armazenado em A para W
    ADDWF B		;soma B e W e armazena em B
    MOVF B, 0	    	; o valor armazenado em B é movido para W
    MOVWF RESULTADO	; o valor armazenado em W é movido para RESULTADO
    
    MOVF A+1, 0	;move o valor armazenado em A+1 para W
    ADDWFC B+1		;soma B+1 e W e armazena em B+1
    MOVF B+1, 0	;move o valor armazenado em B+1 para W
    MOVWF RESULTADO+1	;move o valor armazenado em W para RESULTADO+1

    NOP
    END