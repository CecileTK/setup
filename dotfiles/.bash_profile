# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Autocomplete Grunt commands
which grunt > /dev/null && eval "$(grunt --completion=bash)"

# Hide Terminal warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Load pip and set python path
export PYTHONPATH="$(brew --prefix)/bin/"

# NPM
export PATH=~/.npm-global/bin:$PATH

# GPG
export GPG_TTY=$(tty)

# Ruby
export PATH="/opt/homebrew/opt/ruby@2.7/bin:$PATH"

# Python
export PATH="/opt/homebrew/opt/python/bin:$PATH"
export PYTHONPATH="/opt/homebrew/opt/python/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ctrankie/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ctrankie/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ctrankie/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ctrankie/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

