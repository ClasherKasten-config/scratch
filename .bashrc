# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# it's unclear why this changed between 18.04 and 20.04
umask 0022

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=-1
HISTFILESIZE=-1

command_not_found_handle() {
    if [ -x "venv/bin/$1" ]; then
        echo 'you forgot to activate ./venv -- I gotchu' 1>&2
        exe="venv/bin/$1"
        shift
        "$exe" "$@"
        return $?
    else
        echo "$0: $1: command not found" 1>&2
        return 127
    fi
}

# PS1='\[\e]0;\u@\h: \w\a\]\[\033[1;92m\]\u@\h\[\033[m\]:\[\033[1;94m\]\w\[\033[m\]\n\$ '

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"
[ -f /etc/bash_completion ] && . /etc/bash_completion

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -d "$HOME/bin" ] && export PATH="${HOME}/bin:${PATH}"

PROMPT_COMMAND='if [ -d .git -a ! -x .git/hooks/pre-commit -a -e .pre-commit-config.yaml ] && command -v pre-commit >& /dev/null; then pre-commit install --hook-type pre-commit; fi; '"$PROMPT_COMMAND"
eval "$(aactivator init)"

export PYTHONSTARTUP=~/.pythonrc.py
export EDITOR=babi VISUAL=babi

export PIP_DISABLE_PIP_VERSION_CHECK=1
export VIRTUALENV_NO_PERIODIC_UPDATE=1

if [ -d ~/.bashrc.d ]; then
    for f in ~/.bashrc.d/*.sh; do
        . "$f"
    done
    unset f
fi


# oh-my-bash config
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="-i -e -m"

# Path to your oh-my-bash installation.
export OSH='/home/clasherkasten/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline-multiline"

# Uncomment the following line to use case-sensitive completion.
OMB_CASE_SENSITIVE="true"

OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
  pip
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source "$OSH"/oh-my-bash.sh
