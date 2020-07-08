# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Self-explanatory
swiftlint.strict = true
swiftlint.lint_files inline_mode: true fail_on_error: true
