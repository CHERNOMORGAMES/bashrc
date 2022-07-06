#Bash alias collection by CHERNOMOR
#Append this to the end of ~/.bashrc or ~/.bash_aliases file (in your $HOME directory)
#Alt + . -> previous command hotkey
#Logout specific user pkill -KILL -U user

alias ls='ls -At --group-directories-first --color="always"'
cdls()
{
	builtin cd "$*"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias cd='cdls'
alias cl='clear'
alias cld='clear && cd'
alias home='cld $HOME'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
rmls()
{
	rm -rI "$*"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias del='rmls'
alias delete='del'
mkls()
{
	mkdir "$*"
	local RES=$?
	if [ "$RES" -eq 0 ]; then
		ls
	fi
}
alias mk='mkls'
alias cr='touch'
alias create='cr'
alias cp='cp -iv'
alias copy='rsync -ah --info=progress2'
alias mv='mv -iv'
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias now='date "+%x %A daynumber=%j unixtime=%s" && date -R && date -u'
alias open='xdg-open'
alias calc='bc -l'
alias mpass='openssl rand -base64 15'
alias mpass16='openssl rand -base64 12'
alias mpass20='mpass'
alias mpass128='openssl rand -base64 18'
alias mpass24='mpass128'
alias mpass256='openssl rand -base64 33'
alias mpass44='mpass256'
alias disk='df -hT --total --no-sync'
alias ports='netstat -tulap'
alias iports='netstat -tulanp'
alias ipublic='curl ipinfo.io/ip'
alias ram='free -hlt'
alias cpu='lscpu'
srch()
{
	grep -ril "$*" | xargs ls -t --full-time
}
alias search='srch'
alias match='grep -nori --color="always"'
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
alias phplocal='php -S 127.0.0.1:8000'
