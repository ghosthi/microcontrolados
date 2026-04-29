; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
; ========================
; Definições de Valores
BIT0	EQU 2_0001
BIT1	EQU 2_0010
; ========================
; Definições dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Definições dos Ports
; PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU    0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ_AHB_DATA_BITS_R  EQU    0x40060000
; Interrupções do Pino J
GPIO_PORTJ_AHB_IM_R			EQU    0x40060410
GPIO_PORTJ_AHB_IS_R			EQU    0x40060404
GPIO_PORTJ_AHB_IBE_R		EQU    0x40060408
GPIO_PORTJ_AHB_IEV_R		EQU    0x4006040C
GPIO_PORTJ_AHB_ICR_R        EQU	   0x4006041C
GPIO_PORTJ_AHB_MIS_R  		EQU    0x40060418
GPIO_PORTJ               	EQU    2_000000100000000
	
; NVIC 
NVIC_EN1_R           		EQU    0xE000E104
NVIC_PRI12_R		 		EQU    0xE000E430 

; PORT N
GPIO_PORTN_LOCK_R    		EQU    0x40064520
GPIO_PORTN_CR_R      		EQU    0x40064524
GPIO_PORTN_AMSEL_R   		EQU    0x40064528
GPIO_PORTN_PCTL_R    		EQU    0x4006452C
GPIO_PORTN_DIR_R     		EQU    0x40064400
GPIO_PORTN_AFSEL_R   		EQU    0x40064420
GPIO_PORTN_DEN_R     		EQU    0x4006451C
GPIO_PORTN_PUR_R     		EQU    0x40064510	
GPIO_PORTN_DATA_R    		EQU    0x400643FC
GPIO_PORTN_DATA_BITS_R  	EQU    0x40064000
GPIO_PORTN               	EQU    2_001000000000000	

	
; PORT A
GPIO_PORTA_AHB_DATA_BITS_R EQU 0x40058000
GPIO_PORTA_AHB_DATA_R EQU 0x400583FC
GPIO_PORTA_AHB_DIR_R EQU 0x40058400
GPIO_PORTA_AHB_IS_R EQU 0x40058404
GPIO_PORTA_AHB_IBE_R EQU 0x40058408
GPIO_PORTA_AHB_IEV_R EQU 0x4005840C
GPIO_PORTA_AHB_IM_R EQU 0x40058410
GPIO_PORTA_AHB_RIS_R EQU 0x40058414
GPIO_PORTA_AHB_MIS_R EQU 0x40058418
GPIO_PORTA_AHB_ICR_R EQU 0x4005841C
GPIO_PORTA_AHB_AFSEL_R EQU 0x40058420
GPIO_PORTA_AHB_DR2R_R EQU 0x40058500
GPIO_PORTA_AHB_DR4R_R EQU 0x40058504
GPIO_PORTA_AHB_DR8R_R EQU 0x40058508
GPIO_PORTA_AHB_ODR_R EQU 0x4005850C
GPIO_PORTA_AHB_PUR_R EQU 0x40058510
GPIO_PORTA_AHB_PDR_R EQU 0x40058514
GPIO_PORTA_AHB_SLR_R EQU 0x40058518
GPIO_PORTA_AHB_DEN_R EQU 0x4005851C
GPIO_PORTA_AHB_LOCK_R EQU 0x40058520
GPIO_PORTA_AHB_CR_R EQU 0x40058524
GPIO_PORTA_AHB_AMSEL_R EQU 0x40058528
GPIO_PORTA_AHB_PCTL_R EQU 0x4005852C
GPIO_PORTA_AHB_ADCCTL_R EQU 0x40058530
GPIO_PORTA_AHB_DMACTL_R EQU 0x40058534
GPIO_PORTA_AHB_SI_R EQU 0x40058538
GPIO_PORTA_AHB_DR12R_R EQU 0x4005853C
GPIO_PORTA_AHB_WAKEPEN_R EQU 0x40058540
GPIO_PORTA_AHB_WAKELVL_R EQU 0x40058544
GPIO_PORTA_AHB_WAKESTAT_R EQU 0x40058548
GPIO_PORTA_AHB_PP_R EQU 0x40058FC0
GPIO_PORTA_AHB_PC_R EQU 0x40058FC4
GPIO_PORTA               	EQU    2_1
; PORT B
GPIO_PORTB_AHB_DATA_BITS_R EQU 0x40059000
GPIO_PORTB_AHB_DATA_R EQU 0x400593FC
GPIO_PORTB_AHB_DIR_R EQU 0x40059400
GPIO_PORTB_AHB_IS_R EQU 0x40059404
GPIO_PORTB_AHB_IBE_R EQU 0x40059408
GPIO_PORTB_AHB_IEV_R EQU 0x4005940C
GPIO_PORTB_AHB_IM_R EQU 0x40059410
GPIO_PORTB_AHB_RIS_R EQU 0x40059414
GPIO_PORTB_AHB_MIS_R EQU 0x40059418
GPIO_PORTB_AHB_ICR_R EQU 0x4005941C
GPIO_PORTB_AHB_AFSEL_R EQU 0x40059420
GPIO_PORTB_AHB_DR2R_R EQU 0x40059500
GPIO_PORTB_AHB_DR4R_R EQU 0x40059504
GPIO_PORTB_AHB_DR8R_R EQU 0x40059508
GPIO_PORTB_AHB_ODR_R EQU 0x4005950C
GPIO_PORTB_AHB_PUR_R EQU 0x40059510
GPIO_PORTB_AHB_PDR_R EQU 0x40059514
GPIO_PORTB_AHB_SLR_R EQU 0x40059518
GPIO_PORTB_AHB_DEN_R EQU 0x4005951C
GPIO_PORTB_AHB_LOCK_R EQU 0x40059520
GPIO_PORTB_AHB_CR_R EQU 0x40059524
GPIO_PORTB_AHB_AMSEL_R EQU 0x40059528
GPIO_PORTB_AHB_PCTL_R EQU 0x4005952C
GPIO_PORTB_AHB_ADCCTL_R EQU 0x40059530
GPIO_PORTB_AHB_DMACTL_R EQU 0x40059534
GPIO_PORTB_AHB_SI_R EQU 0x40059538
GPIO_PORTB_AHB_DR12R_R EQU 0x4005953C
GPIO_PORTB_AHB_WAKEPEN_R EQU 0x40059540
GPIO_PORTB_AHB_WAKELVL_R EQU 0x40059544
GPIO_PORTB_AHB_WAKESTAT_R EQU 0x40059548
GPIO_PORTB_AHB_PP_R EQU 0x40059FC0
GPIO_PORTB_AHB_PC_R EQU 0x40059FC4
GPIO_PORTB EQU 2_10
; PORT P
GPIO_PORTP_AHB_DATA_BITS_R EQU 0x40065000
GPIO_PORTP_AHB_DATA_R EQU 0x400653FC
GPIO_PORTP_AHB_DIR_R EQU 0x40065400
GPIO_PORTP_AHB_IS_R EQU 0x40065404
GPIO_PORTP_AHB_IBE_R EQU 0x40065408
GPIO_PORTP_AHB_IEV_R EQU 0x4006540C
GPIO_PORTP_AHB_IM_R EQU 0x40065410
GPIO_PORTP_AHB_RIS_R EQU 0x40065414
GPIO_PORTP_AHB_MIS_R EQU 0x40065418
GPIO_PORTP_AHB_ICR_R EQU 0x4006541C
GPIO_PORTP_AHB_AFSEL_R EQU 0x40065420
GPIO_PORTP_AHB_DR2R_R EQU 0x40065500
GPIO_PORTP_AHB_DR4R_R EQU 0x40065504
GPIO_PORTP_AHB_DR8R_R EQU 0x40065508
GPIO_PORTP_AHB_ODR_R EQU 0x4006550C
GPIO_PORTP_AHB_PUR_R EQU 0x40065510
GPIO_PORTP_AHB_PDR_R EQU 0x40065514
GPIO_PORTP_AHB_SLR_R EQU 0x40065518
GPIO_PORTP_AHB_DEN_R EQU 0x4006551C
GPIO_PORTP_AHB_LOCK_R EQU 0x40065520
GPIO_PORTP_AHB_CR_R EQU 0x40065524
GPIO_PORTP_AHB_AMSEL_R EQU 0x40065528
GPIO_PORTP_AHB_PCTL_R EQU 0x4006552C
GPIO_PORTP_AHB_ADCCTL_R EQU 0x40065530
GPIO_PORTP_AHB_DMACTL_R EQU 0x40065534
GPIO_PORTP_AHB_SI_R EQU 0x40065538
GPIO_PORTP_AHB_DR12R_R EQU 0x4006553C
GPIO_PORTP_AHB_WAKEPEN_R EQU 0x40065540
GPIO_PORTP_AHB_WAKELVL_R EQU 0x40065544
GPIO_PORTP_AHB_WAKESTAT_R EQU 0x40065548
GPIO_PORTP_AHB_PP_R EQU 0x40065FC0
GPIO_PORTP_AHB_PC_R EQU 0x40065FC4
GPIO_PORTP EQU 8192

