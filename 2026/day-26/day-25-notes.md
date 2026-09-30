Install the GitHub CLI on your machine
```bash
for windows: winget install --id GitHub.cli
```

Authenticate with your GitHub account
``` gh auth login
```
<img width="1047" height="602" alt="image" src="https://github.com/user-attachments/assets/f8be236a-ebf5-4d24-a24a-697fc3a33cc9" />

Verify you're logged in and check which account is active
<img width="1000" height="371" alt="image" src="https://github.com/user-attachments/assets/2374c6aa-dea7-46c1-b4fc-7fe646dc058e" />

Answer in your notes: What authentication methods does gh support?
>>for github gui in cli

## Task 2: Working with Repositories
View details of one of your repos from the terminal
```
gh repo list
```
<img width="1503" height="587" alt="image" src="https://github.com/user-attachments/assets/1f96e906-b849-4255-a9a1-23be195a0965" />

Open a repo in your browser directly from the terminal
```
gh repo view <repo name> --web
```
<img width="968" height="112" alt="image" src="https://github.com/user-attachments/assets/60ded07e-85dd-479b-9bad-fb91e1bae71e" />
## Task 3: Issues
============================================================================
# Day 26 – GitHub CLI: Manage GitHub from Your Terminal

## 📌 Overview

Today I learned how to use **GitHub CLI (`gh`)** to manage GitHub directly from the terminal.

Instead of switching between the terminal and browser for common GitHub tasks, `gh` allows me to manage:

* Repositories
* Issues
* Pull Requests
* GitHub Actions
* Releases
* Gists
* GitHub API
* Repository searches

This is especially useful for DevOps automation and CI/CD workflows.

---

# Task 1: Install and Authenticate

## Installation

On Windows, GitHub CLI can be installed using:

```bash
winget install --id GitHub.cli
```

Verify:

```bash
gh --version
```

## Authentication

```bash
gh auth login
```

I selected:

```text
GitHub.com
HTTPS
Login with a web browser
```

After authentication:

```bash
gh auth status
```

I can also check the currently authenticated account:

```bash
gh api user --jq '.login'
```

## Authentication Methods Supported by `gh`

GitHub CLI supports authentication through methods such as:

* Browser-based authentication
* Authentication using a personal access token
* Environment/token-based authentication for automation

For normal interactive usage, browser authentication is convenient.

---

# Task 2: Repository Management

## Create Repository

```bash
gh repo create day-26-gh-cli-demo --public --add-readme --clone
```

This creates a public repository with a README and clones it locally.

## View Repository

```bash
gh repo view
```

## List Repositories

```bash
gh repo list
```

## Open Repository in Browser

```bash
gh repo view --web
```

## Clone Repository

Instead of:

```bash
git clone <url>
```

I can use:

```bash
gh repo clone owner/repository
```

## Delete Repository

```bash
gh repo delete owner/day-26-gh-cli-demo --yes
```

This should be used carefully because repository deletion is destructive.

---

# Task 3: Issues

## Create Issue

```bash
gh issue create \
  --repo owner/repository \
  --title "GitHub CLI Practice" \
  --body "Testing GitHub issue management using gh CLI."
```

## List Issues

```bash
gh issue list --repo owner/repository
```

## View Issue

```bash
gh issue view 1 --repo owner/repository
```

## Close Issue

```bash
gh issue close 1 --repo owner/repository
```

## Automation Use Case

`gh issue` can be used in automation to automatically create GitHub issues when:

* CI/CD pipelines fail
* Deployments fail
* Security scans detect problems
* Monitoring detects an incident
* Scheduled jobs encounter errors

Example:

```bash
gh issue create \
  --title "Deployment Failed" \
  --body "Production deployment failed."
```

---

# Task 4: Pull Requests

## Create Branch

```bash
git switch -c day-26-gh-cli
```

## Make a Change

```bash
echo "GitHub CLI practice" >> day-26-demo.txt
```

## Commit

```bash
git add .
git commit -m "docs: add GitHub CLI practice"
```

## Push

```bash
git push -u origin day-26-gh-cli
```

