# bash completion for git-wts                              -*- shell-script -*-
#
# Completes both `git wts ...` and `git-wts ...`. Install as
# ~/.local/share/bash-completion/completions/git-wts: git's completion lazy-loads
# it the first time `git wts` is completed, and bash-completion loads it for
# `git-wts` by name. Sourcing it from .bashrc also works.

_git_wts() {
	local subcommands="clone add commit push pull"
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
		push,*)
			COMPREPLY=()
			;;
	esac
}

# Completing `git-wts` directly needs git's completion helpers loaded first
if ! declare -F __git_complete >/dev/null; then
	if declare -F _comp_load >/dev/null; then
		_comp_load git
	elif declare -F __load_completion >/dev/null; then
		__load_completion git
	fi
fi
if declare -F __git_complete >/dev/null; then
	__git_complete git-wts _git_wts
fi
