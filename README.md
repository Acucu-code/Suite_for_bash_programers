DESCRIPTION:

This suite contains 'sh' scripts designed to complement programming with
commands that, except in rare and forced cases, only use internal commands.

CONTENT:

- Manage script inclusion (include)
- Filter text: highlight, delete, replace and output mode (shead)
- Manipulate strings and variables (trip,trim)
- Colorize/style text (tize)
- Positionable text generator, with style, repetitions and more (parp)
- Separate instances and can execute commands with each of them (sep)
- Send standard output to a script or command (tb)
- Pass command output to a variables (varize)
- Identify numbers (isnum)
- Enumerate numbers and count words (enum)
- Generate a random number (rand)
- Find out the command type and returns a numeric identifier (tipo)
- Check options (check)
- Display script's header stylized information (infsh)
- Control temperature by adjusting CPU frequency (tempfreq, tempfreq_log)
- Terminate the system by time or temperature (fin)
- Converts a partial path to absolute and assigns it to a variable (path)
- Manejar matrices archivables 2D (mt)
- Gestionar procesos evitando errores de existencia (killer)

CONFIGURATION:

Include the config script in your .bashrc:

user$ echo ". PATH_TO/code.conf" >> /home/$USER/.bashrc

"PATH_TO" is the folder where you have placed the acucu_code files. You can edit
the configuration file to define this folder to make it accessible to the scripts.

This is a suite because most scripts depend on others. They use 'include', which
manages inclusion. Some only work if included, either with 'include' or directly
with '. script_name'.

A call to '.include varize check infsh' will include all scripts except 'fin',
which is generally for single use (root only), 'tempfreq', which is an active
program, and 'tempfreq_log', which also opens a terminal window when executed.

'tempfreq' and 'tempfreq_log' modify the CPU frequency. If not run as root,
the user must first be granted permission:

user$ sudo chown $USER:$USER \
	/sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

To obtain information about a command, it is usually enough to run it without
any options, currently only in Spanish.
