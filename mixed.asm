#COMPUTER ARCHITECTURE COURSE
# NGUYEN MINH HOANG - 2052481

.data
	entry: .asciiz "0ABCDEFGHIJKLMNOPQRSTUVWXY"
	welcome: .asciiz     "\n=========================================== Welcome to MIPS-based TIC-TAC-TOE ===============================================================\n"
	askToplay: .asciiz "\nStart the game ? (y/n)?"
	INSTRUCTION1: .asciiz " This version is design for two players.\n To mark your move, pelase choose a number from 1 to 25 in order to fill 'X' or 'O' in the board. Otherwise, game will be terminated\n To surrender, enter -1\n The board will be structured like below.\n "
	INSTRUCTION2: .asciiz "One who get the 3 symbol on first will be the winner. Press 'y' to start playing and 'n' for quit!!\n"
	play: .byte 'y'
	quit: .byte 'n'
	invalidDirect: .asciiz "\nPlease press 'y' to play and 'n' to quit!\n"
	player1: .asciiz "Player 1 Move! Please enter a number (1-25): "
	player2: .asciiz "Player 2 Move! Please enter a number (1-25): "
	invalid: .asciiz "Your move is invalid, please try again, and you choose (1-25)\n"
	winner1: .asciiz "Player 1 (X)"
	winner2: .asciiz "Player 2 (O)"
	spacee: .asciiz " "
	X: .byte 'X'
	O: .byte 'O'
	surrender2: .asciiz "Player 2 (O) waves white flag. Player 1 (X) won\n"
	surrender1: .asciiz "Player 1 (X) waves white flag. Player 2 (O) won\n"
	verLine: .byte '|'
	horLine: .asciiz "\n---*---*---*---*---*\n"
	newline: .byte '\n'
	winner: .asciiz "Congrats! The winner is "
	tie: .asciiz "Tie! Amazing! You guys play so well! "
	END: .asciiz "\nWanna play again? Press 'y' to play again or any other keys to quit!"
	QUIT: .asciiz "\nQuit the game!"
	ALREADY: .asciiz "This block is occupied\n"
	.text
	.globl main

main:

	#PRINT WELCOME TO MY GAME
	li $v0, 4
	la $a0, welcome
	syscall
	
	#PRINT INSTRUCTION 1
	li $v0, 4
	la $a0, INSTRUCTION1
	syscall
	
	#PRINT INSTRUCTION2
	li $v0, 4
	la $a0, INSTRUCTION2
	syscall

	
START:	
	#Allocate Heap
	la $t0, entry
	lw $t1, 0($t0)
	lw $t2, 4($t0)
	lw $t3, 8($t0)
	lw $t4, 12($t0)
	lw $t5, 16($t0)
	lw $t6, 20($t0)
	lw $t7, 24($t0)
	lw $s1, 28($t0)

	li $v0, 9
	la $a0, 10
	syscall
	#Store the initial string to heap
	sw $t1, 0($v0)
	sw $t2, 4($v0)
	sw $t3, 8($v0)
	sw $t4, 12($v0)
	sw $t5, 16($v0)
	sw $t6, 20($v0)
	sw $t7, 24($v0)
	sw $s1, 28($v0)

	move $s0, $v0
	
	#PRINT THE BOARD
	addi $sp, $sp, -4
	sw  $ra, 4($sp)
	jal PRINTBOARD
	lw  $ra, 4($sp)
	addi $sp, $sp, 4
	
	li $v0, 4
	la $a0, askToplay
	syscall
	
CHECKPLAY:
	li $v0, 12
	syscall 
	move $t0, $v0
	
	lb $t1, play	
	beq $t0, $t1, FIGHTING
	j CHECKQUIT
CHECKQUIT: 
	lb $t1, quit
	beq $t0, $t1, exit
	li $v0, 4
	la $a0, invalidDirect
	syscall
	j CHECKPLAY
	

