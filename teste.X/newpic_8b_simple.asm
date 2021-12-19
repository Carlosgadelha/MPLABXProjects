num1_maisig EQU 0	
num1_menosig EQU 1
num2_maisig EQU 2
num2_menosig EQU 3
resp_overflow EQU 4
resp_maisig EQU 5
resp_menosig EQU 6

#include "p18f4550.inc"

RES_VECT  CODE    0x0000           
    GOTO    START               

START
    ; num1 = 32123 (01111101 01111011)
    ;                125       123
    
    ; num2 = 45211 (10110000 10011011)
    ;                 176       155
    
    MOVLW .125    
    MOVWF num1_maisig		
    MOVLW .123
    MOVWF num1_menosig		; num1_maisig => 125, num1_menosig => 123 
    MOVLW .176                 
    MOVWF num2_maisig		
    MOVLW .155
    MOVWF num2_menosig		; num2_maisig => 176, num2_menosig => 155 

    MOVLW .0			
    ADDWF num1_menosig, w		
    ADDWFC num2_menosig, w	; W = num2_menosig + num2_maisig, e seta carry bit C se houve estouro
    MOVWF resp_menosig	
    MOVLW .0	
    
    BTFSC STATUS, C		; Testa o bit C, se setado, W é incrementado
    ADDLW .1
    ADDWFC num1_maisig, w
    ADDWFC num2_maisig, w	; W = W + num1_menosig + num2_maisig, e seta carry bit C se houve estouro
    MOVWF resp_maisig	
    
    BTFSC STATUS, C		;  Testa o bit C, se setado, resp_overflow é incrementado
    INCF resp_overflow
    
    ; num1(32123) + num2(45211) = resposta(77334 decimal, 10010111000010110 binário )
   
    GOTO $
    END