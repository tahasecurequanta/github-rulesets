# github-rulesets

Ready-to-import **GitHub Rulesets** that lock down your repository: no direct pushes to `main`, no branch deletion, and no merging a pull request without an approving review.

Copy, tweak, import. No coding needed.

## What's included

| File | Target | What it does |
|------|--------|--------------|
| `protect-main.json` | default branch | Blocks direct push, deletion and force-push. Requires a PR with 1 approval, resolved conversations, and linear history. |
| `protect-release-branches.json` | `release/*`, `hotfix/*` | Same protections, with 2 approvals required. |
| `protect-tags.json` | `v*` tags | Makes release tags immutable (no delete or move). |
| `branch-naming.json` | all other branches | Enforces names like `feature/...`, `fix/...`, `chore/...`. |
| `commit-hygiene.json` | default branch | Enforces Conventional Commits messages. |
| `push-safety.json` | push rules | Blocks large files, `.env` files, and key/cert files. |
| `optional/protect-main-with-ci.json` | default branch | Requires CI checks and CodeQL. **Only use once CI exists.** |
| `apply-all.sh` | - | Applies all rulesets in the root folder via the GitHub CLI. |

## Quick start

### Option A: GitHub website

1. Open your repo, then **Settings** -> **Rules** -> **Rulesets**.
2. Click **New ruleset** -> **Import a ruleset**.
3. Upload a `.json` file from this repo.
4. Review the settings and click **Create**.
5. Repeat for each file. Start with `protect-main.json`.

### Option B: GitHub CLI (all at once)

```bash
gh auth login
git clone https://github.com/<your-username>/github-rulesets.git
cd github-rulesets
./apply-all.sh OWNER/REPO
```

Replace `OWNER/REPO` with the repository you want to protect. You need **admin** access to it.

## Before you apply

- **Working alone?** In `protect-main.json`, set `required_approving_review_count` to `0`. You can't approve your own PR.
- **CI checks:** in `optional/protect-main-with-ci.json`, replace `build`, `test`, `lint` with your real job names. If they don't match, PRs will be stuck forever.
- **Plans:** rulesets work on public repos for free. On private repos they need GitHub Pro, Team, or Enterprise. Push rulesets and some rules may need Team or Enterprise.
- **Test safely:** set `"enforcement": "evaluate"` (Enterprise) to see what would be blocked before enforcing.
- **Bypass:** `bypass_actors` is empty, so everyone (including admins) follows the rules. Add a role or team if you need an emergency escape hatch.

## Verify it works

After applying, try `git push origin main` directly. It should be rejected. Then open a PR: merging should be blocked until it has an approval.

## Recommended extras (outside rulesets)

- Add a `CODEOWNERS` file and protect `.github/workflows/`.
- Enable secret scanning and push protection.
- Enable Dependabot alerts and security updates.
- Set the default `GITHUB_TOKEN` permission to read-only.
- Require 2FA for all members.
- Auto-delete head branches after merge.

## Contributing

Issues and pull requests are welcome. Please keep each ruleset in its own JSON file and validate it with `python3 -m json.tool <file>` before submitting.

## Disclaimer

These are general-purpose templates provided as-is. Review them against your team's workflow before enforcing.

## License

MIT
