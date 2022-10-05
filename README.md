# ~/.bashrc
My Bash aliases and functions collection, making Bash in terminal emulator much more friendly and convenient.  
New linux users will find here almost all bash commands they might require, without need for googling them.  
Remember to use `man <your command>` and `<your command> --help` sometimes they save the day.  
Experienced users might appreciate my _sudo_ and _search_ functions and maybe some other things.  
## For now, cool stuff is:
* __alias please__ - combined from [here](https://stackoverflow.com/a/72961859/14167912) and improved to invoke almost anything (only alias _now_ aint working). This is a sudo for things(like functions) that has problems with default sudo. The default sudo is preserved.
* alias ls - cool looking, time and type based
* all kinds of cd, cdls, rm, mkdir, e.t.c.
* alias delete - move to trash (or restore) from terminal (gnome only, as far as I'm aware)
* __alias search__ - filename[str](use '*' for wildcards), startdepth[int]: solving slow find problem by prompting each depth level, really proud of it!
* alias check - lookup files for text insertions and show changetime based files list
* alias match - lookup files for text insertions and show each insertion with string number
* __alias cd__ - makes cd + pwd + ls, using cool ls and showing current path - never saw it in other repos all at once
* __alias dd__ - verbose dd, can save you from mistaking `if=` and `of=` parametres - happened to me once, was not so funny :smile:
* alias setup - perform package install sequence via apt.
* alias uninstall - perform package uninstall sequence via apt.
* alias install_composer - install php composer globally.
* alias calc - there are bash calculation constraints, which are solved by this
* alias ping - limited to 5 packets to make you not push ctrl+c each time.

* other stuff - just read the code, kinda constantly improving my collection...