## Create PR

```bash
gh pr create --fill
```

Or:

```bash
gh pr create \
  --base main \
  --head day-26-gh-cli \
  --title "Day 26 GitHub CLI Practice" \
  --body "Practice GitHub PR management using gh."
```

## List PRs

```bash
gh pr list
```

## View PR

```bash
gh pr view 1
```

## Check PR Status

```bash
gh pr status
```

## Check PR Checks

```bash
gh pr checks 1
```

## View PR Diff

```bash
gh pr diff 1
```

## Merge PR

Merge commit:

```bash
gh pr merge 1 --merge
```

Squash:

```bash
gh pr merge 1 --squash
```

Rebase:

```bash
gh pr merge 1 --rebase
```

### Merge methods supported

`gh pr merge` supports:

1. Merge commit
2. Squash merge
3. Rebase merge

---

# Reviewing Someone Else's PR

```bash
gh pr list --repo owner/repository
gh pr view 123 --repo owner/repository
gh pr diff 123 --repo owner/repository
gh pr checks 123 --repo owner/repository
```

These commands allow me to inspect the PR, review its changes and check CI results without opening the browser.

---

# Task 5: GitHub Actions

## List Workflow Runs

```bash
gh run list --repo owner/repository
```

## View Workflow Run

```bash
gh run view <run-id> --repo owner/repository
```

## View Failed Logs

```bash
gh run view <run-id> --repo owner/repository --log-failed
```

## List Workflows

```bash
gh workflow list --repo owner/repository
```

## View Workflow

```bash
gh workflow view <workflow-id> --repo owner/repository
```

## Trigger Workflow

If the workflow supports `workflow_dispatch`:

```bash
gh workflow run <workflow-id> --repo owner/repository
```

## CI/CD Use Case

`gh run` and `gh workflow` can be useful in CI/CD automation for:

* Checking deployment status
* Monitoring workflow runs
* Retrieving failed logs
* Triggering workflows
* Automating operational tasks

Example:

```text
Code Push
    ↓
GitHub Actions
    ↓
Build
    ↓
Test
    ↓
Security Scan
    ↓
Deploy
    ↓
Check workflow status
```

---

# Task 6: Useful GitHub CLI Tricks

## GitHub API

```bash
gh api user
```

```bash
gh api user --jq '.login'
```

```bash
gh api repos/owner/repository
```

---

## Gist

Create:

```bash
gh gist create file.txt
```

List:

```bash
gh gist list
```

View:

```bash
gh gist view <gist-id>
```

---

## Releases

List:

```bash
gh release list
```

Create:

```bash
gh release create v1.0.0 --generate-notes
```

View:

```bash
gh release view v1.0.0
```

---

## Aliases

Create an alias:

```bash
gh alias set prs 'pr list'
```

Use it:

```bash
gh prs
```

---

## Search Repositories

```bash
gh search repos kubernetes
```

Search by language:

```bash
gh search repos kubernetes --language go
```

---

# Important Commands Learned

```bash
gh auth login
gh auth status

gh repo create
gh repo clone
gh repo view
gh repo list
gh repo delete

gh issue create
gh issue list
gh issue view
gh issue close

gh pr create
gh pr list
gh pr view
gh pr status
gh pr checks
gh pr diff
gh pr merge

gh run list
gh run view

gh workflow list
gh workflow view
gh workflow run

gh api
gh gist
gh release
gh alias
gh search repos
```

---

# Key Learnings

Today I learned that GitHub CLI can bring many GitHub operations directly into the terminal.

The most useful commands for a DevOps workflow are:

```bash
gh pr
gh issue
gh run
gh workflow
gh api
```

The `--json` option is especially useful because it provides machine-readable output that can be consumed by scripts and automation.

GitHub CLI can therefore reduce manual browser operations and become useful for CI/CD, automation and repository management.

---

# 🚀 Day 26 Completed

I learned how to manage GitHub repositories, issues, pull requests and workflows directly from the terminal using GitHub CLI.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham #GitHubCLI #GitHub #DevOps #CI/CD
