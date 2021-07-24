; Prototipo actividad 6
; Omar Eduardo Angarita Jimenez
; 79953510
; 202016893_1 | 23-julio-2021

.MODEL SMALL
.STACK 100h
.DATA
    Descrip 		DB 'Prototipo funcional. Seleccione la opcion que desee: $'
    opcion_1 		DB 10,13,'1. Imprimir el autor del progrma$'
    opcion_2 		DB 10,13,'2. Suma de dos numeros$'
    opcion_3 		DB 10,13,'3. Resta de dos numeros$'
    opcion_4 		DB 10,13,'4. Multiplicacion de dos numeros$'
    opcion_5 		DB 10,13,'5. Division de dos numeros$'
    opcion_6 		DB 10,13,'6. Salir de la aplicacion$'
    seleccione 		DB 10,13, 'Seleccione: $'

	insert_numero1 	DB 10,13,'Ingrese el primer numero: $'
	insert_numero2 	DB 10,13,'Ingrese el segundo numero: $'
	Fin				DB 10,13,'Fin del programa.$'
	suma      		DB 'La suma es: $'
	resta      		DB 'La resta es: $'
	multip  		DB 'La multiplicacion es: $'
	division   		DB 'La division es: $'
	retorno			DB 10,13, ' $'
	alerta   		DB 10,13,'Alerta: No es una opcion valida, seleccione del 1 al 6: $'
	error   		DB 10,13,'Error: No es un numero del 0 al 9, saliendo...$'

	nombre			DB 10,13,'Omar Eduardo Angarita Jimenez$'
	unad			DB 10,13,'CEAD Jose Acevedo y Gomez$'
	fecha			DB 10,13,'23-jul-2021$'

	val_ingresado1	DB 0
	val_ingresado2	DB 0
	res_mult		DB 0
	res_pot			DB 0
	resultado		DB 0
	seleccion		DB 0

.CODE
	_inicio: 
		mov ax,	@Data
		mov ds, ax
		
		mov dx, offset Descrip
		call _mensaje
		mov dx, offset retorno
		call _mensaje
		mov dx, offset opcion_1
		call _mensaje
		mov dx, offset opcion_2
		call _mensaje
		mov dx, offset opcion_3
		call _mensaje
		mov dx, offset opcion_4
		call _mensaje
		mov dx, offset opcion_5
		call _mensaje
		mov dx, offset opcion_6
		call _mensaje
        mov dx, offset retorno
		call _mensaje

	Seleccion_menu:
		mov dx, offset seleccione
		call _mensaje
		mov ah, 01  ; Detecta la seleccion del usuario
		int 21h
		sub al, 30h ; Convertimos a numero decimal
		mov seleccion, al
        call _selec_valida

        mov dx, offset retorno
		call _mensaje
		mov al, seleccion
        cmp al, 1
		je _autor
        cmp al, 2
		je _suma
        cmp al, 3
		je _resta
        cmp al, 4
		je _multi
        cmp al, 5
		je _div
        cmp al, 6
		je _positivo
        cmp al, 7
		je _final

	_autor:
		mov dx, offset nombre
		call _mensaje
		mov dx, offset unad
		call _mensaje
		mov dx, offset fecha
		call _mensaje
		jmp Seleccion_menu

	_suma:
		
		jmp Seleccion_menu
	_resta:
		jmp Seleccion_menu
	_multi:
		jmp Seleccion_menu
	_div:
		jmp Seleccion_menu
	_positivo:
		jmp Seleccion_menu

        jmp _final

    _adquirir_numeros proc
		mov dx, offset insert_numero1
		call _mensaje

		mov ah, 01  ; Solicita el primer numero
		int 21h
		
		sub al, 30h ; Convertimos a numero decimal
		mov val_ingresado1, al
		
		mov ax, 0
		mov cx, 0	; Limpiamos el registro
		mov dx, 0
		
		mov dx, offset insert_numero2
		call _mensaje
		
		mov ah, 01  ; Solicita el segundo numero
		int 21h

		sub al, 30h ; Convertimos a numero decimal
		mov val_ingresado2, al
	ret
	_adquirir_numeros endp
	
    _selec_valida proc
		; Si son menores que cero lanza una Alerta
		cmp al, 0
		jle _warning
		; Si son mayores que seis lanza una Alerta
		add al, 48
		cmp al, 55
		jg _warning
	ret			; Si son numeros se continua
	_selec_valida endp 

    _es_numero proc
		mov al, val_ingresado1       
		mov ah, val_ingresado2
		; Si son menores que cero lanza una excepcion
		cmp al, 0
		jl _error
		cmp ah, 0
		jl _error
		; Si son mayores que nueve lanza una excepcion
		add ah, 48
		cmp ah, 57
		jg _error
		add al, 48
		cmp al, 57
		jg _error
	ret			; Si son numeros se continua
	_es_numero endp 

	_mensaje proc ; Imprime los mensajes en Consola
        mov ah, 09h
		int 21h
        ret
	_mensaje endp

    _warning:
		mov dx, offset alerta
        call _mensaje
        mov dx, offset retorno
		call _mensaje
		jmp Seleccion_menu
	
	_error:
		mov dx, offset error
        call _mensaje
		jmp Seleccion_menu
	
	_final:
		mov dx, offset retorno
		call _mensaje
		mov dx, offset Fin
		call _mensaje
END 