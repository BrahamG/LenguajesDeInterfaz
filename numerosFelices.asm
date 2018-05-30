segment .data
	msg1 db "Numero", 0xA,0xD
	len1 equ $- msg1
	msg2 db "Es feliz :)", 0xA,0xD
	len2 equ $- msg2
	msg3 db "",0xA,0xD 
	len3 equ $- msg3
	msg4 db "No es feliz :("
	len4 equ $- msg4
	arre db 0
	len equ $-arre
segment .bss
	datos resb 4
section  .text
	global _start
	%MACRO PRINT 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
	%ENDMACRO
	%MACRO SALTO 1
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, len3
	int 0x80
	%ENDMACRO
_start:  
	PRINT msg1,len1
;Inicia la lectura
	mov eax, 3
	mov ebx, 0
	mov ecx, datos
	mov edx, 2
	int 80h

	mov eax, [datos+0]
	sub eax, 48
	mov ebx, [datos+1]
	sub ebx, 48
	mov edi, 10
	mul edi
	add eax,ebx
	mov [arre+0], eax
;Termina la lectura
	mov ebp,arre
ciclo:
	mov ah,0
	mov al, [ebp+0]
	mov dl, 100
	div dl
	mov [datos+0], al
	mov [datos+1], ah
	mov ah,0
	mov al,[datos+1]
	mov dl,10
	div dl
	mov [datos+1], al
	mov [datos+2], ah

	mov ax,[datos+0]
	mul ax ;ax=ax*ax
	mov cx,ax

	mov ax,[datos+1]
	mul ax ;ax=ax*ax
	mov bx,ax

	mov ax,[datos+2]
	mul ax ;ax=ax*ax

	add ax,bx
	add ax,cx
	mov[ebp+0],ax
	;
	mov ah,0
	mov al, [ebp+0]
	mov dl, 100       ;mov dl,100
	div dl
	add al, '0'
	mov [datos+0], al ;centena
	mov [datos+1],ah
	mov ah,0
	mov al,[datos+1]
	mov dl,10
	div dl
	add al,'0'
	mov [datos+1],al  ;decena
	add ah, '0'
	mov [datos+2], ah ;unidad 

	mov ax,[datos+2]
	sub ax,'0'
	cmp ax,9
	je noesfeliz

	PRINT datos,3
	SALTO 1	
endciclo:
	mov ax,[datos+2]
	sub ax,'0'
	cmp ax, 1
	jne ciclo
	PRINT msg2,len2
	jmp salir
noesfeliz:
	PRINT msg4,len4
	SALTO 1
salir:
	mov eax, 1
	xor ebx, ebx
	int 0x80