# Implementation of a linux command
This is a personal implementation of the linux command du -sb with some modifications, this is essentially an exercise in style.
The commands specifies for each directory the memory occupied by it and by all the subdirectories it contains.


#Usage
This is the syntax:
command [options] [directory...]


These are the options:
 -l -> 
 -h -> if h then if there are hard links in that points to a file in the same tree with root the directory passed in input, they are counted only once.   
 -s regex (default: vuoto; nel seguito, sia s il valore dato a tale opzione).
 -S string (default: vuoto; nel seguito, sia S il valore dato a tale opzione).
 -e hexcont (default: vuoto; nel seguito, sia e il valore dato a tale opzione).

