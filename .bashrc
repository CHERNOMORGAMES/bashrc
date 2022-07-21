#Bash alias collection by CHERNOMOR (tested GNU bash, version 5.1.16(1) - Pop!_OS)
#Append this to the end of ~/.bashrc or ~/.bash_aliases file in your $HOME directory
#Or to the end of /etc/bash.bashrc file to make it global
#Or to the end of /root/.bashrc to make it work after 'sudo -i'
#Alt + . -> previous command hotkey
#Logout specific user pkill -KILL -U user
#prefix 'command' works like 'not an alias' - it also works a bit faster.

# BEGIN
builtin echo -e '                        \033[1;36m--- Aliases operational ---\033[0m'
#for debug
alias iam='builtin echo I am: "$0" - with "$#" arguments: "$@" - exitcode "$?"'
##

# SUDO
execsudo()
{
	if [[ "$1" = "-"* ]]; then
		sudo "$@"
	elif [ "$(type -t $1)" = "function" ]; then
		local ARGS="$@"
		sudo bash -c "$(declare -f $1); $ARGS"
	elif [ "$1" = "command" ] || [ "$1" = "builtin" ]; then
		shift
		sudo bash -i <<<"$@"
	else
		sudo bash -i <<<"$@"
	fi
}
alias sudo='execsudo '

#backup for default sudo - it also wont use aliases if /root/.bashrc wasn't modified
alias please='command sudo'
##

# LS
alias here='builtin pwd'
alias ls='ls -AtF --group-directories-first --color="always"'
alias lsf='ls -h --full-time'
alias list='command ls'
#I want pwd and ls right from start
here; ls
##

# TERMINAL OUTPUT
alias h='builtin history'
alias cl='command clear'
##

# CD
cdls()
{
	builtin cd "$@"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		builtin pwd
		ls
	fi
}
alias cd='cdls'

alias cld='command clear; cd'
alias home='cld $HOME'
alias back='cd -'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
##

# COPY
alias cp='command cp -v'
alias copy='command rsync -ah --info=progress2'
alias mv='command mv -v'
##

# DELETION
rmls()
{
	command rm -rIv "$@"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias erz='rmls'
alias eraze='erz'
#gnome only
safedel()
{
	command realpath "$1"
	command gio trash "$@"
	builtin echo deleted
}
alias del='safedel'
alias delete='del'
##

# CREATION
verbdd()
{
	local IF="$1"; local OF="$2"
	IF="${IF:3}"; OF="${OF:3}"
	shift; shift
	builtin echo Please, double check dd parameters...
	local CHK
	builtin read -p "Input File = ${IF} ?(y/n) " CHK
	if [[ ! "$CHK" =~ ^[Yy]$ ]]; then
		builtin echo dd canceled; return
	fi
	builtin read -p "Output File = ${OF} ?(y/n) " CHK
	if [[ ! "$CHK" =~ ^[Yy]$ ]]; then
		builtin echo dd canceled; return
	fi
	builtin echo !!!Warning!!!
	builtin echo Overwriting this file: "${OF}"
	builtin read -p "Are you sure?(y/n) " CHK
	if [[ "$CHK" =~ ^[Yy]$ ]]; then
		command dd if="$IF" of="$OF" status=progress "$@"
		builtin echo dd finished; return
	fi
	builtin echo dd canceled
	return
}
alias dd='verbdd'

mkls()
{
	command mkdir -v "$@"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias mk='mkls'

mkcd()
{
	command mkdir -v "$@"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		cd "${@: -1}"
	fi
}
alias md='mkcd'

alias new='command touch'

createfile()
{
	builtin echo Enter text, press Ctrl+D to save...
	command cat > "$@"
	command realpath "$1"
}
alias create='createfile'
alias cr='create'

#alias editor='command nano' #I have it default in Pop!_OS
alias view='command vi'
alias reader='command less'
##

# INFO
alias vars='builtin set'
alias path='builtin echo -e ${PATH//:/\\n}'
alias now='command date "+%x %A daynumber=%j unixtime=%s" && date -R && date -u'

show()
{
	builtin type -a "$@"
	command whereis "$@"
}
alias showme='show'

srch()
{
	local DPT=$2
	if [ -z "$DPT" ]; then
		DPT=1
	fi
	local RPL
	until [[ $RPL =~ ^[Nn]$ ]]; do
		builtin echo Level "$DPT"
		command find -mindepth "$DPT" -maxdepth "$DPT" -iname "$1"
		builtin read -rsp "Go deeper?(y/n) " -n 1 RPL
		DPT=$((DPT + 1))
	done
	echo
}
alias search='srch'

chck()
{
	command grep -ilr "$@" | command xargs ls -t --full-time
}
alias check='chck'

alias match='command grep -inor --color="always"'
##

# UTILITY
alias mpass='openssl rand -base64 15'
alias mpass16='openssl rand -base64 12'
alias mpass20='mpass'
alias mpass128='openssl rand -base64 18'
alias mpass24='mpass128'
alias mpass256='openssl rand -base64 33'
alias mpass44='mpass256'
alias open='command xdg-open'
alias calc='command bc -l'
##

# SYSTEM INFO
alias ram='command free -hlt'
alias cpu='command lscpu'
alias space='command df -hT --total --no-sync'
alias dvcs='command lsblk -p'
alias device='dvcs'
alias disk='command fdisk -l'
##

# NETWORK INFO
alias ports='command netstat -tulap'
alias iports='command netstat -tulanp'
alias ipublic='command curl ipinfo.io/ip'
##

# NETWORK UTILITY
alias phplocal='command php -S 127.0.0.1:8000'
alias phplocall='command php -S 0.0.0.0:8000'
alias pconsole='command php -a'
alias nconsole='node .editor'
##

#PHP virus code (Hector shell) search (need more testing)
alias phps1='grep -ril --include=*.php -e "'base'.(128/2).'_de'.'code'" -e "(128/2)" | xargs ls -t --full-time'
alias phps2='grep -ril --include=*.php -e "'base'.(128/2).'_de'.'code'" -e "(128/2)" -e "base64_decode" | xargs ls -t --full-time'
alias phpm1='grep -nori --include=*.php -e "'base'.(128/2).'_de'.'code'" -e "(128/2)"'
alias phpm2='grep -nori --include=*.php -e "'base'.(128/2).'_de'.'code'" -e "(128/2)" -e "base64_decode"'
#Not tested
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cputime='ps uxga | sort --key=3.1 -n'
alias ipt='sudo /sbin/iptables'
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist
#
