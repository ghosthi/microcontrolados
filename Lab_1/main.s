; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020
; Este programa espera o usuário apertar a chave USR_SW1.
; Caso o usuário pressione a chave, o LED1 piscará a cada 0,5 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================

; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT  PortN_Output


; -------------------------------------------------------------------------------
; Função main()
Start  		
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO

NiveisIniciais
	MOV R5, #10
	MOV R6, #50
MainLoop
	MOV R0, #500
	BL SysTick_Wait1ms
	CMP	R5, R6
	BHI Acende_PN1 ; atual > target (PN1)
	BLT Acende_PN0 ; atual < target (PN0)
	B AcendeDois ; atual = target (PN1 e PN0)

AcendeDois
	MOV R0, #2_11              
	BL PortN_Output			 	 ;Chamar a função para não acender nenhum LED
	B MainLoop					 ;Se o teste viu que nenhuma chave está pressionada, volta para o laço principal
Acende_PN1
	MOV R0, #2_01
	BL Acende_LEDS				 ;Chama a rotina para piscar LED
	SUB R5, R5, #1				 ; atual > target => decrementa atual
	B MainLoop                   ;Volta para o laço principal
Acende_PN0	
	MOV R0, #2_10
	BL Acende_LEDS				 ;Chama a rotina para piscar LED
	ADD R5, R5, #1				 ; atual < target => incrementa atual
	B MainLoop                   ;Volta para o laço principal

;--------------------------------------------------------------------------------
; Função Acende_LEDS (PN0, PN1)
; Parâmetro de entrada: se os BIT1 e BIT0 estão ligado ou desligado
; Parâmetro de saída: Não tem
Acende_LEDS
	PUSH {LR}
	BL PortN_Output				 ;Chamar a função para acender o LED1
	POP {LR}
	BX LR						 ;return

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da seção está alinhada 
    END                          ;Fim do arquivo
