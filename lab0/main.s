; main.s

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Defines
RAM_VEC_ST  EQU     0x20000400
AVG_MEM_IDX EQU     0x20000500
MAX_MEM_IDX EQU     0x20000501
MIN_MEM_IDX EQU     0x20000502
NNL_MEM_IDX EQU     0x20000503
DVP_MEM_IDX EQU     0x20000504


		AREA  DATA, ALIGN=2


; -------------------------------------------------------------------------------
; Area de Codigo 
        AREA    |.text|, CODE, READONLY, ALIGN=2
        
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
				            
Start

    MOV R0, #0
    MOV R1, #0
    MOV R2, #0xFFFF
	MOVT R2, #0xFFFF
    MOV R3, #0
    MOV R4, #0
    MOV R5, #0
    MOV R6, #0
    LDR R7, =RAM_VEC_ST
    MOV R9, #0

leitura
    CMP R0, #20         ; 20 posições esgotadas
    BEQ media           ; vai pro calculo de media

    LDRB R9, [R7], #1
    ADD R0, R0, #1

    CMP R9, #0          
    BEQ leitura         ; Ignora pois leu zero
    
    ADD R5, R5, #1
    ADD R6, R6, R9

    CMP R9, R1          ; DEVERIA SER DENTRO DE IF THEN ELSE
    ADDHS R1, R9, #0    ; Maior que o maior encontrado até agora

    CMP R9, R2
    ADDLS R2, R9, #0    ; Menor que o menor encontrado até agora

    B leitura

media
    UDIV R3, R6, R5     ; R3 = R6 / R5

armazenamento
    LDR R0, =MAX_MEM_IDX
    STRB R1, [R0]
    LDR R0, =MIN_MEM_IDX
    STRB R2, [R0]
    LDR R0, =NNL_MEM_IDX
    STRB R5, [R0]
    LDR R0, =AVG_MEM_IDX
    STRB R3, [R0]

    MOV R0, #0
    MOV R1, #0
    MOV R2, #0
    MOV R9, #0
    LDR R7, =RAM_VEC_ST

    NEG R3, R3            	; negativo pois vai usar na subtração
    BL variancia
    NEG R3, R3				; retorna media original
	
    MOV R0, #0
    MOV R1, #1
	MOV R0, #0
    B raiz

variancia
    CMP R0, #20 ;IFTE
    UDIVHS R2, R2, R5       ; calcula soma_diferencas / n
	BXHS LR                 ; retorno

    LDRB R9, [R7], #1

    ADD R0, R0, #1          ; i++

    CMP R9, #0              
    BEQ variancia           ; ignorar valor zero

    ADD R1, R9, R3          ; R1 = ATUAL - AVG

    MLA R2, R1, R1, R2      ; R2 = R2 + (R1 * R1)
    B variancia

raiz
    MUL R1, R0, R0

    CMP R1, R2      
    BHS final               ; final se R0*R0 >= R2

    ADD R0, R0, #1          ; i++
    B raiz


final
    MOV R1, R0
    LDR R0, =DVP_MEM_IDX
    STRB R1, [R0]           ; armazena DVP

    NOP    

    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo