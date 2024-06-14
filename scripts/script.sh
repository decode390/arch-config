#!/bin/bash
# first lane is callen shebang, this is the interpeter of this script

#MY_SHELL="bash"
# No spaces before of after `=`
#echo "Im ${MY_SHELL}ing on keyboard"


#SERVER_NAME=$(hostname)
#SERVER_NAME=`hostname`
#echo "runing script on ${SERVER_NAME}"


# file operators and numeric (tests)
# man test


# if [ $VAR1 = $VAR2 ]
# then
# 	commands...
# fi
# if [ $VAR1 = $VAR2 ]
# then
# 	commands...
# elif [ $VAR3 = $VAR4]
# then
# 	commands...
# else
# 	commands...
# fi


# COLORS="red green blue"
# for COLOR in $COLORS
# do
# 	echo "COLOR: $COLOR"
# done
# 
# echo $COLORS


# name of program $0
# params `./script.sh param1 param2 param3`
# positional $1, $2, $3
# assign to variable: PARAMETER=$1
# all params $@
#for COLOR in $@
#do
#	echo "COLOR: $COLOR"
#done


# read -p "Enter a user name: " USER
# echo "this user: $USER"


# ls /not/here
# echo "$?"
# HOST="google.com"
# ping -c 1 $HOST
# if [ "$?" -ne "0"]
# then
# 	echo "$HOST unreachable"
# fi


# using return codes
# copy command executes only if mkdir command is success
# mkdir /tmp/bak && cp test.txt /tmp/bak
# second command executes only if first command fails
# cp test.txt /tmp/bak || cp test.txt /tmp

# HOST="google.com"
# ping -c 1 $HOST && echo "$HOST reachable"

# using ; second command executes wihout check return code of first command
# cp test.txt /tmp/bak ; cp test.txt /tmp


# using `local` keyword can define a variable for function scope only
# my_function() {
# 	local MY_VAR=1
# }
# variable are not defined
# echo $MY_VAR


# exit status of functions called with `return` keyword, if is 
# not explicity defined, te exit status takes the last command executed in the function
# `return`  keyword accepts only numbers from 0 to 255
# can takes the exit status of function same of all commands, using `$?` keyword


# with `$$` keyword can take the PID of scrip
# `basename /etc/file` can take the name of file without parent path
# `date +%F` can take the date on format YYYY-MM-DD


# wildcards is used to complement the dir-file names
# * is used to defined anyway on the position:
# 	all .txt files:
# 	*.txt
# ? to exactly one character on the position:
# 	all files with 1.txt, 2.txt, 3.txt pattern
# 	?.txt
# [] - character class - match many character included into the brackets
# matches only one character
# 	can[nt]*
# 	- can
# 	- cat
# 	- candy
# 	- catch
# [!] - exclude, matches characters NOT on brackets
# 	[!aeiou]*
# 	- baseball
# 	- cricket
# [-] - separate two characters with hyphen to create a range
# 	[a-g]* matches files that start with a,b,c,d,e,f,g
# 	[3-6]* files thath start with 3,4,5,6
#
# Predefined named character classes:
# - [[:alpha:]] - alphanumeric characters, not numbers
# - [[:alnum:]] - alphanumeric and digit, 0-9
# - [[:digit:]] - digits, 0-9
# - [[:lower:]] - lower case letters
# - [[:space:]] - tabs, spaces or newlines
# - [[:upper:]] - upper case letters
#
# \ scape character, use to match a wildcard character
# 	*\?
#	done?

# can use forloop on results on wildcards
# for FILE in *.html


# case "$VAR" in
# 	pattern_1|patter_2)
# 		commands...
# 		;;
# 	patterh_3|patter_4)
# 		commands...
# 		;;
# 	*)
# 		comannds...
# 		;;
# esac


#`wc` command


# `shift` keyword shift positional arguments to left
# in first time `$@` takes all arguments except firts


