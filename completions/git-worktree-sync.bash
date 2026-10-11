# bash completion for git-worktree-sync                              -*- shell-script -*-
#
# Completes both `git worktree-sync ...` and `git-worktree-sync ...`. Install as
# ~/.local/share/bash-completion/completions/git-worktree-sync: git's completion lazy-loads
# it the first time `git worktree-sync` is completed, and bash-completion loads it for
# `git-worktree-sync` by name. Sourcing it from .bashrc also works.

# cur and prev are set by git's completion before it calls this function
# shellcheck disable=SC2154
_git_worktree_sync() {
	local subcommands="clone add commit push pull status"
	local subcommand
	subcommand="$(__git_find_on_cmdline "$subcommands")"

	if [ -z "$subcommand" ]; then
		case "$cur" in
			-*)
				__gitcomp "--help"
				;;
			*)
				__gitcomp "$subcommands"
				;;
		esac
		return
	fi

	# Empty COMPREPLY falls back to file and directory names
	case "$subcommand,$cur" in
		clone,*)
			# Repository URLs or paths, then the project directory
			;;
		add,-*)
			__gitcomp "--update"
			;;
		add,*)
			# Local files to sync
			;;
		commit,*)
			case "$prev" in
				-m | --message)
					# Free-form message
					;;
				*)
					__gitcomp "--message="
					;;
			esac
			;;
		pull,*)
			__gitcomp "--rebase"
			;;
		push,* | status,*)
			COMPREPLY=()
			;;
	esac
}

# Completing `git-worktree-sync` directly needs git's completion helpers loaded first
if ! declare -F __git_complete >/dev/null; then
	if declare -F _comp_load >/dev/null; then
		_comp_load git
	elif declare -F __load_completion >/dev/null; then
		__load_completion git
	fi
fi
if declare -F __git_complete >/dev/null; then
	__git_complete git-worktree-sync _git_worktree_sync
fi
