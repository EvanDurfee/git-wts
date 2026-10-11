# Changelog

## [0.2.0] - 2026-10-11

### Changed

- Renamed from `git-wts` to `git-worktree-sync`, so the command is now
  `git worktree-sync`. The script, completions, man page and
  `share/git-worktree-sync/hooks` directory are renamed to match; reinstall
  them under the new names. Hooks already installed in existing projects keep
  working, though their messages still refer to `git-wts`.
- The man page is now written in AsciiDoc (`man/git-worktree-sync.adoc`) and
  built with Asciidoctor.

### Added

- Release tarballs on GitHub, with the man page prebuilt.

## [0.1.0] - 2026-10-10

_Initial release._

[0.2.0]: https://github.com/EvanDurfee/git-worktree-sync/releases/tag/v0.2.0
[0.1.0]: https://github.com/EvanDurfee/git-worktree-sync/releases/tag/v0.1.0
