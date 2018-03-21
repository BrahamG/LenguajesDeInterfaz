section .data

msg db "De la integral \int_0^2 (4+3x-3x^2) dx",0xA,0xD
len equ $ - msg
msg1 db "El resultado es: ",0xA,0xD
len1 equ $ - msg1 
msg2 db " ",0xA,0xD
len2 equ $ - msg2 

section .bss
var1 resb 1
num2 resb 1
resr resb 1
resp resb 1
aux resb 1
;.............
section .text
	global _start
_start:
	;---------------<imprime los mensajes---------------------
;	mov eax, 4   
;	mov ebx, 1	 
;	mov ecx, msg 
;	mov edx, len 
;	int 0x80	
	mov eax, 4   
	mov ebx, 1	 
	mov ecx, msg1 
	mov edx, len1 
	int 0x80	

	mov eax, 4
	mov ebx, 2
	mov ecx, 2
	
	mul ebx
	add eax, '0'
	mov [var1], eax ;[var1]=8

	mov eax, 2
	mov ebx, eax

	mul ebx
	mov ebx, 3
	mul ebx
	add eax,'0'
	mov [num2],eax ;[num2]=12 ASCII 

	mov eax, [num2]
	sub eax, '0'
	mov ebx, 2
	mov edx, 0

	div ebx
	add eax, '0'
	mov [num2], eax ;[num2]=6

	mov eax, [var1] ;eax=8
	sub eax, '0'	
	mov ebx, [num2] ;ebx=6
	sub ebx, '0'

	add eax,ebx
	add eax,'0'
	mov [num2],eax ;[num2]=14 ASCII  <---------marcador

	mov eax,3
	mov ebx,3
	div ebx
	add eax,'0'
	mov [var1],eax ;[var1]=1 

	mov eax,2
	mov ebx,2

	mul ebx
	add eax,'0'
	mov [resr],eax
	
	mov eax, 2	
	mov ebx, [resr]
	sub ebx, '0'

	mul ebx
	add eax,'0'
	mov [resp],eax ;[resp]=8

	mov eax, [var1]
	sub eax, '0'	
	mov ebx, [resp]
	sub ebx, '0'

	mul ebx
	add eax,'0'
	mov [resr],eax  ;[resr]=8

	mov eax,14  ;Valor que obtiene [num2] en la parte de arriba en el marcador
	add eax,48

	;Ultima resta
	mov ebx,[resr]
	sub ebx,'0'
	sub eax,'0'
	sub eax,ebx
	add eax,'0'
	mov [num2],eax

	mov eax, 4   
	mov ebx, 1	 
	mov ecx, num2 
	mov edx, 1 
	int 0x80

	mov eax, 4  
	mov ebx, 1	
	mov ecx, msg2 
	mov edx, len2 
	int 0x80

	mov eax, 1   ; llama al sistema (sys_write)
	int 0x80	;lamada al sistema de interrucciones