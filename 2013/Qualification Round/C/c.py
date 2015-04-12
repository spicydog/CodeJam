import string
import math

filename = 'C-large-1'
#filename = 'C-small-attempt0'
#filename = 'example'



def is_palindrome( no ):
	if str(no) == str(no)[::-1]:
		return 1
	else:	
		return 0

def calculate( from_to ):

	n=0
	i_from = int(from_to[0]);
	i_to = int(from_to[1]);
	base = i_from;

	while ( math.sqrt(base) != math.floor(math.sqrt(base) ) ): 
		base = base + 1
	
	base = int(math.sqrt(base))	
	# print base

	while ( math.pow(base,2) <= i_to ):
		if ( is_palindrome(base) and is_palindrome( int(math.pow(base,2)))  ):	
			n = n+1
			
		base = base+1

	return n


input_file = open(filename+'.in', 'r')
input = input_file.read()
lines = input.split('\n')
T = int(lines[0])

output = ''
for i in range(1,T+1):
	#print str(i)+' '+lines[i]
 	str_result = 'Case #' + str(i) + ': ' + str( calculate( lines[i].split(' ') ) )
 	print str_result
 	output = output + str_result + '\n'

output_file = open(filename+'.out', 'w')
output_file.write(output)


print output