#learn ruby io file system in Y minutes


#creating a new file variable
new_file = File.new("file.txt")#creates a new instance of the File class

#cheching if a file exists
File.exists?('existing_file.txt') #returns true if existing_file.txt exists in script's directory
puts new_file.size #prints the size of a file

#file access modes
File.open('file.txt','w') #write mode - creates an empty file named file.txt. It deletes an already existing file.txt
File.open('file.txt','r') #read mode - can open only an already existing file 
File.open('file.txt','a') #append mode - can read file.txt and write something to the end of the file. If the file doesn't exist, it'll be created

#writing to a text file
writing_file = File.open('writing.txt','w')
writing_file.write "writing text\nAnd in a new line" #writes 2 lines into writing.txt
writing_file.write 'writing text\nAnd in a new line' #it will uppend the second line(\n will not be treated as a new line character)
writing_file.close #closing an opened file

#deleting a file 
File.delete("delfile.txt","delfile1.txt") #deletes all files listed, if has permission

#reading from a text file
read_file = File.open("file.txt","r")

#reading file line by line
while line = reading_file.gets
	puts line #prints every line from a file in a new line
end

#reading file by characters
read_file.each_char { |character|
	puts character #prints every character from a file in a new line
}

#reading file by bytes
read_file.each_byte { |encoding|
	puts encoding #prints encoding of every character from a file in a new line
}
read_file.close




