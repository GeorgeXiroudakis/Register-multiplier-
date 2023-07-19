.data                   #data memmory
       	.align 2	# aline the array that follows for words of ints, wich have 4 bytes each, so 2^2
	a : .space 32   # save the needed space for the array with the lable a
	num_call : .asciz "Plese write 8 numbers in 8 diferent rows\n" 	# create a asci \0 terminated string for promt
	next_line : .asciz "\n"						# create a asci \0 terminated string for new_line
	space : .asciz " "						# create a asci \0 terminated string for space
	line : .asciz "-----------------------------------------------"# create a asci \0 terminated string for a "line"
																	 
.text				# program memmory
    main:			# main label
	la x5, a        	# load the lable a(array) to register 5
	addi x17, x0, 4 	# set the ecall to print_string
	la x10, num_call 	# ecall will print the num_call from data
	ecall			# does what we described in x17 and x10 
	addi x6, x0, 0		# initialize x6 with zero to count repetitions in p_loop 
	addi x7, x0, 8 		# initialize x7 with eight to compera the repetitions
	addi x17, x0, 5 	# set the ecall to read_int
	
    p_loop:			# print loop
    	addi x6, x6, 1		# cout plus one repetition
    	ecall			# read int
    	sw x10, 0(x5)		# store the int we read in the array
    	addi x5, x5, 4		# go to the next item in the array for the next repetition
    	bne x6, x7, p_loop	# repeat untill x6 == x7 (untill we repeted it 8 times
    	
    
    addi x17, x0, 4 		# set the ecall to print_string
    la x10, line 		# ecall will print the line from data
    ecall			# print line	
    la x10, next_line 		# ecall will print the next_line from data
    ecall			# print next_line
    la x5, a			# reload the original adress in of the array in x5
    addi x6, x0, 0		# bring repetition counter back to 0	
    
    w_loop:			# write loop
    	addi x17, x0, 1 	# set the ecall to print_int
	lw x10, 28(x5)		# load the curent item to x10 to be printed
	add x11, x10, x10	# use x11 as a temp to add the item to itself, so se have (item * 2)
	add x12, x11, x11	# use x12 as a temp2 to add the item * 2 to itself, so we have (item * 4)
	add x10, x12, x11	# add back to x10 to be printed the (item * 4) + (item * 2) = (item * 6)
	ecall			# print the (item * 6)
	addi x17, x0, 4 	# set the ecall to print_string 
	la x10, space		# set the ecall to print space
	ecall
	addi x5, x5, -4		# go to the previous item in the array for the next repetition
	addi x6, x6, 1		# cout the plus one repetition
	bne x6, x7, w_loop 	# repeat untill x6 == x7 (untill we repeted it 8 times)
	
    addi x17, x0, 4 		# set the ecall to print_string
    la x10, next_line 		# ecall will print the next_line from data
    ecall			#print next_line
    
    j main			# jump to main to start from the start again
