# Custom git aliases

function git_current_branch () {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function git_current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

alias gst="git status"
alias gb="git branch --sort=-committerdate"
alias gco="git checkout"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
# TODO: Bind to a key commbination to use the commit hash with other commands like 'git rebase -i <key comb>'
# alias glof="git log --pretty=oneline --abbrev-commit --color=always | fzf --ansi --preview 'echo {} | cut -f 1 -d \" \" | xargs git show --color=always --stat'"
alias glof="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --color=always | fzf --ansi --preview 'echo {} | cut -f 1 -d \" \" | xargs git show --color=always --stat'"
alias gc="git commit"
alias gcmsg="git commit -m"
alias gsb='git status -sb'

# pull/push on the current branch
alias ggpull='git pull origin $(git_current_branch)'
alias ggpur='git pull --rebase origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'

# Check the lastest commit(head)
alias ghead="git --no-pager log --decorate=short --pretty=oneline --abbrev-commit -n1"

# Save your WIP work as a commit
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "--wip--" && git reset HEAD~1'

# Stash staged changes
alias gsts='git stash -- $(git diff --staged --name-only)'

# get rid of deleted branches on origin
alias gfa='git fetch --all --prune'
# delete merged local branches
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

# You are working in a feature when you happen to discover a bug completely
# unrelated to the feature. You can easily fix this bug. What do you do?
# 
# gmove bugfix master
# 
# This will create a branch called bugfix based off master with only the bug fix.
gmove() {
  git stash -- $(git diff --staged --name-only) &&
  gwip ; # ensure the alias gwip is defined above
  git branch $1 $2 &&
  git checkout $1 &&
  git stash pop
}

# git fetch and checkout the branch
gfco() {
  git fetch origin $1 && git checkout $1
}

# git checkout a branch and pull the latest changes
gpco() {
  git checkout $1 && git pull origin $1
}

# git checkout fuzzy
function gcof() {
    local preview='git log --graph --abbrev-commit --color=always --pretty=format:"%C(auto)%h %d %s %C(green)(%cr) %C(bold blue)<%an>%Creset" --date=relative {}'
    local branch=$(git branch --sort=committerdate --format='%(refname:short)' | fzf --reverse --preview $preview) && \
    git checkout $branch
}


# WIP
# gf_branches() {
#     local preview='git log --graph --abbrev-commit --color=always --pretty=format:"%C(auto)%h %d %s %C(green)(%cr) %C(bold blue)<%an>%Creset" --date=relative {}'
#     local branch=$(git branch --format='%(refname:short)' | fzf --preview $preview) && \
#       echo "$branch"
# }
#
# git_checkout_with_fzf() {
#     local branch
#     branch=$(gf_branches)
#     if [ -n "$branch" ]; then
#         git checkout "$branch"
#     fi
# }
#
# # Bind the function to a key combination
# bindkey '^X' git_checkout_with_fzf



# git branch fuzzy
alias gbf="git branch --sort=-committerdate | fzf --reverse"

# git diff fuzzy
gdf() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf --reverse -m --ansi --preview $preview
}

# git add fuzzy
gaf() {
  preview="git diff $@ --color=always -- {-1}"
  git ls-files -m -o --exclude-standard | fzf --reverse --print0 -m --ansi --preview $preview | xargs -0 -t -o git add
}

# git filter files 
gfilter() {
  git diff --name-only --diff-filter=$@ --relative
}
