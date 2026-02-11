alias l="ls"
alias la="ls -la"
alias ll="ls -alhF"
alias lsd='ls -l | grep "^d"'

alias ..='cd ..'
alias ...='cd ../..'

alias mkdir='mkdir -pv'
alias cp="cp -r"
alias rm="rm -rf"

alias cdu="cd ~/ws/mfg_diag/u-boot"
alias cds="cd ~/ws/scm3000mgx"
alias cdb="cd ~/ws/barcli"
alias ct="touch .hg"

alias reload_bash="source ~/.bashrc"
alias reload_tmux="tmux source-file ~/.tmux.conf"

# alias v="/usr/bin/vim"
# alias vi="/usr/bin/vim"
# alias vim="/usr/bin/vim"

# alias v="$HOME/local/bin/vim"
# alias vi="$HOME/local/bin/vim"
# alias vim="$HOME/local/bin/vim"

#alias v="$HOME/.local/bin/vim"
#alias vi="$HOME/.local/bin/vim"
#alias vim="$HOME/.local/bin/vim"

# alias ctags="$HOME/.local/bin/ctags"

alias edbash="vi ~/.bashrc"
alias edvim="vi ~/.vimrc"
alias edtmux="vi ~/.tmux.conf"
alias edalias="vi ~/.bash_aliases"
alias edpath="vi ~/.vimrc.path"
alias edplug="vi ~/.vimrc.plug"
alias reload_alias="source ~/.bash_aliases"
alias new_tmux="tmux new -s "
alias go_tmux="tmux at -t "
alias delete_tmux="tmux kill-session -t "

alias fzf="fzf --preview 'bat --style=numbers --color=always --theme=Dracula --line-range :500 {}'"

alias prov_tool="python3 -m tools.tooling provision"
alias prov_env="source /User_data/home/axiado-2561/ws/barcli/provision/prov_env/bin/activate"
# alias prov_env="source /User_data/home/axiado-2561/tmp_env/bin/activate"
# alias re_env="pip install ~/provision_tools-1.1.0.tar.gz"
