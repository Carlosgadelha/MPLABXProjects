; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include <p18f4550.inc>
    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START

    MOVLW d'90'		; coloca o valor de A no registro W
    MOVWF h'02'         ; coloca valor de W na posiçao 2 de memória RAM
    
    MOVLW d'69'		; coloca o valor de A no registro W
    MOVWF h'04'         ; coloca valor de W na posiçao 2 dA memória RAM
    
    MOVLW d'09'		; coloca o valor de A no registro W
    MOVWF h'06'         ; coloca valor de W na posiçao 2 de memória RAM
    
    MOVF h'02',W        ; coloca o valor da posição 2 de memoria para W
    SUBWF h'04',W       ; W = h'04' - W
    BTFSC STATUS,C      ;testa 6 bit C de status --> RESULTADO = 0 pula uma linha 
    GOTO MENOR
    BTFSS STATUS,Z      ; RESULTADO = 1 pula uma linha
    GOTO MAIOR
    GOTO IGUAL

IGUAL
    MOVFF h'02',h'10'   ; h'02'> h'04' --> resultado colocado na posicao 8 de memoria ram (NUMEROS IGUAIS)
    MOVFF h'04',h'08'   ; h'02'< h'04' --> resultado colocado na posicao 4 de memoria ram (NUMEROS IGUAIS)
    MOVF h'06',W        ; coloca o valor da posição 6 de memoria para W
    SUBWF h'10',W       ; W = h'10' - W
    BTFSC STATUS,C      ;testa 6 bit C de status --> RESULTADO = 0 pula uma linha 
    GOTO ATUALIZA_MENOR
    BTFSS STATUS,Z      ; RESULTADO = 1 pula uma linha
    MOVFF h'06',h'10'   ; atualiza o valor maior --> resultado colocado na posicao 10 de memoria ram (NUMERO MAIOR)
    NOP
   
    
MAIOR 
    MOVFF h'02',h'10'   ; h'02'> h'04' --> resultado colocado na posicao 8 de memoria ram (NUMERO MAIOR)
    MOVFF h'04',h'08'   ; h'02'< h'04' --> resultado colocado na posicao 4 de memoria ram (NUMERO MENOR)
    MOVF h'06',W        ; coloca o valor da posição 6 de memoria para W
    SUBWF h'10',W       ; W = h'10' - W
    BTFSC STATUS,C      ;testa 6 bit C de status --> RESULTADO = 0 pula uma linha 
    GOTO ATUALIZA_MENOR
    BTFSS STATUS,Z      ; RESULTADO = 1 pula uma linha
    MOVFF h'06',h'10'   ; atualiza o valor maior --> resultado colocado na posicao 10 de memoria ram (NUMERO MAIOR)
    
    
MENOR
    MOVFF h'02',h'08'   ; h'02'< h'04' --> resultado colocado na posicao 8 de memoria ram (NUMERO MENOR)
    MOVFF h'04',h'10'   ; h'02'> h'04' --> resultado colocado na posicao 4 de memoria ram (NUMERO MAIOR)
    MOVF h'06',W        ; coloca o valor da posição 6 de memoria para W
    SUBWF h'10',W       ; W = h'10' - W
    BTFSC STATUS,C      ;testa 6 bit C de status --> RESULTADO = 0 pula uma linha 
    GOTO ATUALIZA_MENOR
    BTFSS STATUS,Z      ; RESULTADO = 1 pula uma linha
    MOVFF h'06',h'10'   ; atualiza o valor maior --> resultado colocado na posicao 10 de memoria ram (NUMERO MAIOR)
    
      
ATUALIZA_MENOR          ; Verifica se o (MENOR) < que h'06' 
    MOVF h'06',W        ; coloca o valor da posição 6 de memoria para W
    SUBWF h'08',W       ; W = h'08' - W --> testando s eo valor da posição 6 é menor que o resultado anterior(MENOR)
    BTFSC STATUS,C      ;testa 6 bit C de status --> RESULTADO = 0 pula uma linha
    MOVFF h'06',h'08'   ; h'06'< h'02' --> resultado colocado na posicao 8 de memoria ram (NUMERO MENOR)

    END
    

    