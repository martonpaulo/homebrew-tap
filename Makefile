# The gate: run `make check` before every commit; Validate runs the same target on each push.
.PHONY: check dry style text casks

check: text casks dry style

# Repository text: invisible characters, relative links and anchors, issue references as links.
text:
	python3 scripts/text_check.py .
	python3 scripts/issue_links.py .

# No cask with a placeholder sha256.
casks:
	python3 checks/cask_checksums.py --root .
	cd checks && python3 -m unittest -q

# No new magic value, repeated block or rule written twice (counts in dry-check.json only go down).
dry:
	python3 scripts/dry_check.py

# Homebrew's own cask style rules. The files must sit in Casks/ to be checked as casks.
style:
	HOMEBREW_NO_AUTO_UPDATE=1 brew style Casks/*.rb