################################ PRINT BOARD #####################################
FIGHTING:

	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	
	##### First player move ########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE1		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t0, X
	sb $t0, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	
	#### Second player move #####################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE2	#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t1, O
	sb $t1, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	
	##### First player move - 2nd Time ########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE1		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t0, X
	sb $t0, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	
	#### Second player move - 2nd Time #####################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE2	#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t1, O
	sb $t1, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	

	##### First player move - 3rd Time ########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE1		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t0, X
	sb $t0, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	
	######## WHO IS WINNER? ############### 
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal VIPPRO		#Check for winner
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	bnez $v0, W
	
	#### Second player move - 3rd Time #####################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE2		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t1, O
	sb $t1, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4                             
	
	######## WHO IS WINNER? ############### 
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal VIPPRO		#Check for winner
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	bnez $v0, W
	
	##### First player move - 4th Time ########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE1		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t0, X
	sb $t0, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	
	######## WHO IS WINNER? ############### 
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal VIPPRO		#Check for winner
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	bnez $v0, W

	#### Second player move - 4th Time #####################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE2		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t1, O
	sb $t1, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4                             
	
	######## WHO IS WINNER? ############### 
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal VIPPRO		#Check for winner
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	bnez $v0, W

	
	##### First player move - 5th Time ########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal MOVE1		#Get the 1st player's move
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4	
	lb $t0, X
	sb $t0, 0($v0)
	
	############ PRINT BOARD ##########################
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal PRINTBOARD		#Print the board
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	
	######## WHO IS WINNER? ############### 
	addi $sp, $sp, -4	#Allocate Stack
	sw $ra, 4($sp)		#Store register address
	jal VIPPRO		#Check for winner
	lw $ra, 4($sp)		#Restore $ra
	addi $sp, $sp, 4
	bnez $v0, W

	
Tie:	li $v0, 4
	la $a0, tie
	syscall
	j exit
W:
	move $t0, $v0
	li $v0, 4
	la $a0, winner
	syscall
	
	lb $t1, X
	beq $t0, $t1, PLAYER1	
	lb $t2, O
	beq $t0, $t2, PLAYER2	
PLAYER1:
	li $v0, 4
	la $a0, winner1	
	syscall
	li $v0, 11
	lb $a0, newline
	syscall
	j exit
PLAYER2:
	li $v0, 4
	la $a0, winner2
	syscall
	li $v0, 11
	lb $a0, newline
	syscall
	j exit

MOVE1: 	

	li $v0, 4
	la $a0, player1
	syscall
	li $v0, 5
	syscall
	li $t4, -1
	beq $t4, $v0, SURRENDER1

	li $t5, 1
	blt $v0, $t5, LT1_1
	li $t5, 25
	bgt $v0, $t5, LT1_1
	
	move $t0, $s0
	add $a0, $t0, $v0
	
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal OCCUPIED
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	beqz $v0, FLAG1	#If block is occupied then $v0 will be 0
	jr $ra
FLAG1:
	li $v0, 4
	la $a0, ALREADY
	syscall
	j MOVE1	
MOVE2: 
	li $v0, 4
	la $a0, player2
	syscall
	li $v0, 5
	syscall
	
	li $t4, -1
	beq $t4, $v0, SURRENDER2
	
	li $t5, 1
	blt $v0, $t5, LT1_2
	li $t5, 25
	bgt $v0, $t5, LT1_2
	
	move $t0, $s0
	add $a0, $t0, $v0
	
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal OCCUPIED
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	beqz $v0, FLAG2
	jr $ra
FLAG2:
	li $v0, 4
	la $a0, ALREADY
	syscall
	j MOVE2
	
LT1_1:
	li $v0, 4
	la $a0, invalid
	syscall
	j MOVE1
GT9_1:
	li $v0, 4
	la $a0, invalid
	syscall
	j MOVE1

LT1_2:
	li $v0, 4
	la $a0, invalid
	syscall
	j MOVE2
GT9_2:
	li $v0, 4
	la $a0, invalid
	syscall
	j MOVE1
	
OCCUPIED:
	li $v0, 0
	lb $t0, X
	lb $t1, 0($a0)
	beq $t0, $t1, NOTOCC
	lb $t0, O
	beq $t0, $t1, NOTOCC
	move $v0, $a0
NOTOCC:
	jr $ra
	
VIPPRO:
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal ALLROW
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	bnez $v0, WON
	
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal ALLCOL
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	bnez $v0, WON
	
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal DIAG1
	lw $ra, 4($sp)
	addi $sp, $sp, 4

WON:
	jr $ra
	
ALLROW:
	addi $sp, $sp, -4	#Allocate stack
	sw $ra, 4($sp)		
	li $a0, 1		#Check first row
	jal CHECKROW		#Go to check
	bnez $v0, ROWWIN	#If not return 0 then someone won.
	li $a0, 2		#Else, check row 2
	jal CHECKROW		#Go to check
	bnez $v0, ROWWIN	#If not return 0, then someone won.
	li $a0, 3		#Else, check last row
	jal CHECKROW		#Go to check
	bnez $v0, ROWWIN	#If not return 0, then someone won.
	li $v0, 0		#If no one won, then return 0
