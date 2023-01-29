# Implementation of a linux command
This is a personal implementation of the linux command du -sb with some modifications, this is essentially an exercise in style, done as a homework during my bachelor degree.
The commands specifies for each directory the memory occupied by it and by all the subdirectories it contains.


# Usage
This is the syntax:
command.sh [options] [directory...]


These are the options:
- -l -> if l then if there are soft links the size of the pointed file will be counted, otherwise tha actual size of the soft link file will be counted.
- -h -> if h then if there are hard links in that points to a file in the same tree with root the directory passed in input, they are counted only once.   
- -s regex (default: empty) -> if s then only directories or files whose name matches with the regex will be counted
- -S string (default: empty) -> if S then only files whose text contains a substring that matches the string will be counted
- -e hexcont (default: empty) -> if e then only files whose hexadecimal dump contains a substring that matches the regular expression will be counted

