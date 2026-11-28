import tempfile
import unittest
from pathlib import Path

from cask_checksums import problems


def run(sha: str) -> list[str]:
    with tempfile.TemporaryDirectory() as tmp:
        (Path(tmp) / "Casks").mkdir()
        (Path(tmp) / "Casks" / "demo.rb").write_text(f'cask "demo" do\n  sha256 "{sha}"\nend\n')
        return problems(Path(tmp))


class CaskChecksums(unittest.TestCase):
    def test_all_zero_fails(self):
        self.assertTrue(run("0" * 64))

    def test_empty_fails(self):
        self.assertTrue(run(""))

    def test_real_digest_passes(self):
        self.assertEqual(run("ab12" * 16), [])


if __name__ == "__main__":
    unittest.main()
