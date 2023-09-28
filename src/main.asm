org 0x7C00
bits 16

;The main Function
main:
	hlt


.halt:
	jmp .halt

;$ - means the current location
;$$ means the address of start of the section(or sector)
; therefore after defining all this, the current location is at the end of prograam, and $-$$ gives the length of the program

times 510-($-$$) db 0 ; times is used for
dw 0AA55h
