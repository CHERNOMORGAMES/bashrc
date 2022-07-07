#Bash alias collection by CHERNOMOR (tested GNU bash, version 5.1.0(1)-release (x86_64-redhat-linux-gnu))
#Append this to the end of ~/.bashrc or ~/.bash_aliases file (in your $HOME directory)
#Alt + . -> previous command hotkey
#Logout specific user pkill -KILL -U user
#prefix 'command' works like 'not an alias' - it also works a bit faster.

alias iam='command echo I am: "$0" - with "$#" arguments: "$@"'

alias ls='command ls -At --group-directories-first --color="always"'
alias lsf='command ls -At --full-time --group-directories-first --color="always"'
alias list='command ls'

alias h='command history'
alias cl='command clear'

cdls()
{
	builtin cd "$@"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias cd='cdls'
alias cld='command clear; cd'
alias home='cld $HOME'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

rmls()
{
	command rm -rIv "$@"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias del='rmls'
alias delete='del'

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

alias empty='command touch'
alias create='command cat>'
alias cr='create'
alias edit='command nano'

alias cp='command cp -iv'
alias copy='command rsync -ah --info=progress2'
alias mv='command mv -iv'

alias path='command echo -e ${PATH//:/\\n}'
alias now='command date "+%x %A daynumber=%j unixtime=%s" && date -R && date -u'
alias open='command xdg-open'
alias calc='command bc -l'
show()
{
	type -a "$@"
	whereis "$@"
}

alias mpass='openssl rand -base64 15'
alias mpass16='openssl rand -base64 12'
alias mpass20='mpass'
alias mpass128='openssl rand -base64 18'
alias mpass24='mpass128'
alias mpass256='openssl rand -base64 33'
alias mpass44='mpass256'

alias disk='command df -hT --total --no-sync'
alias ram='command free -hlt'
alias cpu='command lscpu'

alias ports='command netstat -tulap'
alias iports='command netstat -tulanp'
alias ipublic='command curl ipinfo.io/ip'

alias phplocal='command php -S 127.0.0.1:8000'
alias phplocall='command php -S 0.0.0.0:8000'

srch()
{
	local DPT=$2
	if [ -z "$DPT" ]; then
		DPT=1
	fi
	local RPL
	until [[ $RPL =~ ^[Nn]$ ]]
	do
		echo Level "$DPT"
		command find -mindepth "$DPT" -maxdepth "$DPT" -iname "$1"
		read -rsp "Go deeper?(y/n) " -n 1 RPL
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
