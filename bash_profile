#!/bin/bash

############################################################################
# General environment setup
export PATH="/usr/local/opt/python/libexec/bin:~/go/bin:$PATH"
alias ls="ls -G"

############################################################################
# Enable git aware prompts to display the current branch
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\[$txtred\]\u@\h \w \[$txtcyn\]\$git_branch\[$txtylw\]\$git_dirty\[$txtred\] # \[$txtrst\]"

############################################################################
# Add more bash history and change to ensure that all bash sessions
# append to history instead of chomping others
export HISTSIZE=5000
export HISTFILESIZE=10000
shopt -s histappend
############################################################################

############################################################################
# SSH Agent Setup
# Sets up the agent only once and saves off the environment for future bash
# sesssions. Also creates functions to be able to restart if needed.
SSH_ENV="$HOME/.ssh/environment"
# If you want to use 'ssh-add -c' to prompt for restricted agent keys,
# uncomment this line and make sure that ssh-askpass is installed.
# You may need to update with correct path based on OS if type is failing
#export SSH_ASKPASS=$(type -p ssh-askpass)

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add # Default
    # Add other key files here
}

function restart_agent {
    echo "Restarting SSH agent..."
    killall ssh-agent
    rm -f "${SSH_ENV}"
    start_agent;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
############################################################################
