import string
import math

filename = 'A-small-attempt0'
#filename = 'C-small-attempt0'
#filename = 'example'




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