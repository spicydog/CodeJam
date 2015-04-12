import math



def is_palindrome( no ):
	if str(no) == str(no)[::-1]:
		return 1
	else:	
		return 0
	pass


output_file = open('xxx.txt', 'w')
output_file.write('')



i_from = 1
i_to = 10**17
base = i_from;

while ( math.sqrt(base) != math.floor(math.sqrt(base) ) ): 
	base = base + 1

base = int(math.sqrt(base))	
# print base

while ( base**2 <= i_to ):
	if ( is_palindrome(base) and is_palindrome( int( base**2 ) )  ):	
		print base**2
		output_file = open('xxx.txt', 'a')
		output_file.write(str(base**2)+'\n')
		output_file.close()

		
	base = base+1

print 'Done!'