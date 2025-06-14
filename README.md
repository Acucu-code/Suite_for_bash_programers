DESCRIPTION:

This suite contains 'sh' scripts designed to complement programming with
commands that, except in rare and forced cases, only use internal commands.

CONTENT:

- Manage script inclusion (include)
- Filter text: highlight, delete, replace and output mode (shead)
- Colorize/style text (tize)
- Positionable text generator, with style, repetitions and more (parp)
- Separate instances and can execute commands with each of them (sep)
- Send standard output to a script (tb)
- Pass command output to a variables (varize)
- Identify numbers (isnum)
- Enumerate numbers and count words (enum)
- Find out the command type and returns a numeric identifier (tipo)
- Check options (check)
- Display script's header stylized information (infsh)
- Control temperature by adjusting CPU frequency (tempfreq, tempfreq_log)
- Terminate the system by time or temperature (fin)
- Converts a partial path to absolute and assigns it to a variable (path)

CONFIGURATION:

1. These scripts must be in the /home/$USER/code folder, since 'include',
'tempfreq_log', and the calls from each script to 'infsh' refer to this folder:

user$ echo PATH=$PATH:~/code >> ~/.bashrc

2. Some tools' working files are located in /tmp/code_$USER and others use
/tmp/code_$USER/vacio to operate with wildcards [*|?] without incident.

[ -e /tmp/code_$USER/vacio ] || { mkdir /tmp/code_$USER ; mkdir -m -w /tmp/code_$USER/vacio ;} >> ~/.bashrc

3. 'tempfreq' and 'tempfreq_log' modify the CPU frequency. If not run as root,
the user must first be granted permission:

user$ sudo chown $USER:$USER /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

OTHERS:

This is a suite because most scripts depend on others. They use 'include', which
manages inclusion. Some only work if included, either with 'include' or directly
with '. script'.

A call to '. include varize check infsh' will include all scripts except 'fin'
that is not necessary, 'tempfreq' that is not includable, and 'tempfreq_log'
that opens a window.

To obtain information about a command, it is usually enough to run it without
any options, currently only in Spanish.
