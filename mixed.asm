#COMPUTER ARCHITECTURE COURSE
# NGUYEN MINH HOANG - 2052481

.data
	entry: .asciiz "0ABCDEFGHIJKLMNPQRSTUVWYZ/"
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
	
	#### Second player move - 5th Time #####################
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
	
	##### First player move - 6th Time ########################
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
	
	#### Second player move - 6th Time #####################
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
	
	##### First player move - 7th Time ########################
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
	
	#### Second player move - 7th Time #####################
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
	
	##### First player move - 8th Time ########################
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
	
	#### Second player move - 8th Time #####################
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
	
	##### First player move - 9th Time ########################
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
	
	#### Second player move - 9th Time #####################
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
	
	##### First player move - 10th Time ########################
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
	
	#### Second player move - 10th Time #####################
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
	
	##### First player move - 11th Time ########################
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
	
	#### Second player move - 11th Time #####################
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
	
	##### First player move - 12th Time ########################
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
	
	#### Second player move - 12th Time #####################
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
		
	#### First player move - 13th Time #####################
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
	blt $v0, $t5, INVALID1
	li $t5, 25
	bgt $v0, $t5, INVALID1
	
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
	blt $v0, $t5, INVALID2
	li $t5, 25
	bgt $v0, $t5, INVALID2
	
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
	
INVALID1:
	li $v0, 4
	la $a0, invalid
	syscall
	j MOVE1

INVALID2:
	li $v0, 4
	la $a0, invalid
	syscall
	j MOVE2
	
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
	jal ROW1
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	bnez $v0, WON
	
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal COL1
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	bnez $v0, WON
	
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	jal DIAG1
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	bnez $v0, WON
	
WON:
	jr $ra
	

ROW1:
	li $v0, 0
	move $t0, $s0
	lb $t1, 1($t0)
	lb $t2, 6($t0)
	lb $t3, 11($t0)
	bne $t1, $t2, ROW2
	bne $t1, $t3, ROW2
	move $v0, $t1
	jr $ra
	
ROW2:
	lb $t1, 6($t0)
	lb $t2, 11($t0)
	lb $t3, 16($t0)
	bne $t1, $t2, ROW3
	bne $t1, $t3, ROW3
	move $v0, $t1
	jr $ra
	
ROW3:
	lb $t1, 11($t0)
	lb $t2, 16($t0)
	lb $t3, 21($t0)
	bne $t1, $t2, ROW4
	bne $t1, $t3, ROW4
	move $v0, $t1
	jr $ra
	
ROW4:
	lb $t1, 2($t0)
	lb $t2, 7($t0)
	lb $t3, 12($t0)
	bne $t1, $t2, ROW5
	bne $t1, $t3, ROW5
	move $v0, $t1
	jr $ra
	
ROW5:
	li $v0, 0
	move $t0, $s0
	lb $t1, 7($t0)
	lb $t2, 12($t0)
	lb $t3, 17($t0)
	bne $t1, $t2, ROW6
	bne $t1, $t3, ROW6
	move $v0, $t1
	jr $ra
	
ROW6:
	lb $t1, 12($t0)
	lb $t2, 17($t0)
	lb $t3, 22($t0)
	bne $t1, $t2, ROW7
	bne $t1, $t3, ROW7
	move $v0, $t1
	jr $ra
	
ROW7:
	lb $t1, 3($t0)
	lb $t2, 8($t0)
	lb $t3, 13($t0)
	bne $t1, $t2, ROW8
	bne $t1, $t3, ROW8
	move $v0, $t1
	jr $ra
	
ROW8:
	lb $t1, 8($t0)
	lb $t2, 13($t0)
	lb $t3, 18($t0)
	bne $t1, $t2, ROW9
	bne $t1, $t3, ROW9
	move $v0, $t1
	jr $ra
	
ROW9:
	lb $t1, 13($t0)
	lb $t2, 18($t0)
	lb $t3, 23($t0)
	bne $t1, $t2, ROW10
	bne $t1, $t3, ROW10
	move $v0, $t1
	jr $ra

ROW10:
	lb $t1, 4($t0)
	lb $t2, 9($t0)
	lb $t3, 14($t0)
	bne $t1, $t2, ROW11
	bne $t1, $t3, ROW11
	move $v0, $t1
	jr $ra

ROW11:
	lb $t1, 9($t0)
	lb $t2, 14($t0)
	lb $t3, 19($t0)
	bne $t1, $t2, ROW12
	bne $t1, $t3, ROW12
	move $v0, $t1
	jr $ra

