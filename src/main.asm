org 0x7C00 ;This is memory address where BIOS will be looking for the
bits 16



%define ENDL 0x0D, 0x0A

start:
	jmp main



;Prints a string to the screen.
;Params:
;	-ds:si points to the string

puts:
	; save registers we will modify
	push si
	push ax

.loop:
	lodsb        ;loads next character in al
	or al,al	;verify if next character is Null (taking bitwise or of al with al to check for nullability)
	jz .done

	mov ah,0x0e ;call bios interrupt
	int 0x10

	jmp .loop

.done:
	pop ax
	pop si
	ret



main:
	;data segments setup
	mov ax, 0 		;can't write to ds/es directly
	mov ds, ax
	mov es, ax

	;setup stack
	mov ss, ax
	mov sp, 0x7C00 ; stack grows downwards where we are loaded in memory

	;PRINT MESSAGE
	mov si , msg_hello
	call puts




.halt:
	jmp .halt

msg_hello: db 'Hello World!',ENDL,0

;$ - means the current location
;$$ means the address of start of the section(or sector)
; therefore after defining all this, the current location is at the end of prograam, and $-$$ gives the length of the program

times 510-($-$$) db 0 ; times is used for
dw 0AA55h
