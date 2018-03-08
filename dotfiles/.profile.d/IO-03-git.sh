# -*- coding: utf-8 -*-

# Git branch.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Git shortcuts / aliases
alias g='git'
alias gco='git checkout'
alias gs='git status'
alias pull='git pull'
alias push='git push'
alias gpull='git pull'
alias gpush='git push'
alias firstpush='git push -u origin $( git symbolic-ref --short HEAD )'

# m2m [branch_name]
# Merge active branch into [branch_name] (defaults to "master")
m2m() {
  GIT_CUR_BRANCH="$( git symbolic-ref --short HEAD )"
  GIT_REF_BRANCH="$1"
  if [ "x$GIT_REF_BRANCH" == "x" ]; then
    GIT_REF_BRANCH="master"
  fi
  git show-ref --verify --quiet "refs/heads/$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then
    echo "Target branch not found: $GIT_REF_BRANCH"
    return 23
  fi
  git checkout "$GIT_REF_BRANCH" && git merge --no-ff "$GIT_CUR_BRANCH"
}

# gsync [branch_name]
# Fetch and merge [branch_name] into itself (defaults to master),
# and then merge it into the active branch.
# Note: [branch_name] must have a remote tracking branch set.
gsync() {
  GIT_CUR_BRANCH="$( git symbolic-ref --short HEAD )"
  GIT_REF_BRANCH="$1"
  if [ "x$GIT_REF_BRANCH" == "x" ]; then
    GIT_REF_BRANCH="master"
  fi
  git show-ref --verify --quiet "refs/heads/$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then
    echo "Reference branch not found: $GIT_REF_BRANCH"
    return 23
  fi
  if [ "$GIT_CUR_BRANCH" == "$GIT_REF_BRANCH" ]; then
    echo "Just pulling $GIT_REF_BRANCH ..."
    git pull
    return $?
  fi
  git checkout "$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then return 41; fi
  git pull
  if [ $? -ne 0 ]; then return 42; fi
  git checkout "$GIT_CUR_BRANCH"
  if [ $? -ne 0 ]; then return 43; fi
  git merge "$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then return 44; fi
}

# gbase [branch_name]
# Fetch and merge [branch_name] into itself (defaults to master),
# and then rebase the active branch onto it.
# Note: [branch_name] must have a remote tracking branch set.
gbase() {
  GIT_CUR_BRANCH="$( git symbolic-ref --short HEAD )"
  GIT_REF_BRANCH="$1"
  if [ "x$GIT_REF_BRANCH" == "x" ]; then
    GIT_REF_BRANCH="master"
  fi
  git show-ref --verify --quiet "refs/heads/$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then
    echo "Reference branch not found: $GIT_REF_BRANCH"
    return 23
  fi
  if [ "$GIT_CUR_BRANCH" == "$GIT_REF_BRANCH" ]; then
    echo "Just pulling $GIT_REF_BRANCH ..."
    git pull
    return $?
  fi
  git checkout "$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then return 41; fi
  git pull
  if [ $? -ne 0 ]; then return 42; fi
  git checkout "$GIT_CUR_BRANCH"
  if [ $? -ne 0 ]; then return 43; fi
  git rebase -i "$GIT_REF_BRANCH"
  if [ $? -ne 0 ]; then return 44; fi
}
