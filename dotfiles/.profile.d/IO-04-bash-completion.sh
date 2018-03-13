if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# awscli completions
complete -C '/usr/local/bin/aws_completer' aws

# ybt argcomplete
eval "$(register-python-argcomplete ybt)"

# kubectl completions
source <(kubectl completion bash)
