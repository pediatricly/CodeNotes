
##Early Resources
[Shell Scripting Tutorial in Vim](https://www.youtube.com/watch?v=hwrnmQumtPw)
[Nice reference](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#sect_03_02)

##Variables

###The Dollar Sign
To assign a variable, just:
```bash
myvar=6
myString="hello"
```
Note that space around the = throws an error.

But then to invoke the variable, you need to lead with $:
```
echo $myvar
echo $myString
```

###Local v Globals
Like other languages, variables defined at 0 indent are available globally, but
if you define the same name within a functions, it's only available locally and
can't be seen outside the function.


##Input (Read)
The raw_input equivalent is read.
-p option lets you pass a string prompt. 
varname to store it goes at the end
```
read -p "What is your name? " name

echo "Hello, $name"

read -p "How old are you? " age
```

read can take multiple parameters, too. Just separate the input with spaces and
list multiple, ordered variable names.

You can also set it to use a comma as a separator:
```
OIFS="$IFS"
IFS=","
read -p "Enter 2 numbers to add separated by a comma" num1 num2
num1=${num1//[[:blank:]]/} #These statements will trim any whitespace around the
# commas
num2=${num2//[[:blank:]]/}

sum=$((num1+num2))

echo "$num1 + $num2 = $sum"

IFS="$OIFS"
```

`read -sp` where s is for secret does not show what you're typing and so can be
used for passwords.

```
read -sp "Enter the secret code" secret
if [ "$secret" == "openSesame" ]; then
	echo "You may enter"
else 
	echo "Wrong password"
fi
```


##Functions
```
getDate(){
	date

	return
}

getDate
```

##Conditionals
Are not quite as simple as Python...

```bash
echo "Hello, $name"

read -p "How old are you? " age

if [ $age -ge 16 ]
then
	echo "You can drive"
elif [ $age -eq 15 ]
then
	echo "You can drive next year"
else 
	echo "You can't drive"
fi
```
I think you can use [] or (()) for conditions:

```bash
if ((num == 10)); then
	echo "Your number equals 10"
else
	echo "It is not ten"
fi
```

###Comparisons and Booleans
```
== -eq
!= -ne
<= -le
>= -ge
< -lt
> -gt

if ((num == 10)); then
	echo "Your number equals 10"
fi
```

AND must be &&
OR must be ||
NOT is !

```
if (( ((num > 0)) && ((num < 11)) ))
then
	echo "$num is between 1 and 10"
```

###File / Directory Exists

Parameter | 	Description
-e |	Returns a true value if the file exists
-f |	Returns a true value if the file exists and regular file
-r |	Returns a true value if the file exists and is readable
-w |	Returns a true value if the file exists and is writable
-x |	Returns a true value if the file exists and is executable

You can use these in interesting ways to manipulate files / directories:

```
touch samp_file && mvim samp_file
```
That will create samp_file then open in macvim if successful.

```
[ -d samp_dir ] || mkdir samp_dir
```
See if samp_dir exists OR create it.
That [ -d ] syntax only works in a script. The bash command is `test` but it
seems to have no ouput. So, a script would be:
```bash
FILE=$1
if [ -f $FILE ]; then
   echo "File '$FILE' Exists"
else
   echo "The File '$FILE' Does Not Exist"
fi
```
Where you'd pass a file name as the argv to the script.

###String Comparison / Existence

```
str1=""
str2="Sad"
str3="Happy"

if [ "$str1" ]; then
	echo "$str1 is not null"
fi

if [ -z "$str1" ]; then
	echo "str1 has no value"
fi

if [ "$str2" == "$str3" ]; then
	echo "$str2 equals $str3"
elif [ "$tsr2" != "$str3" ]; then
	echo "$str2 is not equal to $str3"
fi
```

Greater than & less than work as you'd expect, ie they compare alphabetically.

###Regex Regular Expressions

```
read -p "Validate date: " date
pat="^[0-9]{8}$"

if [[ $date =~ $pat ]]; then
	echo "$date is valid"
else
	echo "$date is not valid"
fi
```
###Parameter Expansion / Replacement
Without adding these {} bash would get confused about your echo statement if
you're trying to add ' and such.
Then the // / syntax allows replacement of substrings.

```bash
name="Mike"
echo "${name}'s motorcycle"

samp_string="The dog climnbed the tree."
echo "${samp_string//dog/squirrel}"

echo "I am ${name:-Steve}" #Replaces name with Steve if name does not exist. 
echo "I am ${name:=Steve}" #Replaces name with Steve and changes the value of
# name.
echo $name
```

##Direct Code
Blew my mind that you can run python commands directly from CLI. I must have
known this once upon a time, but forgot:
```
python -c "print $num7+$num8"
```
You can run multiple commands by using the ; to delineate them.

But, be careful with the $ here. If you want to capture that output as a bash
variable, the expression needs to have a $:
`num9=(python -c "print $num7+$num8")` returns `python`. But,
` num9=$(python -c "print $num7+$num8")` returns that sum as you'd want.

##[Cat](http://www.linfo.org/cat.html)

###Reading Files
The most common use of cat is to read the contents of files, and cat is often the most convenient program for this purpose. All that is necessary to open a text file for viewing on the display monitor is to type the word cat followed by a space and the name of the file and then press the ENTER key. For example, the following will display the contents of a file named file1:

```
cat file1
```

The standard output (i.e., default destination of the output) for cat, as is generally the case for other command line (i.e., all-text mode) programs, is the monitor screen. However, it can be redirected from the screen, for example, to another file to be written to that file or to another command to use as the input for that command.

In the following example, the standard output of cat is redirected using the output redirection operator (which is represented by a rightward pointing angular bracket) to file2:

`cat file1 > file2`

That is, the output from cat is written to file2 instead of being displayed on the monitor screen.

The standard output could instead be redirected using a pipe (represented by a vertical bar) to a filter (i.e., a program that transforms data in some meaningful way) for further processing. For example, if the file is too large for all of the text to fit on the monitor screen simultaneously, as is frequently the case, the text will scroll down the screen at high speed and be very difficult to read. This problem is easily solved by piping the output to the filter less, i.e.,

`cat file1 | less`

This allows the user to advance the contents of the file one screenful at a time by pressing the space bar and to move backwards by pressing the b key. The user can exit from less by pressing the q key.

Typing the command cat followed by the output redirection operator and a file name on the same line, pressing ENTER to move to the next line, then typing some text and finally pressing ENTER again causes the text to be written to that file. Thus, in the following example the text that is typed on the second line will be written to a file named felines:

```
cat > felines
This is not about a feline.
```
The program is terminated and the normal command prompt is restored by pressing the CONTROL and d keys simultaneously.

Repeating the above example without using a redirection operator and specifying a destination file, i.e.,

```
cat
This is not about a feline.
causes the text to be sent to standard output, i.e., to be repeated on the monitor screen.
```

###Concatenation

The second role of cat is concatenation (i.e., stringing together) of copies of the contents of files. (This is the source of cat's curious name.) Because the concatenation occurs only to the copies, there is no effect on the original files.

For example, the following command will concatenate copies of the contents of the three files file1, file2 and file3:

```
cat file1 file2 file3
```

The contents of each file will be displayed on the monitor screen (which, again, is standard output, and thus the destination of the output in the absence of redirection) starting on a new line and in the order that the file names appear in the command. This output could just as easily be redirected using the output redirection operator to another file, such as file4, using the following:

```
cat file1 file2 file3 > file4
```

In the next example, the output of cat is piped to the sort filter in order to alphabetize the lines of text after concatenation and prior to writing to file4:

```
cat file1 file2 file3 | sort > file4
```


###File Creation

The third use for cat is file creation. For small files this is often easier than using vi, gedit or other text editors. It is accomplished by typing cat followed by the output redirection operator and the name of the file to be created, then pressing ENTER and finally simultaneously pressing the CONTROL and d keys. For example, a new file named file1 can be created by typing

```
cat > file1
```

then pressing the ENTER key and finally simultaneously pressing the CONTROL and d keys.

If a file named file1 already exists, it will be overwritten (i.e., all of its contents will be erased) by the new, empty file with the same name. Thus the cautious user might prefer to instead use the append operator (represented by two successive rightward pointing angular brackets) in order to prevent unintended erasure. That is,

```
cat >> file1
```

That is, if an attempt is made to create a file by using cat and the append operator, and the new file has the same name as an existing file, the existing file is, in fact, preserved rather than overwritten, and any new text is added to the end of the existing file.

Text can be entered at the time of file creation by typing it in after pressing the ENTER key. Any amount of text can be typed, including text on multiple lines.

cat can also be used to simultaneously create a new file and transfer to it the data from an existing file. This is accomplished by typing cat, the name of the file from which the output will come, the output redirection operator and the name of the file to be created. Then pressing ENTER causes the new file to be created and written to. For example, typing the following and then pressing ENTER creates a new file named file2 that contains a copy of the contents of file1:

```
cat file1 > file2
```

There is no effect on the contents of file1. (The same thing can, of course, be accomplished just as easily using cp command, which is used to copy files, i.e., cp file1 file2, but the above example does illustrate the great versatility of cat.)

A slight modification to the above procedure makes it possible to create a new file and write text into it from both another file and the keyboard. A hyphen surrounded by spaces is added before the input file if the typed-in text is to come before the text from the input file, and it is added after the input file if the typed-in text is to go after the text from the input file. Thus, for example, to create a new file file6 that consists of text typed in from the keyboard followed by the contents of file5, first enter the following:

```
cat - file5 > file6
```

Or to create a new file file8 that consists of the contents of file7 followed by text typed in from the keyboard, first enter the following:

```
cat file7 - > file8
```

In either case, then press ENTER to move to a new line and type the desired text on any number of lines. Finally press ENTER once more followed by pressing the CONTROL and d keys simultaneously to execute (i.e., run) the command.

An example of a practical application for this use of cat is the creation of form letters (or other documents) for which only the top parts (e.g., dates and names) are customized for each recipient.
