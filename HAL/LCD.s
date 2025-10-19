;========================================================
; LCD HAL provides initialization, clear, print character, and print string functions
;========================================================

;-------------------------------
; LCD Initialization
;-------------------------------
; Sets up 8-bit mode, 2-line display, 5x8 font
; Turns on display, cursor, and blink
; Sets cursor increment mode
LCD_init:
  	PHA
	JSR LCD_wait        ; wait until LCD is ready
  	LDA #%00111000      ; function set: 8-bit, 2-line, 5x8 font
  	STA LCDCMD			; send command to the LCD
	JSR LCD_wait
  	LDA #%00001110      ; Display control: display ON, cursor ON, blink OFF
  	STA LCDCMD
	JSR LCD_wait
  	LDA #%00000110      ; entry mode set: increment cursor, no display shift
  	STA LCDCMD
  	PLA
	RTS
	
;-------------------------------
; Print a single character
; Expects: A contains character to print
LCD_char:
    JSR LCD_wait        ; wait until LCD is ready
    STA LCDDATA         ; write character to LCD
    RTS                 ; return

;-------------------------------
; Wait until LCD is ready
; Uses the busy flag (assumes BMI checks it)
LCD_wait:
  	PHA
LCD_busy:
	LDA LCDCMD          ; read command register
  	BMI LCD_busy        ; if busy flag set, loop
  	PLA					; not busy, return
  	RTS

;-------------------------------
; Clear the LCD display
LCD_clear:
  	PHA
    JSR LCD_wait      	; wait until LCD is ready
  	LDA #%00000001      ; clear display command
  	STA LCDCMD
  	PLA
  	RTS

;-------------------------------
; Print a null-terminated string
; Expects: LCD_sptr points to string in memory
;-------------------------------
LCD_string:
	PHA
	PHY
    LDY #0              ; string index (offset)
LCD_print_loop:
    JSR LCD_wait      	; wait until LCD is ready
    LDA (LCD_sptr),y    ; load byte from string (pointer + Y)
    BEQ LCD_done        ; if null terminator, stop
    STA LCDDATA         ; output to LCD
    INY                 ; next character
    JMP LCD_print_loop  ; repeat
LCD_done:
	PLY
	PLA
    RTS
