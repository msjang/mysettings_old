#For include once
ISSET_BASH_PROFILE=1


TERM=xterm-color

######################################################################
#
# {{ ALISASES
#

if [ -z "$ISSET_BASH_ALIASES" ]; then
	ISSET_BASH_ALIASES=1
	if [ -f ~/.bash_aliases ]; then
		. ~/.bash_aliases
	fi
fi

#
# }} ALISASES
# 
######################################################################


######################################################################
#
# {{ PATH
#

if [ -z "$ISSET_BASH_PATH" ]; then
	ISSET_BASH_PATH=1
	if [ -f ~/.bash_path ]; then
		. ~/.bash_path
	fi
fi

#
# }} PATH
# 
######################################################################