ROW12:
	lb $t1, 14($t0)
	lb $t2, 19($t0)
	lb $t3, 24($t0)
	bne $t1, $t2, ROW13
	bne $t1, $t3, ROW13
	move $v0, $t1
	jr $ra

ROW13:
	lb $t1, 5($t0)
	lb $t2, 10($t0)
	lb $t3, 15($t0)
	bne $t1, $t2, ROW14
	bne $t1, $t3, ROW14
	move $v0, $t1
	jr $ra
	
ROW14:
	lb $t1, 10($t0)
	lb $t2, 15($t0)
	lb $t3, 20($t0)
	bne $t1, $t2, ROW15
	bne $t1, $t3, ROW15
	move $v0, $t1
	jr $ra

ROW15:
	lb $t1, 15($t0)
	lb $t2, 20($t0)
	lb $t3, 25($t0)
	bne $t1, $t2, ROWEND
	bne $t1, $t3, ROWEND
	move $v0, $t1
	jr $ra
ROWEND:
	jr $ra

COL1:
	li $v0, 0
	move $t0, $s0
	lb $t1, 1($t0)
	lb $t2, 6($t0)
	lb $t3, 11($t0)
	bne $t1, $t2, COL2
	bne $t1, $t3, COL2
	move $v0, $t1
	jr $ra
	
COL2:
	lb $t1, 6($t0)
	lb $t2, 11($t0)
	lb $t3, 16($t0)
	bne $t1, $t2, COL3
	bne $t1, $t3, COL3
	move $v0, $t1
	jr $ra
	
COL3:
	lb $t1, 11($t0)
	lb $t2, 16($t0)
	lb $t3, 21($t0)
	bne $t1, $t2, COL4
	bne $t1, $t3, COL4
	move $v0, $t1
	jr $ra
	
COL4:
	lb $t1, 2($t0)
	lb $t2, 7($t0)
	lb $t3, 12($t0)
	bne $t1, $t2, COL5
	bne $t1, $t3, COL5
	move $v0, $t1
	jr $ra
	
COL5:
	lb $t1, 7($t0)
	lb $t2, 12($t0)
	lb $t3, 17($t0)
	bne $t1, $t2, COL6
	bne $t1, $t3, COL6
	move $v0, $t1
	jr $ra
	
COL6:
	lb $t1, 12($t0)
	lb $t2, 17($t0)
	lb $t3, 22($t0)
	bne $t1, $t2, COL7
	bne $t1, $t3, COL7
	move $v0, $t1
	jr $ra
	
COL7:
	lb $t1, 3($t0)
	lb $t2, 8($t0)
	lb $t3, 13($t0)
	bne $t1, $t2, COL8
	bne $t1, $t3, COL8
	move $v0, $t1
	jr $ra
	
COL8:
	lb $t1, 8($t0)
	lb $t2, 13($t0)
	lb $t3, 18($t0)
	bne $t1, $t2, COL9
	bne $t1, $t3, COL9
	move $v0, $t1
	jr $ra
	
COL9:
	lb $t1, 13($t0)
	lb $t2, 18($t0)
	lb $t3, 23($t0)
	bne $t1, $t2, COL10
	bne $t1, $t3, COL10
	move $v0, $t1
	jr $ra

COL10:
	lb $t1, 4($t0)
	lb $t2, 9($t0)
	lb $t3, 14($t0)
	bne $t1, $t2, COL11
	bne $t1, $t3, COL11
	move $v0, $t1
	jr $ra

COL11:
	lb $t1, 9($t0)
	lb $t2, 14($t0)
	lb $t3, 19($t0)
	bne $t1, $t2, COL12
	bne $t1, $t3, COL12
	move $v0, $t1
	jr $ra

COL12:
	lb $t1, 14($t0)
	lb $t2, 19($t0)
	lb $t3, 24($t0)
	bne $t1, $t2, COL13
	bne $t1, $t3, COL13
	move $v0, $t1
	jr $ra

COL13:
	lb $t1, 5($t0)
	lb $t2, 10($t0)
	lb $t3, 15($t0)
	bne $t1, $t2, COL14
	bne $t1, $t3, COL14
	move $v0, $t1
	jr $ra
	
COL14:
	lb $t1, 10($t0)
	lb $t2, 15($t0)
	lb $t3, 20($t0)
	bne $t1, $t2, COL15
	bne $t1, $t3, COL15
	move $v0, $t1
	jr $ra

