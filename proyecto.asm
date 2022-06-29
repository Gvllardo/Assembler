title conversion hexadecimal a binario
dosseg
.model small
.stack 100h
.data

msgstar		db 0dh,0ah,0dh,0ah,"*******************************************************************************",0dh,0ah,"$"
msgintro	db "                                     PROGRAMA",0dh,0ah,
				   "                    CONVERSION DE UN CARACTER HEXADECIMAL A BINARIO","$"
msginput	db  0dh,0ah,"Input deL HEXADECIMAL(MAXIMO FF) :",0dh,0ah,"$"
print		dw	0
count		dw	0
num		dw	0

.code
main	proc
		mov ax,@data
		mov ds,ax
		
		mov ax,0
		mov bx,0
		mov cx,0
		mov dx,0
		mov print,0	; resetear todos los valores del programa para asegurarse que el cáclculo sea correcto

		mov count,0	; despues que el usuario desee repetir el proceso
		mov num,0
		
		mov dx,offset msgstar ;mostrar en pantalla mensaje de inicio
		mov ah,9
		int 21h
		
		mov dx,offset msgintro ;mostrar en pantalla mensaje de inicio
		mov ah,9
		int 21h
		
		mov dx,offset msgstar ;mostrar en pantalla mensaje de inicio
		mov ah,9
		int 21h
		
		
		mov	dx,offset msginput ;mostrar en pantalla el mensaje de input
		mov ah,9
		int 21h
		
		mov cx,-1 ; asignar -1 a cx para que actue como contador
		
	

input:	mov ah, 00h
		int 16h
		cmp ah, 1ch
		je exit

number: cmp al, '0'
		jb input
		cmp al, '9'
		ja uppercase
		sub al, 30h
		call process
		jmp input

uppercase: 	cmp al, 'A'
	   		 jb input
		    cmp al, 'F'
			ja lowercase
			sub al, 37h
			call process
			jmp input

lowercase: 	cmp al, 'a'
			jb input
			cmp al, 'f'
			ja input
			sub al, 57h
			call process
			jmp input

			loop input

process: 	mov ch, 4
			mov cl, 3
			mov bl, al

convert:	mov al, bl
			ror al, cl
			and al, 01
			add al, 30h

			mov ah, 02h
			mov dl, al
			int 21h

			dec cl
			dec ch
			jnz convert

			mov dl, 20h
			int 21h
ret

exit:
int 20h

	
	
main EndP
end main
