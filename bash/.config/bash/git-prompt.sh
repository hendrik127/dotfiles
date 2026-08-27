# Show the current git branch (or short commit if detached) in the prompt.
__git_branch() {
    local ref
    ref=$(git symbolic-ref --short HEAD 2>/dev/null) || ref=$(git rev-parse --short HEAD 2>/dev/null) || return
    printf ' (%s)' "$ref"
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(__git_branch)\[\033[00m\]\$ '
