# ~/.bashrc: executed by bash(1) for non-login shells.
#For include once
ISSET_BASH_ALIASES=1

######################################################################
#
# {{ basic utils
#

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias j='jobs -l | while read line; do A=`echo $line | cut -d" " -f1`; B=`echo $line | cut -d" " -f2`; echo -n $A"	"; ps -o "%p %a" $B | /bin/grep $B; done;'
alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias 5='fg %5'
alias 6='fg %6'
alias 7='fg %7'
alias 8='fg %8'
alias 9='fg %9'

alias fdisk='sudo fdisk'
alias mount='sudo mount'
alias umount='sudo umount'
alias umountall='sudo umount /media/msjang/*'

function cd {
	builtin cd -L $* && ls -CF;
}

alias sshx='ssh -c arcfour,blowfish-cbc -XC -o ServerAliveInterval=30'

alias LS='ls -al --time-style=long-iso --sort=time'
alias L='ls -l --time-style=long-iso --sort=time'

#
# }} basic utils
# 
######################################################################


######################################################################
#
# {{ screen related
#

#alias tab='screen -X title'
#alias tabs='screen -X title `basename $PWD`'

alias screen0='sudo screen /dev/ttyUSB0 115200'
alias screen1='sudo screen /dev/ttyUSB1 115200'
alias screen2='sudo screen /dev/ttyUSB2 115200'
alias screen3='sudo screen /dev/ttyUSB3 115200'

function scmd { echo $* > /dev/ttyS0; }
function scmd0 { echo $* > /dev/ttyUSB0; }
function scmd1 { echo $* > /dev/ttyUSB1; }
function scmd2 { echo $* > /dev/ttyUSB2; }
function scmd3 { echo $* > /dev/ttyUSB3; }
function scmd4 { echo $* > /dev/ttyUSB4; }
function scmd5 { echo $* > /dev/ttyUSB5; }
function scmd6 { echo $* > /dev/ttyUSB6; }
function scmd7 { echo $* > /dev/ttyUSB7; }
function scmd9 { echo $* > /dev/ttyUSB9; }

alias minicom='minicom --noinit --wrap --ansi'

#
# }} screen related
# 
######################################################################


######################################################################
#
# {{ tmux
#

alias tt='tmux'
function t {
	if [[ $* == "" ]]; then
		tmux ls 2> /dev/null
		if [[ $? != 0 ]]; then
			echo "create tmux new session:  tt ";
		fi
	else
		tmux a -t $* ;
	fi
}

#
# }} tmux
# 
######################################################################


######################################################################
#
# {{ build
#

function build {
	if [[ -d $MYBUILD_DIR ]]; then
		pushd $MYBUILD_DIR;
		make $*;
		popd;
	else
		echo "please retry after set MYBUILD_DIR"
		echo "  ex) export MYBUILD_DIR=$PWD"
	fi
}

#
# }} build
# 
######################################################################


######################################################################
#
# {{ characters
#

alias myconv='iconv -t utf8 -f euckr '
alias utf8='export LANG=ko_KR.UTF-8'

#
# }} characters
# 
######################################################################


######################################################################
#
# {{ vi, vim
#

function vi {
	CSCOPE_DIR=""
	if [[ $FAKE_PWD == '' ]]; then
		tmpdirx=$PWD
	else
		tmpdirx=$FAKE_PWD
		CSCOPE_DIR=$tmpdirx
	fi
	#echo tmpdirx=$tmpdirx

	while [[ $tmpdirx != '/' ]]; do
		if [[ -f $tmpdirx/cscope.out ]]; then
			break;
		fi
		CSCOPE_DIR=../$CSCOPE_DIR
		tmpdirx=$(dirname $tmpdirx)
	done


	if [[ $tmpdirx == '/' ]]; then
		unset CSCOPE_DIR
	else
		export CSCOPE_DIR
	fi
	/usr/bin/vi $*
}

