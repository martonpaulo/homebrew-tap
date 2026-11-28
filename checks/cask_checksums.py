#!/usr/bin/env python3
"""Fail when a cask has a missing, malformed or all-zero sha256 (a placeholder)."""
import argparse
import re
import sys
from pathlib import Path

SHA_LINE = re.compile(r'^\s*sha256\s+"([^"]*)"', re.MULTILINE)
VALID = re.compile(r"^[0-9a-f]{64}$")


def problems(root: Path) -> list[str]:
    found = []
    for cask in sorted((root / "Casks").glob("*.rb")):
        match = SHA_LINE.search(cask.read_text())
        if not match:
            found.append(f"{cask}: no sha256 line")
        elif not VALID.match(match.group(1)) or set(match.group(1)) == {"0"}:
            found.append(f"{cask}: sha256 is empty, malformed or a placeholder")
    return found


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", default=".")
    found = problems(Path(parser.parse_args().root))
    print("\n".join(found))
    return 1 if found else 0


if __name__ == "__main__":
    sys.exit(main())
