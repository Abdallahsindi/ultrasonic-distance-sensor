
_main:

;E,27 :: 		
;E,30 :: 		
	MOVLW      16
	MOVWF      TRISB+0
;E,31 :: 		
	CLRF       PORTB+0
;E,33 :: 		
	CLRF       TRISD+0
;E,34 :: 		
	CLRF       PORTD+0
;E,38 :: 		
	CALL       _Lcd_Init+0
;E,39 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;E,40 :: 		
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;E,42 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_InterFace_32Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;E,43 :: 		
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_InterFace_32Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;E,44 :: 		
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;E,45 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;E,52 :: 		
	MOVLW      16
	MOVWF      T1CON+0
;E,55 :: 		
L_main1:
;E,58 :: 		
	CLRF       TMR1H+0
;E,59 :: 		
	CLRF       TMR1L+0
;E,62 :: 		
	BSF        PORTB+0, 0
;E,63 :: 		
	MOVLW      6
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	NOP
;E,64 :: 		
	BCF        PORTB+0, 0
;E,67 :: 		
L_main4:
	BTFSC      PORTB+0, 4
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;E,70 :: 		
	BSF        T1CON+0, 0
;E,73 :: 		
L_main6:
	BTFSS      PORTB+0, 4
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;E,76 :: 		
	BCF        T1CON+0, 0
;E,79 :: 		
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _distance+0
	MOVF       R0+1, 0
	MOVWF      _distance+1
;E,83 :: 		
	MOVLW      58
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _distance+0
	MOVF       R0+1, 0
	MOVWF      _distance+1
;E,85 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;E,87 :: 		
	MOVLW      0
	SUBWF      _distance+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      2
	SUBWF      _distance+0, 0
L__main15:
	BTFSS      STATUS+0, 0
	GOTO       L_main10
	MOVF       _distance+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVF       _distance+0, 0
	SUBLW      144
L__main16:
	BTFSS      STATUS+0, 0
	GOTO       L_main10
L__main13:
;E,89 :: 		
	MOVF       _distance+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _distance+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;E,90 :: 		
	MOVLW      _txt+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;E,92 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_InterFace_32Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;E,93 :: 		
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;E,94 :: 		
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_InterFace_32Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;E,95 :: 		
	GOTO       L_main11
L_main10:
;E,97 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_InterFace_32Project+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;E,98 :: 		
L_main11:
;E,100 :: 		
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
;E,101 :: 		
	GOTO       L_main1
;E,102 :: 		
L_end_main:
	GOTO       $+0
; end of _main
