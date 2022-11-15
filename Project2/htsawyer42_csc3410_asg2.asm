.386
.model flat, stdcall
.STACK 4096
exitprocess proto, dWordexitCode : dword
.DATA
	mynum DWORD 7
	mynum_factorial DWORD 0
	mynum_flags DWORD 0
	factorial_save DWORD 0
	bp_storage DWORD 0
.code



neg_case:
		mov mynum_factorial, -1
		jmp move_exit
		ret
zero_case:
		mov mynum_factorial, 1
		jmp move_exit
		ret

factorial PROC

	push ebp	;save base pointer

	mov ebp, esp
	mov eax,[ebp + 8]

		cmp eax, 0
		je neg_nested	;see if arguement passed is 0

		mov ebx, mynum_factorial
		
		mul ebx

		mov mynum_factorial, eax

		mov eax,[ebp + 8]
		sub eax, 1

		push mynum_factorial
		push eax


		call factorial

		pop eax
		pop eax

		pop ebp
		ret
factorial ENDP
neg_nested:		;manage the base case ,0
		pop ebp
		ret


isPrime PROC
	push ebp
	mov ebp, esp

	mov eax, mynum
	mov ebx, [ebp + 8]
	sub ebx, 1

	cmp ebx, 0
	je prime
	cmp ebx, 1
	je prime

	mov edx, 0
	div ebx
	cmp edx, 0

	je not_prime

	push ebx

	call isPrime


	pop eax

	pop ebp
	ret

	not_prime:
		pop ebp
		ret

	prime:
		pop ebp
		or mynum_flags, 1
		ret
isPrime ENDP
	pop ebp

isEven PROC
	push ebp
	mov ebp, esp
	mov eax, mynum
	and eax, 00000001H

	cmp eax, 0

	je Even_FlagSet


	pop ebp
	ret
	Even_FlagSet:
		or mynum_flags, 10b
		pop ebp
		ret
isEven ENDP
main proc
		mov eax, mynum

		test eax,eax	

		je zero_case	;manage the situation if mynum is 0 or negative
		jl neg_case

		mov eax, 0

		mov mynum_factorial, 1	;send both arguements to stack.
		push mynum_factorial
		push mynum


		call factorial

		mov eax, 1

		push mynum

		call isPrime


		call isEven	
			


	
	jmp move_exit
	
main endp
move_exit:
		mov eax,0
end main 