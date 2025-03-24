INCLUDE Irvine32.inc
.data
   slotCharacters BYTE "0$7", 0
   randomNumber DWORD ?
   selectedChar BYTE ?

.code
main PROC
   call RandomNumberGeneration

   lea edx, slotCharacters
   mov ecx, randomNumber
   add edx, ecx
   mov al, [edx]
   mov selectedChar, al

   mov dl, selectedChar
   call WriteChar

   exit
main ENDP

RandomNumberGeneration PROC 
   call Randomize

   mov eax, 3
   call RandomRange
   mov randomNumber, eax
   ret 
RandomNumberGeneration ENDP
ENd main