
def cipher(m)
	monaco_split = m.split("")
	puts monaco_split
	ascii = "monaco".chars.map {|c| c.ord}
	puts ascii
	shifted = ascii.map {|c| c -1}
	puts shifted
	encrypted = shifted.map {|c| c.chr}.join
	puts encrypted
end
cipher("monaco")





