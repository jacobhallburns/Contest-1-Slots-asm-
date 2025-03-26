INCLUDE Irvine32.inc
.data
   slotCharacters BYTE "0$7", 0
   randomNumber DWORD ?
   slot1 BYTE ?
   slot2 BYTE ?
   slot3 BYTE ?

   topMsg  BYTE "Press S to Spin", 0
   bar     BYTE "+-------------------------+", 0
   line    BYTE "|                         |", 0
   pay1    BYTE "0 - 0 points", 0
   pay2    BYTE "$ - 500 points", 0
   pay3    BYTE "7 - 700 points", 0

.code
main PROC

   call Clrscr

   ; Prints header/ insturctions
   mov edx, OFFSET topMsg
   mov ecx, 2
   call GotoxyAtLine
   call WriteString

   ; Prints top of box
   mov edx, OFFSET bar
   mov ecx, 4
   call GotoxyAtLine
   call WriteString

   ; Prints sides of box
   mov edx, OFFSET line
   mov ecx, 5
   call GotoxyAtLine
   call WriteString

   mov edx, OFFSET line
   mov ecx, 6
   call GotoxyAtLine
   call WriteString

   mov edx, OFFSET line
   mov ecx, 7
   call GotoxyAtLine
   call WriteString

   ; Prints bottom of box
   mov edx, OFFSET bar
   mov ecx, 8
   call GotoxyAtLine
   call WriteString

   ; Score info
   mov edx, OFFSET pay1
   mov ecx, 10
   call GotoxyAtLine
   call WriteString

   mov edx, OFFSET pay2
   mov ecx, 11
   call GotoxyAtLine
   call WriteString

   mov edx, OFFSET pay3
   mov ecx, 12
   call GotoxyAtLine
   call WriteString
    

  call Randomize

  ; Generates the result of slot 1
  call RandomNumberGeneration
  mov edx, OFFSET slotCharacters
  add edx, randomNumber
  mov al, [edx]
  mov slot1, al

  ; Generates the result of slot 2
  call RandomNumberGeneration
  call RandomNumberGeneration
  mov edx, OFFSET slotCharacters
  add edx, randomNumber
  mov al, [edx]
  mov slot2, al

  ; Generates the result of slot 3
  call RandomNumberGeneration
  call RandomNumberGeneration
  mov edx, OFFSET slotCharacters
  add edx, randomNumber
  mov al, [edx]
  mov slot3, al

   ; Prints first slot in the box
   mov dl, 12
   mov dh, 6
   call GotoxyXY
   mov dl, slot1
   call WriteChar

   ; Prints second slot in the box
   mov dl, 15
   mov dh, 6
   call GotoxyXY
   mov dl, slot2
   call WriteChar

   ; Prints third slot in the box
   mov dl, 18
   mov dh, 6
   call GotoxyXY
   mov dl, slot3
   call WriteChar

  call Crlf
  call Crlf

   exit
main ENDP

RandomNumberGeneration PROC 
   mov eax, 3
   call RandomRange
   mov randomNumber, eax
   ret 
RandomNumberGeneration ENDP

GotoxyAtLine PROC
   ; Assumes that edx = message and ecx = row
   push dx
   mov dh, cl        ; row
   mov dl, 2         ; column
   call Gotoxy
   pop dx
   ret
GotoxyAtLine ENDP

GotoxyXY PROC
   ; Assumes that dl = column (x) and dh = row (y)
   call Gotoxy
   ret
GotoxyXY ENDP

END main