; PORT Q
GPIO_PORTQ_AHB_DATA_BITS_R EQU 0x40066000
GPIO_PORTQ_AHB_DATA_R EQU 0x400663FC
GPIO_PORTQ_AHB_DIR_R EQU 0x40066400
GPIO_PORTQ_AHB_IS_R EQU 0x40066404
GPIO_PORTQ_AHB_IBE_R EQU 0x40066408
GPIO_PORTQ_AHB_IEV_R EQU 0x4006640C
GPIO_PORTQ_AHB_IM_R EQU 0x40066410
GPIO_PORTQ_AHB_RIS_R EQU 0x40066414
GPIO_PORTQ_AHB_MIS_R EQU 0x40066418
GPIO_PORTQ_AHB_ICR_R EQU 0x4006641C
GPIO_PORTQ_AHB_AFSEL_R EQU 0x40066420
GPIO_PORTQ_AHB_DR2R_R EQU 0x40066500
GPIO_PORTQ_AHB_DR4R_R EQU 0x40066504
GPIO_PORTQ_AHB_DR8R_R EQU 0x40066508
GPIO_PORTQ_AHB_ODR_R EQU 0x4006650C
GPIO_PORTQ_AHB_PUR_R EQU 0x40066510
GPIO_PORTQ_AHB_PDR_R EQU 0x40066514
GPIO_PORTQ_AHB_SLR_R EQU 0x40066518
GPIO_PORTQ_AHB_DEN_R EQU 0x4006651C
GPIO_PORTQ_AHB_LOCK_R EQU 0x40066520
GPIO_PORTQ_AHB_CR_R EQU 0x40066524
GPIO_PORTQ_AHB_AMSEL_R EQU 0x40066528
GPIO_PORTQ_AHB_PCTL_R EQU 0x4006652C
GPIO_PORTQ_AHB_ADCCTL_R EQU 0x40066530
GPIO_PORTQ_AHB_DMACTL_R EQU 0x40066534
GPIO_PORTQ_AHB_SI_R EQU 0x40066538
GPIO_PORTQ_AHB_DR12R_R EQU 0x4006653C
GPIO_PORTQ_AHB_WAKEPEN_R EQU 0x40066540
GPIO_PORTQ_AHB_WAKELVL_R EQU 0x40066544
GPIO_PORTQ_AHB_WAKESTAT_R EQU 0x40066548
GPIO_PORTQ_AHB_PP_R EQU 0x40066FC0
GPIO_PORTQ_AHB_PC_R EQU 0x40066FC4
GPIO_PORTQ EQU 16384

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo		
		EXPORT PortA_Output			; Permite chamar PortA_Output de outro arquivo
		EXPORT PortQ_Output			; Permite chamar PortQ_Output de outro arquivo
		EXPORT GPIOPortJ_Handler

