autoload -U compinit && compinit -i
# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# format the vcs_info_msg_0_ variable 
zstyle ':vcs_info:git:*' formats '%F{red}%b%f ' 

# set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_}%% ' 
