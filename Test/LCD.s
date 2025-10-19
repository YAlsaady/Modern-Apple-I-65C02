	.org $8000
	.org $E000

RESET:
	JSR LCD_init
	JSR LCD_clear
    LDA #<string
    STA LCD_sptr 		; low byte of address
    LDA #>string
    STA LCD_sptr+1      ; high byte of address
	JSR LCD_string

loop:
	JMP loop

	.include "../defines.s"
	.include "../HAL/LCD.s"

string: 
	.asciiz "Hello, World!!!"

NMI_HANDLER:
	RTI

IRQ_HANDLER:
	RTI

	.org $FFFA
	.word   NMI_HANDLER     ; NMI vector
    .word   RESET           ; RESET vector
    .word   IRQ_HANDLER     ; IRQ vector