;--------------------------------------------------------------------------------
; Função GPIO_Init
; Parâmetro de entrada: Não tem
; Parâmetro de saída: Não tem
GPIO_Init
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; após isso verificar no PRGPIO se a porta está pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		;Carrega o endereço do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTN                 ;Seta o bit da porta N
			ORR     R1, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
			ORR		R1, #GPIO_PORTA                 ;Seta o bit da porta A, fazendo com OR
			ORR     R1, #GPIO_PORTQ					;Seta o bit da porta Q, fazendo com OR
            STR     R1, [R0]						;Move para a memória os bits das portas no endereço do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			;Carrega o endereço do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  LDR     R1, [R0]						;Lê da memória o conteúdo do endereço do registrador
			MOV     R2, #GPIO_PORTN                 ;Seta os bits correspondentes às portas para fazer a comparação
			ORR     R2, #GPIO_PORTJ                 ;Seta o bit da porta J, fazendo com OR
			ORR		R1, #GPIO_PORTA                 ;Seta o bit da porta A, fazendo com OR
			ORR     R1, #GPIO_PORTQ					;Seta o bit da porta Q, fazendo com OR
            TST     R1, R2							;Testa o R1 com R2 fazendo R1 & R2
            BEQ     EsperaGPIO					    ;Se o flag Z=1, volta para o laço. Senão continua executando
 
