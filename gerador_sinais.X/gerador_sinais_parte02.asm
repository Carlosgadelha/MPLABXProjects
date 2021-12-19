#include "p18f4550.inc"
    ; Matricula = 389110
    ; T = 100 + 100N
    ; Como N  = 0 --> T = 100 us

VARIAVEIS UDATA_ACS 0
      ContaPeriodo100us ;Variavel para dar um periodo de 100us
 
RES_VECT  CODE    0x0000            
	GOTO START
MAIN_PROG CODE                      
START
	    ;DETERMINANDO AS PORTAS DE ENTRADA E SAIDA
    MOVLW b'110001' ; Move o literal 110001 para o registrador W
    MOVWF TRISD ; Move o W para o TRISD
	;1 é para as entradas e 0 para as saidas
	;Temos que 0, 4 e 5 são entradas
	;Temos que 1, 2 e 3 são saidas
    
	    ;GERADOR DE FORMA DE ONDA DA FIGURA
    LOOP ; Loop principal
	bsf PORTD,RD1; Seta o bit RD1 da PORTD para 1
		CALL Periodo10us ;Gera um periodo de 1ms
		nop; Consome um tempo de 1us
	bcf PORTD,RD1 ; Seta o bit RD1 da PORTD para 0
	
	
	bsf PORTD,RD2 ; Seta o bit RD2 da PORTD para 1
		CALL Periodo10us ;Gera um periodo de 1ms
		nop; Consome um tempo de 1us
	bcf PORTD,RD2 ;Seta o bit RD2 da PORTD para 0
	
	bsf PORTD,RD3 ;Seta o bit RD3 da PORTD para 1
		CALL Periodo10us ;Gera um periodo de 1ms
		nop; Consome um tempo de 1us
	bcf PORTD,RD3 ;Seta o bit RD03 da PORTD para 0
	
	
	GOTO LOOP; Vai para o LOOP, gerando um loop
	    Periodo10us ; Gera um periodo de quase 1ms
		MOVLW .10 ; Poem o literal 10(decimal) no registrador W
		MOVWF ContaPeriodo100us ;Move o valor do registrador W para a variavel ContaPeriodo100us
	    LOOP2      ; Loop que ira gerar o periodo de 10us
			NOP;Consome 1us
			NOP
			NOP
			NOP
			NOP
			NOP
			NOP
			NOP
			NOP
			NOP
		DECFSZ ContaPeriodo100us ; Diminui em 1 o valor de ContaPeriodo1ms
	    ;Caso o valor de ContaPeriodo1ms seja 0, a proxima linha é pulada
	    GOTO LOOP2  ; Repete estes comandos até que ContaPeriodo1ms seja 0
    RETURN


    END