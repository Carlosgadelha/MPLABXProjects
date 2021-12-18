; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include <p18f4550.inc> 
    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program 
    
VARIAVEIS UDATA_ACS 0x20
    v1 RES 2	   ; dividendo --> 2 bytes
    v2 RES 1       ; divisor --> 1 byte
    q  RES 2       ; quociente --> 2 bytes
    r  RES 2       ; resto --> 2 bytes
    aux RES 2      ;  utilizado ara sunbtrações sucessivas sem destruir o dividendo


MAIN_PROG CODE     ; let linker place main program

START
    ;inicializa dividendo: 2312h = 8978
    MOVLW h'12'
    MOVWF v1
    MOVLW h'23'
    MOVWF v1+1
    
    ;inicializa divisor: 28h = 43
    MOVLW h'2B'
    MOVWF v2
    NOP
    CALL DIV_16 ; chama a rotina para dividir
                ; resultado: q = 208, r = 34
    GOTO $      ; fim
    
    
    ; Rotina DIV_16 --> divide v1 por v2 retornando q(quociente)e o resto(r)
    
    DIV_16
    
      CLRF q    ; zerar o quociente(lsb)
      CLRF q+1  ; zerar o quociente(msb)
      MOVFF v1,aux ; opera subtrações sobre aux e aux+1 --> copia v1 para aux
      MOVFF v1+1,aux+1
    
    REP_SUB
      MOVFF aux,r       ; resto (1sb) --> guarda o canditado a resto
      MOVFF aux+1, r+1  ; resto (msb)
      MOVF v2,W         ; subtrações sucessivas (v1 v1+1) - v2
      SUBWF aux         ; (aux)lsb = (aux)lsb - v2
      CLRF WREG
      SUBWFB aux+1      ; (aux)msb = (aux)msb - 0 - Emprestimo
      BN FIM_DIV        ; Se resultado = negativo acabou
      
      MOVLW 1           ; senão soma 1 ao quociente
      ADDWF q
      CLRF WREG
      ADDWFC q+1
      BRA REP_SUB       ; realiza subtrações sucessivas
      
    FIM_DIV
     
     RETURN
     END
      
    
    
    


    