# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export LD_LIBRARY_PATH=/usr/local/smr/lib/
export PATH=$PATH:/usr/local/smr/bin/
