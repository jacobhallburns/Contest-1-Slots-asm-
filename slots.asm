INCLUDE Irvine32.inc
.data
   slotCharacters BYTE "0$7", 0
   randomNumber DWORD ?
   slot1 BYTE ?
   slot2 BYTE ?
   slot3 BYTE ?

.code
main PROC

	call Randomize
   ; Generate the result of slot 1
   call RandomNumberGeneration
   lea edx, slotCharacters
   mov ecx, randomNumber
   add edx, ecx
   mov al, [edx]
   mov slot1, al

   ; Generate the result of slot 2
   call RandomNumberGeneration
   lea edx, slotCharacters
   mov ecx, randomNumber
   add edx, ecx
   mov al, [edx]
   mov slot2, al

   ; Generate the result of slot 3
   call RandomNumberGeneration
   lea edx, slotCharacters
   mov ecx, randomNumber
   add edx, ecx
   mov al, [edx]
   mov slot3, al

   exit
main ENDP

RandomNumberGeneration PROC 
   mov eax, 3
   call RandomRange
   mov randomNumber, eax
   ret 
RandomNumberGeneration ENDP
ENd main