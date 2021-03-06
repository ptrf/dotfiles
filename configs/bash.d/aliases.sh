#
## Generic aliases
#
# Easier navigation: .., ..., ...., ....., ~ and -

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Shortcuts
alias more=$PAGER
alias less=$PAGER
alias screen="screen -U"
alias sshnocheck="ssh -o StrictHostKeyChecking=no -o CheckHostIP=no"
alias uhfexit='unset HISTFILE ; exit'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'


# IP addresses
alias ip="curl ip.tyk.dk"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"



# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Recursively delete `.DS_Store` files
alias ds_store_cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

#
### ls specifics
#

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Enable aliases to be sudo’ed
alias sudo='sudo '



#
## Mac OS X specifics
#
if [[ "$MY_SYSTEM_KERNEL" = "Darwin" ]] ; then

    # Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
    alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup'

    # Flush Directory Service cache
    alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"

    # Clean up LaunchServices to remove duplicates in the “Open With” menu
    alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

    # Trim new lines and copy to clipboard
    alias c="tr -d '\n' | pbcopy"

    # Empty the Trash on all mounted volumes and the main HDD
    # Also, clear Apple’s System Logs to improve shell startup speed
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

    # Show/hide hidden files in Finder
    alias show_all_files="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hide_all_files="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

    # Hide/show all desktop icons (useful when presenting)
    alias hide_desktop_icon="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
    alias show_desktop_icon="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

    # Merge PDF files
    # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
    alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

    # Disable Spotlight
    alias spotoff="sudo mdutil -a -i off"
    # Enable Spotlight
    alias spoton="sudo mdutil -a -i on"

    # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
    alias plistbuddy="/usr/libexec/PlistBuddy"

    # Stuff I never really use but cannot delete either because of http://xkcd.com/530/
    alias stfu="osascript -e 'set volume output muted true'"

    # JavaScriptCore REPL
    jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
    [ -e "${jscbin}" ] && alias jsc="${jscbin}"
    unset jscbin

    # MPlayerX setup
    alias mplayerx="open -a /Applications/MPlayerX.app/ "

    # Lock the screen (when going AFK)
    alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi


#
## FreeBSD specifics
#

if [[ "$MY_SYSTEM_KERNEL" = "FreeBSD" ]] ; then

fi
