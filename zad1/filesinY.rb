#learn ruby I/O file system in Y minutes


#checking if a file exists
File.exists?('existing_file.txt') #returns true if existing_file.txt exists in script's directory

#file access modes
File.open('file.txt','w') #write mode - creates an empty file named file.txt. It deletes an already existing file.txt
File.open('file.txt','r') #read mode - can open only an already existing file 
File.open('file.txt','a') #append mode - can write something to the end of the file. If the file doesn't exist, it'll be created

#creating a new file variable
new_file = File.new("file.txt")#creates a new instance of the File class

#checking the size of a file
puts new_file.size #prints the size of a file

#writing to a text file
writing_file = File.open('writing.txt','w')
writing_file.write "writing text\nAnd in a new line" #writes 2 lines into writing.txt
writing_file.write 'writing text\nAnd in a new line' #it will uppend the second line(\n will not be treated as a new line character)

#reading from a text file
read_file = File.open('file.txt','r')

#reading file line by line
while line = read_file.gets
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

#closing files
read_file.close
writing_file.close
new_file.close

#appending a file
append_file = File.open('file.txt','a')
append_file.write "\nAdded\n4\nNew\nLines" 
append_file.close

#deleting a file 
#File.delete("file.txt","writing.txt") #deletes all files listed, if has permission