function vii {
	tmpdirx=$PWD
	CSCOPE_FILE=""
	TARGET_FILE=$(basename $*)

	while [[ $tmpdirx != '/' ]]; do
		if [[ -f $tmpdirx/cscope.out ]]; then
			CSCOPE_FILE=$tmpdirx/cscope.out
			break;
		fi
		TARGET_FILE=$(basename $tmpdirx)/$TARGET_FILE
		tmpdirx=$(dirname $tmpdirx)
	done

	#echo TARGET_FILE:$TARGET_FILE
	#echo CSCOPE_FILE:$CSCOPE_FILE
	#echo tmpdirx:$tmpdirx

	if [[ $tmpdirx != '/' ]]; then
		(builtin cd $tmpdirx; /usr/bin/vi $TARGET_FILE;)
	else
		/usr/bin/vi $*
	fi
}



#
# }} vi, vim
# 
######################################################################


######################################################################
#
# {{ grep, find
#

alias g='  grep -ni --color'
alias gg=' grep -ni --color *.{h,hpp,cpp,cc,c,java} -e'
alias ggg='grep -ni --color */*.{h,hpp,cpp,cc,c,java} -e'
alias gg2='grep -ni --color ../*/*.{h,hpp,cpp,cc,c,java} -e'

#get fuction list from source file
alias f='grep -ni --color -E "^[a-z_].*\([^;]*$"'

alias ff=' find -L ./ -type f -iname "*.[chs]" -or -iname "*.[ch]pp" -or -iname "*.cc" -or -iname "*.java" | xargs grep -nH --color '
alias fff='find -L ./ -type f | xargs grep -nH --color '
#alias ffff='find ./ -type f ! \( -name "*.ko" -or -name "*.so" -or -name "*.cmd" -or -name "*.[acodh]" -or -name "*.map" -or -name "*.cc" -or -name "*.cpp" \) | xargs grep -nH --color '
alias ffff='find ./ -type f ! \( -name "*.ko" -or -name "*.so" -or -name "*.cmd" -or -iname "*.[acodh]" -or -iname "*.map" -or -iname "*.cc" -or -iname "*.[ch]pp" -or -name "tags" -or -name "cscope.*" \) | xargs grep -nH --color '

