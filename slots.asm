INCLUDE Irvine32.inc
.data
   slotCharacters BYTE "0$7", 0
   randomNumber DWORD ?
   slot1 BYTE ?
   slot2 BYTE ?
   slot3 BYTE ?

   topMsg  BYTE "Press ENTER to Spin", 0
   bar     BYTE "+-------------------------+", 0
   line    BYTE "|                         |", 0
   pay1    BYTE "0 - 0 points", 0
   pay2    BYTE "$ - 500 points", 0
   pay3    BYTE "7 - 700 points", 0
   score   BYTE "Your Score: ", 0
   playAgainMsg BYTE "Play Again? (Play - P, Quit - Q): ", 0

.code
main PROC

GameLoop:

   call Clrscr
   call Randomize

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

   ; Prints score info
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
    

  ; Gets random character for slot 1
   mov eax, 3
   call RandomRange
   mov ebx, OFFSET slotCharacters
   add ebx, eax
   mov al, [ebx]
   mov slot1, al

   ; Slot 2
   mov eax, 3
   call RandomRange
   mov ebx, OFFSET slotCharacters
   add ebx, eax
   mov al, [ebx]
   mov slot2, al

   ; Slot 3
   mov eax, 3
   call RandomRange
   mov ebx, OFFSET slotCharacters
   add ebx, eax
   mov al, [ebx]
   mov slot3, al

   ; Prints first blank slot in the box
    mov dl, 12
    mov dh, 6
    call GotoxyXY
    mov al, "-"
    call WriteChar

    ; Prints second blank slot in the box
    mov dl, 15
    mov dh, 6
    call GotoxyXY
    mov al, "-"  
    call WriteChar

    ; Prints third blank slot in the box
    mov dl, 18
    mov dh, 6
    call GotoxyXY
    mov al, "-"  
    call WriteChar

   ; Waits for user to hit Enter
   WaitForSpin:
      call ReadChar
      cmp al, 0Dh       ; Check if enter was pressed
      jne WaitForSpin   ; If not, keep waiting

    ; Spin animation for slot 1
    mov ecx, 15     ; 15 loops
    SpinLoop:
        mov eax, 3
        call RandomRange
        mov ebx, OFFSET slotCharacters
        add ebx, eax
        mov al, [ebx]
        mov dl, 12
        mov dh, 6
        call GotoxyXY
        call WriteChar
        call Delay      ; Delay so animation doesn't play too quick
        loop SpinLoop

    ; Prints first slot in the box
    mov dl, 12
    mov dh, 6
    call GotoxyXY
    mov al, slot1    
    call WriteChar

    ; Spin animation for slot 2
    mov ecx, 20     ; 20 loops
    SpinLoop1:
        mov eax, 3
        call RandomRange
        mov ebx, OFFSET slotCharacters
        add ebx, eax
        mov al, [ebx]
        mov dl, 15
        mov dh, 6
        call GotoxyXY
        call WriteChar
        call Delay
        loop SpinLoop1

    ; Prints second slot in the box
    mov dl, 15
    mov dh, 6
    call GotoxyXY
    mov al, slot2  
    call WriteChar

    ; Spin animation for slot 3
    mov ecx, 25     ; 25 loops
    SpinLoop2:
        mov eax, 3
        call RandomRange
        mov ebx, OFFSET slotCharacters
        add ebx, eax
        mov al, [ebx]
        mov dl, 18
        mov dh, 6
        call GotoxyXY
        call WriteChar
        call Delay
        loop SpinLoop2

    ; Prints third slot in the box
    mov dl, 18
    mov dh, 6
    call GotoxyXY
    mov al, slot3  
    call WriteChar

    ; Prints score
   mov edx, OFFSET score
   mov ecx, 14
   call GotoxyAtLine
   call WriteString

   ; Storing score in eax
   mov eax, 0

   ; Checks first slot
   mov bl, slot1
   cmp bl, "7"
   je AddSevenFirst
   cmp bl, "$"
   je AddDollarFirst
   jmp CalcSlot2 ; jumps to slot 2 if first slot is 0

; If first slot is 7, add 700 to score
AddSevenFirst:
   add eax, 700
   jmp CalcSlot2

; Adds 500 to score if first slot is a $
AddDollarFirst:
   add eax, 500
   jmp CalcSlot2

; Checks slot 2
CalcSlot2:
   mov bl, slot2
   cmp bl, "7"
   je AddSevenSecond
   cmp bl, "$"
   je AddDollarSecond
   jmp CalcSlot3

AddSevenSecond:
   add eax, 700
   jmp CalcSlot3

AddDollarSecond:
   add eax, 500
   jmp CalcSlot3

; Checks slot 3
CalcSlot3:
   mov bl, slot3
   cmp bl, "7"
   je AddSevenThird
   cmp bl, "$"
   je AddDollarThird
   jmp PrintScore

AddSevenThird:
   add eax, 700
   jmp PrintScore

AddDollarThird:
   add eax, 500

; Prints score
PrintScore:
    call WriteDec


   call Crlf
   call Crlf

PlayAgainPrompt:
    mov edx, OFFSET playAgainMsg
    call WriteString
    call ReadChar
    cmp al, 50h ; P
    je GameLoop
    cmp al, 70h ; p
    je GameLoop
    cmp al, 51h ; Q
    je QuitGame
    cmp al, 71h ; q
    je QuitGame
    jmp PlayAgainPrompt
QuitGame:
    exit
main ENDP


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