COL15:
	lb $t1, 15($t0)
	lb $t2, 20($t0)
	lb $t3, 25($t0)
	bne $t1, $t2, COLEND
	bne $t1, $t3, COLEND
	move $v0, $t1
	jr $ra
COLEND:
	jr $ra

	### Check DIAG ###
DIAG1:
	li $v0, 0
	move $t0, $s0
	lb $t1, 1($t0)
	lb $t2, 7($t0)
	lb $t3, 13($t0)
	bne $t1, $t2, DIAG2
	bne $t1, $t3, DIAG2
	move $v0, $t1
	jr $ra
DIAG2:
	lb $t1, 6($t0)
	lb $t2, 12($t0)
	lb $t3, 18($t0)
	bne $t1, $t2, DIAG3
	bne $t1, $t3, DIAG3
	move $v0, $t1
	
DIAG3:
	lb $t1, 11($t0)
	lb $t2, 17($t0)
	lb $t3, 23($t0)
	bne $t1, $t2, DIAG4
	bne $t1, $t3, DIAG4
	move $v0, $t1
	
DIAG4:
	lb $t1, 2($t0)
	lb $t2, 8($t0)
	lb $t3, 14($t0)
	bne $t1, $t2, DIAG5
	bne $t1, $t3, DIAG5
	move $v0, $t1
	
DIAG5:
	lb $t1, 7($t0)
	lb $t2, 13($t0)
	lb $t3, 19($t0)
	bne $t1, $t2, DIAG6
	bne $t1, $t3, DIAG6
	move $v0, $t1
	
DIAG6:
	lb $t1, 12($t0)
	lb $t2, 18($t0)
	lb $t3, 24($t0)
	bne $t1, $t2, DIAG7
	bne $t1, $t3, DIAG7
	move $v0, $t1
	
DIAG7:
	lb $t1, 3($t0)
	lb $t2, 7($t0)
	lb $t3, 11($t0)
	bne $t1, $t2, DIAG8
	bne $t1, $t3, DIAG8
	move $v0, $t1
	
DIAG8:
	lb $t1, 3($t0)
	lb $t2, 9($t0)
	lb $t3, 15($t0)
	bne $t1, $t2, DIAG9
	bne $t1, $t3, DIAG9
	move $v0, $t1
	
DIAG9:
	lb $t1, 8($t0)
	lb $t2, 12($t0)
	lb $t3, 16($t0)
	bne $t1, $t2, DIAG10
	bne $t1, $t3, DIAG10
	move $v0, $t1
	
DIAG10:
	lb $t1, 8($t0)
	lb $t2, 14($t0)
	lb $t3, 20($t0)
	bne $t1, $t2, DIAG11
	bne $t1, $t3, DIAG11
	move $v0, $t1
	
DIAG11:
	lb $t1, 13($t0)
	lb $t2, 17($t0)
	lb $t3, 21($t0)
	bne $t1, $t2, DIAG12
	bne $t1, $t3, DIAG12
	move $v0, $t1
	
DIAG12:
	lb $t1, 13($t0)
	lb $t2, 19($t0)
	lb $t3, 25($t0)
	bne $t1, $t2, DIAG13
	bne $t1, $t3, DIAG13
	move $v0, $t1
	
DIAG13:
	lb $t1, 4($t0)
	lb $t2, 8($t0)
	lb $t3, 12($t0)
	bne $t1, $t2, DIAG14
	bne $t1, $t3, DIAG14
	move $v0, $t1
	
DIAG14:
	lb $t1, 9($t0)
	lb $t2, 13($t0)
	lb $t3, 17($t0)
	bne $t1, $t2, DIAG15
	bne $t1, $t3, DIAG15
	move $v0, $t1
	
DIAG15:
	lb $t1, 14($t0)
	lb $t2, 18($t0)
	lb $t3, 22($t0)
	bne $t1, $t2, DIAG16
	bne $t1, $t3, DIAG16
	move $v0, $t1
	
DIAG16:
	lb $t1, 5($t0)
	lb $t2, 9($t0)
	lb $t3, 13($t0)
	bne $t1, $t2, DIAG17
	bne $t1, $t3, DIAG17
	move $v0, $t1
	
DIAG17:
	lb $t1, 10($t0)
	lb $t2, 14($t0)
	lb $t3, 18($t0)
	bne $t1, $t2, DIAG18
	bne $t1, $t3, DIAG18
	move $v0, $t1
	
DIAG18:
	lb $t1, 15($t0)
	lb $t2, 19($t0)
	lb $t3, 23($t0)
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
