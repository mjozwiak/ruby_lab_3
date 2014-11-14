#learning X in Y
#where X = files in ruby


## input/output modes in ruby (from http://ruby-doc.org/core-2.1.4/IO.html#method-c-new ) ##
#"r"  Read-only, starts at beginning of file  (default mode).

#"r+" Read-write, starts at beginning of file.

#"w"  Write-only, truncates existing file
#     to zero length or creates a new file for writing.

#"w+" Read-write, truncates existing file to zero length
#     or creates a new file for reading and writing.

#"a"  Write-only, each write call appends data at end of file.
#     Creates a new file for writing if file does not exist.

#"a+" Read-write, each write call appends data at end of file.
#     Creates a new file for reading and writing if file does
#     not exist.

# Additional modes

#"b"  Binary file mode
#     Suppresses EOL <-> CRLF conversion on Windows. And
#     sets external encoding to ASCII-8BIT unless explicitly
#     specified.

#"t"  Text file mode


### creating a new file ###

#you can create files in the following ways
f1 = File.open('f1.txt','w')
f2 = File.open('f2.txt','w+')
f3 = File.open('f3.txt','a') #if the file already exists, all the data will be kept
f4 = File.open('f4.txt','a+') #if the file already exists, all the data will be kept


### writing information into a file ###
f1.write("f1!\nf1!\n")
f1.write('f1!\nf1\n')
## f1.txt right now
#=> f1!
#=> f1!
#=> f1!\nf1\n

('a'..'c').each do |i|
	f2.write(i)
end
## f2.txt right now
#=> abc

(0..2).each do |i|
	f3.puts(i)
end
## f3.txt right now
#=> 0
#=> 1
#=> 2

#f4

#Always remember to close the file(especially if you want to reuse the variable)
f1.close
f2.close
f3.close
f4.close


### reading information from a file ###
##opening the files in read mode
f1 = File.open('f1.txt','r')
f2 = File.open('f2.txt','r')
f3 = File.open('f3.txt','r')

##reading from f1.txt
l1 = f1.readline
puts l1 #=> f1!
#pointer in the file has been moved by the readline function!
f1.each_line do |l1|
	puts l1
end
#=> f1!
#=> f1!\nf1\n

##reading from f2.txt
f2.each_byte do |encoding|
	puts encoding #prints encoding of every character from a file in a new line
end
f2.close
#=> 97
#=> 98
#=> 99
#the pointer is now at the end of the f2.txt file
f2 = File.open('f2.txt','r')
f2.each_char do |character|
	puts character #prints every character from a file in a new line
end
#=> a
#=> b
#=> c

##reading from f3.txt
while line = f3.gets
	puts line 
end
#=> 0
#=> 1
#=> 2

f1.close
f2.close
f3.close

### appending an existing file ###

### retrieving information about a file ###
#checking, if a file exists
puts File.exists?('notexistingfile') #=> false
puts File.exists?('f1.txt') #=> true

#checking the size of the file - in bytes
f1 = File.new('f1.txt')
f2 = File.new('f2.txt')
f4 = File.new('f4.txt')
puts f1.size #=> 19
puts f2.size #=> 3
puts File.size?('notexistingfile') #=> nil

#checking, if the file is a directory
if !File.exists?('directory')
	Dir.mkdir('directory')
end
puts File.directory?('directory') #=> true
puts File.directory?(f1) #=> false

puts File.file?('f1.txt') #=> true
puts File.file?('directory') #=> false

#checking, if the file is an executable one
puts File.executable?(f1) #=> false

#checking, when was the last time when the file was modified
puts f1.mtime #=> mtimt returns instance of Time class
# for example => 2014-11-11 21:53:18 +0100

#checking, if the file has length 0
puts File.zero?(f4) #=> true
puts File.zero?(f1) #=> false

puts File.identical?(f1,f4) #=> false
puts File.identical?(f1,f1) #=> true


### file's path ###
#expand_path
puts File.realpath(f1) #=> returns string containing f1's real path
# for example #=> C:/Users/Admin/ruby/f1.txt

puts File.path(f1) #=> returns string containing f1's relative path
#wyn = File.fnmatch('f*','/')
puts File.basename(f1) #=> f1.txt
puts File.basename(f1,'.txt') #=> f1

#File.rename('f1.txt', 'file.exe') spr na linuxie

#=> f1.txt
### deleting a file ###
#delete spr na linuxie


#truncate #sprawdź, w jakich trybach to działa!!