# to increment variables use arithmetic expansion
# ((VARIABLE++))

# while ping -c 1 app.1 > /dev/null #No show the output
# do
# 	echo "Server up..."
# 	sleep 5
# done
# echo "Server down"

# LINE_NUM=1
# while read LINE
# do
# 	echo "${LINE_NUM}: ${LINE}"
# 	((LINE_NUM++)) 
# done < /etc/fstab

# grep xfs /etc/fstab | while read LINE
# do
# 	echo "xfs: ${LINE}"
# done

# FS_NUM=1
# grep xfs /etc/fstab | while read FS MP REST
# do
#	echo "${FS_NUM}: file system: ${FS}"
#	echo "${FS_NUM}: mount point: ${MP}"
#	((FS_NUM++))
# done

# `break` statement is used to break the while loop

# `continue` statement is used to cotinue to next iteration without end current iteration
# mysql -BNe 'show databases' | while read DB
# do
# 	db-backed-up-recently $DB
# 	if [ "$?" -eq "0"]
# 	then
# 		continue
# 	fi
# 	backup $DB
# done

# built in debugging
# add options to shebang line: `/bin/bash -x` for example
# -x = print commands as they execute
# called x-trace, tracing or print debugging
# or with command `set -x` to start debugging and `set +x` to stop debugging
# in command line or in script
# set -x
# TEST_VAR="test"
# echo "$TEST_VAR"
# set +x
#
# -e = Exit on error
# /bin/bash -ex
# /bin/bash -xe
# /bin/bash -e -x
# /bin/bash -x -e
#
# -v = prints shell input lines as they are read
#
# help set

# set -x
# PS4='+ $BASH_SOURCE : $LINENO : '
# TEST_VAR="test"
# echo "TES_VAR"
# set +x
#
# set -x
# PS4='+ ${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}(): '
# debug() {
# 	echo "Executing $@"
# 	$@
# }
# debug ls
# set +x


# detect carriage returns on file with `file` utility or `cat -v`
# file script.sh:
# 	script.sh: Bourne-Again shell script, ASCII text executable, with CRLF line terminators
# carriage returns can be deleted on linux using `dos2unix`
# 	dos2unix script.sh
# 	file script.sh:
# 	script.sh: Bourne-Again shell script, ASCII text executable



# sed 's/<pattern>/<sustitude>/flag' <file>
# sed 's/my wife/sed/g' love.txt
# sed 's/love/like/gw like.txt' love.txt
# sed -i.bak 's/my wife/sed/g' love.txt
# change delimiter
# echo '/home/decode' | sed 's/\/home\/decode/\/export\/users\/decode/'
# echo '/home/decode' | sed 's#/home/decode#/export/users/decode#'
# echo '/home/decode' | sed 's:/home/decode:/export/users/decode:'
#
# delete all line with pattern
# sed '/love/d' file.txt
# use regular expression to define start of line with `^` and end of line `$`
# sed '/^#/d' configfile - remove comments (starts with #)
# sed '/^$/d' configfile - remove blank lines (between start and end of line no have characters)
#
# -----
# #User to run service as.
# User apache
#
# #Group to run service as.
# Group apache
# -----
#
# execute more commands separating with `;`
# sed '/^#/d ; /^$/d' configfile - delete comments lines and blank lines
#
# execute commands from file separated by line
# echo '/^#/d' >> commands.sed
# echo '/^$/d' >> commands.sed
# echo 's/apache/httpd/' >> commands.sed
# sed -f commands.sed configfile
#
# sustitude pattern only in line 2
# sed '2 s/apache/httpd/' configfile
#
# sustitude pattern only in lines that contain 'Group' word
# sed '/Group/ s/apache/httpd' configfile
#
# sustitude in some specific lines
# sed '1,4 s/run/execute' configfile
#
# sustitude pattern only in area between '#User' and blank line separating delimiters `,`
# sed '/#User/,/^$/ s/run/execute/' configfile