ROWWIN:
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	jr $ra
	
ALLCOL:
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	li $a0, 1		#Check column 1
	jal CHECKCOL		#Go to check
	bnez $v0, COLWIN	#If not return 0, then someone won
	li $a0, 2		#Else, check column 2
	jal CHECKCOL		#Go to check
	bnez $v0, COLWIN	#If not return 0, then someone won
	li $a0, 3		#Else, check column 3
	jal CHECKCOL		#Go to check
	bnez $v0, COLWIN	#If not return 0, then someone won
	li $v0, 0		#No one won, then return 0
COLWIN:
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	jr $ra
	
CHECKROW:
	li $v0, 0
	addi $a0, $a0, -1
	li $t0, 3
	mul $t0, $t0, $a0
	move $t1, $s0
	addi $t1, $t1, 1
	add $t1, $t1, $t0
	lb $t2, 0($t1)
	lb $t3, 1($t1)
	bne $t2, $t3, ENDROW
	lb $t3, 2($t1)
	bne $t2, $t3, ENDROW
	move $v0, $t2
ENDROW:
	jr $ra

CHECKCOL:
	li $v0, 0
	move $t0, $s0
	add $t0, $t0, $a0
	lb $t1, 0($t0)
	lb $t2, 3($t0)
	lb $t3, 6($t0)
	li $v0, 0
	
	bne $t1, $t2, COLEND
	bne $t1, $t3, COLEND
	move $v0, $t1
COLEND:
	jr $ra

DIAG1:
	li $v0, 0
	move $t0, $s0
	lb $t1, 1($t0)
	lb $t2, 5($t0)
	lb $t3, 9($t0)
	bne $t1, $t2, DIAG2
	bne $t1, $t3, DIAG2
	move $v0, $t1
	jr $ra
DIAG2:
	lb $t1, 3($t0)
	lb $t2, 5($t0)
	lb $t3, 7($t0)
	bne $t1, $t2, DIAGEND
	bne $t1, $t3, DIAGEND
	move $v0, $t1
DIAGEND:
	jr $ra

PRINTBOARD:
	li $v0, 11
	lb $a0, newline
	syscall
	
	#LINE 1
	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 1($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 2($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 3($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 4($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 5($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, horLine #HORIZONTAL LINE
	syscall	

	#LINE 2
	li $v0, 4
	la $a0, spacee
	syscall

	move $t0, $s0
	lb $a0, 6($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 7($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 8($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 9($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 10($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, horLine #HORIZONTAL LINE
	syscall	
	
	#LINE 3
	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 11($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 12($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 13($t0)
	li $v0, 11
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 

	move $t0, $s0
	lb $a0, 14($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 15($t0)
	li $v0, 11
	syscall 
		
	li $v0, 4
	la $a0, horLine #HORIZONTAL LINE
	syscall	
	
	#LINE 4
	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 16($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 17($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 18($t0)
	li $v0, 11
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 

	move $t0, $s0
	lb $a0, 19($t0)
	li $v0, 11
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 20($t0)
	li $v0, 11
	syscall 

	li $v0, 4
	la $a0, horLine #HORIZONTAL LINE
	syscall	
	
	#LINE 5
	li $v0, 4
	la $a0, spacee
	syscall
	
	move $t0, $s0
	lb $a0, 21($t0)
	li $v0, 11
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 22($t0)
	li $v0, 11
	syscall 

	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 23($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 

	move $t0, $s0
	lb $a0, 24($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall
	
	li $v0, 11
	lb $a0, verLine
	syscall 
	
	li $v0, 4
	la $a0, spacee
	syscall 
	
	move $t0, $s0
	lb $a0, 25($t0)
	li $v0, 11
	syscall 
	
	li $v0, 4
	la $a0, horLine #HORIZONTAL LINE
	syscall	
	
	jr $ra
SURRENDER1:
	li $v0, 4
	la $a0, surrender1
	syscall
	j exit
SURRENDER2:
	li $v0, 4
	la $a0, surrender2
	syscall
	j exit
		
exit:
	
	li $v0, 4
	la $a0, END
	syscall
	
	li $v0, 12
	syscall
	move $t0, $v0
	
	lb $t1, play
	beq $t0, $t1, START
	j ENDGAME
ENDGAME:
	li $v0, 4
	la $a0, QUIT
	syscall
	
	li $v0, 10
	syscall