function vv {
	if [[ $# == 1 ]]; then
		bname=$(basename $1)
		FLST=`find ./ -maxdepth 14 -name $bname` && vi $FLST
	else
		#(cd $1 && FLST=`find ./ -maxdepth 14 -name $2` && vi $FLST)
		#echo "FLST=`find $1 -maxdepth 14 -name $2` && FAKE_PWD=$1 vi $FLST"
		if [[ -d $1 ]]; then
			bname=$(basename $2)
			FLST=`find $1 -maxdepth 14 -name $bname` && FAKE_PWD=`builtin cd ../src; pwd` vi $FLST
		else
			echo "usage: vv {dir} {filename}  or  vv {filename}"
		fi
	fi
}

#
# }} grep, find
# 
######################################################################


######################################################################
#
# {{ tags
#

alias cpptags='find ../ -type f -name "*.[ch]pp" -or -name "*.cc" -or -name "*.[ch]" | grep -v "../`basename \`pwd\``" | ctags -f uptags --language-force=c++ --extra=+q --fields=+i -L - ; find ./ -type f -name "*.[ch]pp" -or -name "*.cc" -or -name "*.[ch]" | ctags --language-force=c++ --extra=+q --fields=+i -L -'

function csc {
	\rm ./list
	\rm ./tags
	\rm ./cscope.out
	find . -type f -name "*.[cCsShH]" >list
	find . -type f -name "Make*" >>list
	find . -type f -name "archi*" >>list
	find . -type f -name "*.c++" >>list
	find ./ ! \( -type d -name gen -prune \) -type f -name "*.java" >>list
	find . -type f -name "*.[ch]pp" >>list
	find . -type f -name "*.inc" >>list
	#ctags -R
	#cscope -i list
	cat list | ctags -L -
}

#
# }} 
# 
######################################################################


######################################################################
#
# {{ diff
#

export MYDIFF=/
function mydiff    { vimdiff $* $MYDIFF/$* ; }
function mydiff2   { vimdiff $* $OLDPWD/$* ; }
function setmydiff { export MYDIFF=$* ; }

#
# }} diff
# 
######################################################################


######################################################################
#
# {{ SVN related
#

export SVN_EDITOR=vim
alias st=' svn st | grep "^[^?]"'
alias st2='svn st | grep "^?[A-Za-z0-9_.+=  ]*.\.\(cpp\|hpp\|cc\|h\|c\)"'

#
# }} SVN related
# 
######################################################################


######################################################################
#
# {{ GIT related
#

export GIT_EDITOR=vim
alias gs='git status'

function git-track {
	CURRENT_BRANCH=$(parse_git_branch)
	git config branch.$CURRENT_BRANCH.remote $1
	git config branch.$CURRENT_BRANCH.merge refs/heads/$CURRENT_BRANCH
}

function gcd {
	tmpdirx=$PWD

	while [[ $tmpdirx != '/' ]]; do
		if [[ -d $tmpdirx/.git ]]; then
			export GITDIR=$tmpdirx
			export CDPATH=.:$tmpdirx
			break;
		fi
		tmpdirx=$(dirname $tmpdirx)
	done

	if [[ $tmpdirx != '/' ]]; then
		if [[ $* == "" ]]; then
			cd $tmpdirx;
		else
			if [[ -d $tmpdirx/$* ]]; then
				builtin pushd $tmpdirx/$* && ls -CF;
			else
				builtin pushd $(dirname $tmpdirx/$*) && ls -CF;
			fi
		fi
	else
		echo "Can't find git directory"
	fi
}
builtin complete -F _cd -o nospace gcd

function gitall {
	find ./ -maxdepth 7 -name .git | while read F; do
		D=`dirname $F`;
		echo -e "GIT: \033[01;31m${D}\033[00m";
		if [[ $* != "" ]]; then
			(builtin cd $D; git $*;);
			echo "";
		fi
	done;
}
builtin complete -F _git -o nospace gitall

#
# }} GIT related
# 
######################################################################


######################################################################
#
# {{ SET PS1
# 

# set color 
c_red=`tput setaf 1` 
c_green=`tput setaf 2` 
c_yellow=`tput setaf 3` 
c_blue=`tput setaf 4` 
c_magenta=`tput setaf 5` 
c_cyan=`tput setaf 6` 
c_white=`tput setaf 7` 
# set bold 
c_bold=`tput bold` 
# reset color 
c_sgr0=`tput sgr0` 
 
parse_git_branch () 
{ 
   if git rev-parse --git-dir >/dev/null 2>&1 
   then 
      gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p') 
   else 
      return 0 
   fi 
   echo -e $gitver 
} 
  
branch_color () 
{ 
   if git rev-parse --git-dir >/dev/null 2>&1 
   then 
      color="" 
      if git diff --quiet 2>/dev/null >&2 
      then 
         color="${c_green}" 
      else 
         color=${c_red} 
      fi 
   else 
      return 0 
   fi 
   echo -ne $color 
} 

current_branch () 
{ 
  if git rev-parse --git-dir >/dev/null 2>&1 
  then 
    cur_br="${c_white}($(branch_color)$(parse_git_branch)${c_white})"
  else 
    return 0;
  fi 
  echo -ne $cur_br 
} 
 
export PS1='\[${c_bold}${c_green}\][\D{%Y-%m-%d %H:%M:%S}]\[${c_blue}\][\u@\h] \[${c_magenta}\]\w $(current_branch)\[${c_sgr0}\] \
\n\$ '

#
# }} SET PS1
# 
######################################################################


######################################################################
#
# {{ PROMPT
#

set -o vi

#
# }} PROMPT
# 
######################################################################


######################################################################
#
# {{ GPG related
#

function gpg-decrypt {
	gpg-zip --decrypt --output $* $*.pgp
}

function gpg-encrypt {
	gpg-zip --encrypt --output $*.pgp $*
}

#
# }} GPG related
# 
######################################################################


######################################################################
#
# {{ PROFILE
#

if [ -z "$ISSET_BASH_PROFILE" ]; then
	ISSET_BASH_PROFILE=1
	if [ -f ~/.bash_profile ]; then
		. ~/.bash_profile
	fi
fi

#
# }} PROFILE
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

