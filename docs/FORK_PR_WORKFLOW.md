# Fork + Upstream PR Workflow

This fork tracks `VincentMeilinger/Nextcloud-Cookbook-iOS` as `upstream` and `laraandrew/Nextcloud-Cookbook-iOS` as `origin`.

## Daily flow

1. Sync with upstream:
   ```bash
   git fetch upstream
   git checkout main
   git merge --ff-only upstream/main
   git push origin main
   ```
2. Create one focused branch per change:
   ```bash
   git checkout -b fix/<short-name>
   ```
3. Keep PRs small (single bug/doc/cleanup scope).
4. Push branch and open PR against this fork's `main` first.
5. After validation, open upstream PR from fork branch.

## Scope guardrails

- Prefer <200 changed lines when possible.
- Do not mix unrelated refactors into bug fixes.
- Include a short test/verification note in each PR.
