; TODO IN/S+ERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
    
variaveis udata_acs 0x20  ;reservando espaço de memória para as variaveis
    A RES 2    ;variavel de 16bits
    B RES 2    ;variavel de 16bits
    RESULTADO RES 2	    ;resultado de 16bits

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START

    MOVLW A		; coloca o valor de A no registro W
    MOVWF h'02'         ; coloca valor de W na posiçao 2 de memória RAM
    MOVLW B		; coloca o valor de B no registro W
    ADDWF 0x02,W 	; W = W + file REGISTRE 0x02
    MOVWF RESULTADO	; o valor armazenado em W é movido para RESULTADO

     
    END
    
    
    
    
MAIOR
    NOP
    END
    
MENOR
    NOP
    END
    
IGUAL 
    MOVF h'02',W
    SUBWF h'06',W
    BTFSC STATUS,C      ;testa 6 bit C de status --> RESULTADO = 0 pula uma linha 
    MOVFF h'02',h'08'   ; h'02'< h'06' --> resultado colocado na posicao 8 de memoria ram (NUMERO MENOR)
    BTFSS STATUS,Z      ; RESULTADO = 1 pula uma linha 
    MOVFF h'02',h'10'   ; h'02'> h'06' --> resultado colocado na posicao 10 de memoria ram (NUMERO MAIOR)
    MOVFF h'04',h'10'  ; todos os numeros são iguais
    MOVFF h'04',h'08'
    END
    