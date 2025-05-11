This suite contains sh scripts designed to complement programming with commands that, except in rare and forced cases, only use sh built-in commands for:

- managing script inclusions (include, tipo)
- filtering text (shead)
- coloring/styling text (parp, tize)
- managing CPU frequency based on temperature (tempfreq, tempfreq_log)
- passing command output to a variable (varize)
- instance separator (sep)
- delivering standard output to a script (tb)
- number identifier (isnum)
- number enumerator and word counter (enum)
- terminating the system by time or temperature (fin)
- displaying/coloring the information header of a script (infsh)
- checking options (check)

The script or bash, that include other scripts also include 'include' and 'tipo'. See 'include'.

It's recommended to keep these scripts in a folder included in your PATH, such as /home/code/*
PATH=$PATH:~/code

Some of these scripts use the /tmp/vacio folder to work with wildcards [*|?] without any problems.

