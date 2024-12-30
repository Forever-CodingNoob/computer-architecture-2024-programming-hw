.globl sort


# swap(addr1, addr2)
swap:
	ld x5, 0(x10)
	ld x6, 0(x11)
	sd x6, 0(x10)
	sd x5, 0(x11)
	ret


# partition(addr, lo, hi)
partition:
	# TODO: implement partition() here
	addi sp, sp, -56 # extend the stack to store 7 registers
	
	# save saved registers and the return address
	sd x1, 48(sp)
	sd x23, 40(sp)
	sd x22, 32(sp)
	sd x21, 24(sp)
	sd x20, 16(sp)
	sd x19, 8(sp)
	sd x18, 0(sp)

	# move parameters
	mv x18, x10 # addr 
	mv x19, x11 # lo 
	mv x20, x12 # hi

	# pivot value
	slli x5, x19, 3
	add x5, x5, x18
	ld x21, 0(x5) # x21 = pivot = addr[lo]
	
	# left index and right index 
	addi x22, x19, -1 # x22 = i
	addi x23, x20, 1 # x23 = j

# outer loop
outerwhile:
# inner loop 1
innerwhile1: 
	addi x22, x22, 1 # i=i+1
	
	slli x5, x22, 3 # x5=i*8
	add x5, x5, x18 # x5=addr+i*8
	ld x5, 0(x5) # x5 = addr[i]
	blt x5, x21, innerwhile1 # back to while loop if addr[i] < pivot
	
# inner loop 2
innerwhile2:
	addi x23, x23, -1 # j=j-1
	
	slli x5, x23, 3 # x5=j*8
	add x5, x5, x18 # x5=addr+j*8
	ld x5, 0(x5) # x5 = addr[j]
	bgt x5, x21, innerwhile2 # back to while loop if addr[j] > pivot

# outer loop
# if branch 
	blt x22, x23, else # if i<j 
	mv x10, x23 # return j

	# restore saved registers, return address, and stack pointer
	# and then return
	ld x18, 0(sp)
	ld x19, 8(sp)
	ld x20, 16(sp)
	ld x21, 24(sp)
	ld x22, 32(sp)
	ld x23, 40(sp)
	ld x1, 48(sp)
	addi sp, sp, 56
	ret

else:
	# x10 = addr+i*8 = &addr[i]
	slli x10, x22, 3
	add x10, x10, x18

	# x11 = addr+j*8 = &addr[j]
	slli x11, x23, 3
	add x11, x11, x18
	
	# call swap(&addr[i], &addr[j])
	jal x1, swap

	# back to the outer while loop
	j outerwhile




# quicksort(addr, lo, hi)
quicksort:
	# TODO: implement quicksort() here
	addi sp, sp, -40 # extend the stack to store 5 registers
	
	# save saved registers and return address 
	sd x1, 32(sp)
	sd x21, 24(sp)
 	sd x20, 16(sp)
	sd x19, 8(sp)
	sd x18, 0(sp)

	# move parameters
	mv x18, x10 # addr 
	mv x19, x11 # lo 
	mv x20, x12 # hi

# if test
	blt x19, x0, exit
	blt x20, x0, exit
	bge x19, x20, exit

	# call partition(addr, lo, hi)
	jal x1, partition 
	mv x21, x10 # x21 = p = partition(addr, lo, hi)
	
	# call quicksort(addr, lo, p)
	mv x10, x18 
	mv x11, x19
	mv x12, x21
	jal x1, quicksort

	# call quicksort(addr, p+1, hi)
	mv x10, x18
	addi x11, x21, 1
	mv x12, x20
	jal x1, quicksort

exit:
	# restore saved registers, return address, and stack pointer
	ld x18, 0(sp)
	ld x19, 8(sp)
	ld x20, 16(sp)
	ld x21, 24(sp)
	ld x1, 32(sp)
	addi sp, sp, 40
	ret

# sort(addr, count)
sort:
	# TODO: call your quicksort() here
	# extend stack and save return address 
	addi sp, sp, -8
	sd x1, 0(sp)

	# call quicksort(addr, 0, count - 1)
	addi x12, x11, -1 # x12 = count - 1
	mv x11, x0 # x11 = 0
	jal x1, quicksort
	
	# restore return address and stack pointer
	ld x1, 0(sp)
	addi sp, sp, 8
	ret
