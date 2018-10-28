;***************
; This is the solution of B2 which will calculate
; grade point. User will give the input and it shows
; the corresponding grade point.
; For example: if user give 85, it will show A+
;
;***************


.MODEL SMALL
.STACK 100H
.DATA 

MGS1 DB 'Enter your mark: $'          ;show first message
MGS2 DB 'Grade you obtained: $'       ;show second message  
MGS3 DB 'You have not entered proper number $'  ;message for proper number
MGS4 DB 'Please Enter number between 1 to 100 $'


      ; Here student obtains mark between one digit (0-9) to three digit (100). So we have to consider all the cases

firstdigit            DB '?'     ; first digit of mark
seconddigit           DB '?'     ; second digit of mark
thirddigit            DB '?'     ; Third digit of mark



.CODE


MAIN PROC  
    
    ; this function will take input from user and store input data in veriable
    
    CALL INPUT_FUNCTION
   
    ;this function will print the taken input
   
    CALL PRINT_DIGIT   
    
    ;Form number from the digits
    
    CALL NUMBER_FORMATION
    
    
    
    
    
    
    
    
    
    ; Exit from main procedure
    EXIT:
    MOV AH, 4CH
    INT 21H   
    
    MAIN ENDP  
 

NUMBER_FORMATION PROC
    
    
    ; First we have to check how many digits user have entered
    ; after that we will form the number base on digits
    
    CMP thirddigit, '?'
    JNE VALID_CHECK
    
    CMP seconddigit, '?'
    JNE VALID_CHECK
    
    CMP firstdigit, '?'  
    JNE VALID_CHECK 
        
          ; print warning message to user
    
          CALL NEW_LINE
          
          MOV AX,@DATA
          MOV DS,AX
          
          LEA DX, MGS3
          MOV AH, 09H
          INT 21H 
           
          CALL NEW_LINE
          
          LEA DX, MGS4
          MOV AH, 09H
          INT 21H
           
           CALL NEW_LINE
          ; Again call Input Function
          
          CALL INPUT_FUNCTION  
          
          ; Call number formation for new number formation
          
          CALL NUMBER_FORMATION
    
    VALID_CHECK:
           
          
          
          SECOND_DIGIT:
    RET
    NUMBER_FORMATION ENDP

   
PRINT_DIGIT PROC    
    
    MOV AH,02H 
   
    ;Newline
    MOV DL,0DH
    INT 21H                
    
    MOV DL,0AH
    INT 21H
    
    
    
    MOV DL, firstdigit
    ADD DL,48
    INT 21H
    MOV DL, seconddigit
    ADD DL,48
    INT 21H 
    MOV DL, thirddigit
    ADD DL,48
    INT 21H
    
    ret
    PRINT_DIGIT ENDP   
   

   
   

INPUT_FUNCTION PROC 
     MOV AX,@Data   ; get data segment
     MOV DS,AX
     
     ;initialize the veriables
     MOV firstdigit , '?'
     MOV seconddigit, '?'
     MOV thirddigit,  '?'
     
         
           
           
     ;print first message
     MOV AH,09H   
     LEA DX, MGS1
     INT 21H  
     
     
     
     ;input taking start
     
     MOV AH,01H
     
     ;take firstdigit
     INT 21H  
     CMP AL, 0DH  
     JE EXIT_INPUT_FUNCTION
     
     MOV firstdigit, AL
     SUB firstdigit , 48
     
     ; Check if user press enter button
     INT 21H
     CMP AL, 0DH  
     JE EXIT_INPUT_FUNCTION
     
          
     
     ;take second digit
     MOV seconddigit, AL
     SUB seconddigit, 48
     
      
     ; Check if user press enter button
     INT 21H
     CMP AL, 0DH  
     JE EXIT_INPUT_FUNCTION  
     
     ;take third digit
     MOV thirddigit, AL
     SUB thirddigit, 48
     
    
     EXIT_INPUT_FUNCTION:  
       ret
    
    INPUT_FUNCTION ENDP  

   
   
   ;Newline Fuction
   NEW_LINE PROC 
    
    MOV AH,02H
    MOV DL,0DH
    INT 21H                
    
    MOV DL,0AH
    INT 21H 
    
    RET
    NEW_LINE ENDP
END MAIN