; 2. Limpar o AMSEL para desabilitar a analógica
            MOV     R1, #0x00						;Colocar 0 no registrador para desabilitar a função analógica
            LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R     ;Carrega o R0 com o endereço do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da memória
            LDR     R0, =GPIO_PORTN_AMSEL_R			;Carrega o R0 com o endereço do AMSEL para a porta N
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da memória
            LDR     R0, =GPIO_PORTA_AHB_AMSEL_R			;Carrega o R0 com o endereço do AMSEL para a porta A
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da memória
            LDR     R0, =GPIO_PORTQ_AHB_AMSEL_R			;Carrega o R0 com o endereço do AMSEL para a porta Q
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da memória
 
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTJ_AHB_PCTL_R		;Carrega o R0 com o endereço do PCTL para a porta J
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da memória
            LDR     R0, =GPIO_PORTA_AHB_PCTL_R		;Carrega o R0 com o endereço do PCTL para a porta A
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da memória
            LDR     R0, =GPIO_PORTQ_AHB_PCTL_R		;Carrega o R0 com o endereço do PCTL para a porta Q
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da memória
            LDR     R0, =GPIO_PORTN_PCTL_R      	;Carrega o R0 com o endereço do PCTL para a porta N
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta N da memória
; 4. DIR para 0 se for entrada, 1 se for saída
            LDR     R0, =GPIO_PORTN_DIR_R			;Carrega o R0 com o endereço do DIR para a porta N
			MOV     R1, #2_0011						;PN1 e PN0
            STR     R1, [R0]						;Guarda no registrador
			; O certo era verificar os outros bits da PJ para não transformar entradas em saídas desnecessárias
            LDR     R0, =GPIO_PORTJ_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com saída
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da memória
			LDR     R0, =GPIO_PORTQ_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta Q
            MOV     R1, #2_00001111               	;PQ0, PQ1, PQ2, PQ3 para LEDs
			LDR     R0, =GPIO_PORTQ_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta A
            MOV     R1, #2_11110000               	;PA4, PA5, PA6, PA7 para LEDs
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem função alternativa
            MOV     R1, #0x00						;Colocar o valor 0 para não setar função alternativa
            LDR     R0, =GPIO_PORTN_AFSEL_R			;Carrega o endereço do AFSEL da porta N
            STR     R1, [R0]						;Escreve na porta
            LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
            LDR     R0, =GPIO_PORTA_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta A
            STR     R1, [R0]                        ;Escreve na porta
            LDR     R0, =GPIO_PORTQ_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta Q
            STR     R1, [R0]                        ;Escreve na porta
; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTN_DEN_R			    ;Carrega o endereço do DEN
            MOV     R1, #2_00000011                     ;N0 e N1
            STR     R1, [R0]							;Escreve no registrador da memória funcionalidade digital 
 
            LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endereço do DEN
			MOV     R1, #2_00000011                     ;J0 e J1
            STR     R1, [R0]                            ;Escreve no registrador da memória funcionalidade digital
			
            LDR     R0, =GPIO_PORTA_AHB_DEN_R			;Carrega o endereço do DEN
            MOV     R1, #2_11110000                     ;Ativa os pinos como I/O Digital
            STR     R1, [R0]							;Escreve no registrador da memória funcionalidade digital 
 
 
			LDR     R0, =GPIO_PORTQ_AHB_DEN_R			;Carrega o endereço do DEN
			MOV     R1, #2_00001111                     ;Ativa os pinos como I/O Digital      
            STR     R1, [R0]                            ;Escreve no registrador da memória funcionalidade digital
			
			
; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endereço do PUR para a porta J
			MOV     R1, #2_11							;Habilitar funcionalidade digital de resistor de pull-up 
            STR     R1, [R0]							;Escreve no registrador da memória do resistor de pull-up


;Interrupções
; 8. Desabilitar a interrupção no registrador IM
			LDR     R0, =GPIO_PORTJ_AHB_IM_R			;Carrega o endereço do IM para a porta J
			MOV     R1, #2_00							;Desabilitar as interrupções  
            STR     R1, [R0]							;Escreve no registrador
            
; 9. Configurar o tipo de interrupção por borda no registrador IS
			LDR     R0, =GPIO_PORTJ_AHB_IS_R			;Carrega o endereço do IS para a porta M
			MOV     R1, #2_00							;Por Borda  
            STR     R1, [R0]							;Escreve no registrador

; 10. Configurar  borda única no registrador IBE
			LDR     R0, =GPIO_PORTJ_AHB_IBE_R 			;Carrega o endereço do IBE para a porta M
			MOV     R1, #2_00							;Borda Única  
            STR     R1, [R0]							;Escreve no registrador
; 11. Configurar  borda de descida (botão pressionado) no registrador IEV
			LDR     R0, =GPIO_PORTJ_AHB_IEV_R			;Carrega o endereço do IEV para a porta M
			MOV     R1, #2_00							;Borda Única  
            STR     R1, [R0]							;Escreve no registrador
			
; 13. Habilitar a interrupção no registrador IM
			LDR     R0, =GPIO_PORTJ_AHB_IM_R				;Carrega o endereço do IM para a porta M
			MOV     R1, #2_11							;Habilitar as interrupções  
            STR     R1, [R0]							;Escreve no registrador
			
	
;Interrupção número 72      
; 15. Habilitar a interrupção no NVIC
			LDR     R0, =NVIC_EN1_R           			;Carrega o do NVIC para o grupo que tem o M entre 64 e 95
			MOV     R1, #1
			LSL     R1, #19								;Desloca 8 bits para a esquerda já que o M é a interrupção do bit 19 no EN1
            STR     R1, [R0]							;Escreve no registrador da memória

; 14. Setar a prioridade no NVIC
			LDR     R0, =NVIC_PRI12_R           		;Carrega o do NVIC para o grupo que tem o M entre 72 e 75
			MOV     R1, #5  		                    ;Prioridade 3
			LSL     R1, R1, #29							;Desloca 5 bits para a esquerda já que o M é o primeiro byte do PRI18
            STR     R1, [R0]							;Escreve no registrador da memória

			BX  LR
			
; Função ISR GPIOPortJ_Handler (Tratamento da interrupção)
GPIOPortJ_Handler
	LDR R1, =GPIO_PORTJ_AHB_MIS_R
    LDR R0, [R1]                 ; R0 agora contém o status (bit 0 = PJ0, bit 1 = PJ1) [2]
	; ACK
	LDR 	R1, =GPIO_PORTJ_AHB_ICR_R
	STR 	R0, [R1]
	
Verifica_SW
	CMP	R0, #2_00000010          ;Verifica se somente a chave SW1 está pressionada
	ITE EQ
	ADDEQ R6, R6, #1
	SUBNE R6, R6, #1

	CMP R6, #10
	IT LT
	MOVLT R6, #10
	
	CMP R6, #99
	IT GT
	MOVGT R6, #99
	
    BX LR     

; -------------------------------------------------------------------------------
; Função PortN_Output
; Parâmetro de entrada: R0 --> se os BIT1 e BIT0 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortN_Output
	LDR	R1, =GPIO_PORTN_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00000011                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111100
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta N o barramento de dados dos pinos N1 e N0
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Função PortA_Output
; Parâmetro de entrada: R0 --> se os BIT5-6 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortA_Output
	LDR	R1, =GPIO_PORTA_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11110000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Função PortQ_Output
; Parâmetro de entrada: R0 --> se os BIT3-0 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortQ_Output
	LDR	R1, =GPIO_PORTQ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00001111                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00001111
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	
	

    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo