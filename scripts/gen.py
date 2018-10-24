control_words = ['110100000100000001000000000101', '000010110000000010000000000000', '00000010#####00000000000010001001', '000000100100000000000010010101', '000001000000000000101100000000', '000001000000000000010100000000', '000000010100000000000001010001', '010000010000010000000000000000', '000001000000000000011000011100', '001000000000010100000000000000', '000000001100000000000000001001', '100000000000000000000000000010', '100001000100000000010000000011', '100001000001000000010000000000', '010010110100000000000010001101', '010001110100100000001010001101', '000000010000000000000000100000', '001000110100100010000010101101', '000001000000000000111100000000']

next_state = ['00010', 'dec1', '10011', '00101', '00001', '00001', 'dec2', '01001', '00001', '00001', 'dec3', '00001', '00001', '00001', 'dec4', 'dec5', 'dec6', 'dec7', '00001']

for i in range(1,20) :

	b = (bin(i)[2:])
	b = b.zfill(5)
	print('when \"%s\" => control_word<=\"%s\"; next_state<=\"%s\";'%(b,control_words[i-1],next_state[i-1])
)


