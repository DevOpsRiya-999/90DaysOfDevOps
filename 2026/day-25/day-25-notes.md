# Day 25 – Git Reset vs Revert & Branching Strategies

## 📌 Overview

Today I learned how to safely undo changes in Git using:

* `git reset`
* `git revert`
* `git reflog`

I also explored different branching strategies used by software engineering teams:

* GitFlow
* GitHub Flow
* Trunk-Based Development

---

# Task 1: Git Reset – Hands-On

## 1. Create 3 commits

I created three commits in my practice repository:

```bash
echo "Commit A" > reset-demo.txt
git add reset-demo.txt
git commit -m "Commit A"

echo "Commit B" >> reset-demo.txt
git add reset-demo.txt
git commit -m "Commit B"

echo "Commit C" >> reset-demo.txt
git add reset-demo.txt
git commit -m "Commit C"
```

Check the history:

```bash
git log --oneline
```

Example:

```text
c333333 Commit C
b222222 Commit B
a111111 Commit A
```

---

## 2. `git reset --soft`

Command:

```bash
git reset --soft HEAD~1
```

This moves `HEAD` back by one commit but keeps the changes from that commit **staged**.

Check:

```bash
git status
```

The changes from Commit C will appear under:

```text
Changes to be committed
```

### Observation

* Commit C is removed from the current branch history.
* Changes are preserved.
* Changes remain in the staging area.
* Nothing is lost.

### Use case

Use `--soft` when I want to undo a commit but keep the changes ready to recommit.

---

## 3. `git reset --mixed`

First, recommit the changes:

```bash
git add .
git commit -m "Commit C again"
```

Then:

```bash
git reset --mixed HEAD~1
```

`--mixed` is the default reset mode.

### Observation

* The commit is removed from the current branch history.
* Changes are preserved.
* Changes are removed from the staging area.
* Working-directory files remain unchanged.

Check:

```bash
git status
```

The changes will appear as:

```text
Changes not staged for commit
```

### Use case

Use `--mixed` when I want to undo a commit and review or modify the changes before staging them again.

---

## 4. `git reset --hard`

First, recommit:

```bash
git add .
git commit -m "Commit C again"
```

Then:

```bash
git reset --hard HEAD~1
```

### Observation

* The commit is removed from the current branch history.
* Staged changes are removed.
* Working-directory changes are also discarded.
* Uncommitted changes can be lost.

This is the most dangerous reset option.

### Important

Before using `--hard`, make sure the changes are not needed.

If a reset was accidental, `git reflog` may help recover the previous commit.

```bash
git reflog
```

Then, if necessary:

```bash
git reset --hard <commit-id>
```

---

# Reset Options Comparison

| Option    | Commit | Staging Area        | Working Directory |
| --------- | ------ | ------------------- | ----------------- |
| `--soft`  | Reset  | Changes kept staged | Changes kept      |
| `--mixed` | Reset  | Changes unstaged    | Changes kept      |
| `--hard`  | Reset  | Changes removed     | Changes removed   |

---

## Which reset is destructive?

```bash
git reset --hard
```

is destructive because it can discard changes from the staging area and working directory.

However, Git may still allow recovery through the reflog if the objects have not been garbage-collected.

---

## When would I use each?

### `--soft`

When I want to:

* Undo the last commit
* Keep all changes staged
* Create a new clean commit

Example:

```bash
git reset --soft HEAD~1
```

### `--mixed`

When I want to:

* Undo a commit
* Keep the changes
* Review or modify files before committing again

Example:

```bash
git reset HEAD~1
```

### `--hard`

When I want to:

* Completely discard local changes
* Return my working tree to an earlier commit

Example:

```bash
git reset --hard HEAD~1
```

I should use this carefully.

---

## Should I use `git reset` on already-pushed commits?

Generally, **no for shared branches**.

`git reset` changes branch history. If the commit has already been pushed, resetting and force-pushing can cause problems for other developers.

For a shared branch such as `main`, I would normally use:

```bash
git revert <commit-id>
```

instead.

---

# Task 2: Git Revert – Hands-On

## 1. Create three commits

```bash
echo "Commit X" > revert-demo.txt
git add .
git commit -m "Commit X"

echo "Commit Y" >> revert-demo.txt
git add .
git commit -m "Commit Y"

echo "Commit Z" >> revert-demo.txt
git add .
git commit -m "Commit Z"
```

Check:

```bash
git log --oneline
```

Example:

```text
zzz333 Commit Z
yyy222 Commit Y
xxx111 Commit X
```

---

## 2. Revert Commit Y

Get the commit ID:

```bash
git log --oneline
```

Then:

```bash
git revert <commit-Y-id>
```

Git creates a **new commit** that reverses the changes introduced by Commit Y.

---

## 3. Check Git history

```bash
git log --oneline
```

The original Commit Y is still present.

Example:

```text
rrr444 Revert "Commit Y"
zzz333 Commit Z
yyy222 Commit Y
xxx111 Commit X
```

### Observation

`git revert` does not delete Commit Y.

Instead, it creates another commit that reverses Commit Y.

---

# Reset vs Revert

## `git reset`

`git reset` moves the branch pointer to another commit.

Example:

```text
Before:

A ---- B ---- C
             ↑
            HEAD

After reset:

A ---- B
       ↑
      HEAD
```

Commit C is no longer part of the current branch history.

---

## `git revert`

`git revert` creates a new commit that reverses an earlier commit.

```text
Before:

A ---- B ---- C

After revert B:

A ---- B ---- C ---- R
                     ↑
                  Revert B
```

The original B remains in history.

---

## Why is revert safer for shared branches?

Because `git revert` does not rewrite existing history.

It adds a new commit.

This means other developers who already pulled the original commit can continue working without their local history becoming inconsistent.

---

# Task 3: Reset vs Revert Summary

|                                  | `git reset`                                   | `git revert`                                         |
| -------------------------------- | --------------------------------------------- | ---------------------------------------------------- |
| What it does                     | Moves branch pointer to another commit        | Creates a new commit that reverses an earlier commit |
| Removes commit from history?     | Can remove it from the current branch history | No                                                   |
| Safe for shared/pushed branches? | Generally no                                  | Yes, normally safer                                  |
| When to use                      | Local/unshared history cleanup                | Undo changes on shared branches                      |

---

# Task 4: Branching Strategies

# 1. GitFlow

GitFlow uses several branch types for different stages of development.

Typical branches:

```text
main
  |
  +---- develop
          |
          +---- feature/login
          |
          +---- feature/payment
          |
          +---- release/1.0
          |
          +---- hotfix/critical-fix
```

Typical flow:

```text
feature/* 
    ↓
 develop
    ↓
 release/*
    ↓
 main
```

Hotfixes can be created from `main`:

```text
main
 |
 +---- hotfix/*
          |
          +---- main
          |
          +---- develop
```

### Where it is used

GitFlow can be useful for projects that:

* Have scheduled releases
* Need release branches
* Maintain multiple supported versions
* Have formal release processes

### Pros

* Clear separation between development and production
* Dedicated release branches
* Dedicated hotfix process
* Useful for scheduled release cycles

### Cons

* More branches to maintain
* More complex workflow
* More merge overhead
* Can slow teams that release continuously

---

# 2. GitHub Flow

GitHub Flow is a simpler branching model.

Usually there is one primary branch, commonly:

```text
main
```

Developers create short-lived feature branches.

```text
             feature/login
                  |
                  v
main ------------+------------>
                  |
                  PR
                  |
                  v
                 main
```

Typical workflow:

```bash
git switch main
git pull

git switch -c feature/login

# Make changes

git add .
git commit -m "Add login feature"

git push -u origin feature/login
```

Then a Pull Request is opened and reviewed before merging.

### Where it is used

Useful for teams that:

* Deploy frequently
* Use Pull Requests
* Prefer a simple workflow
* Practice continuous delivery

### Pros

* Simple
* Easy to understand
* Less branch management
* Works well with CI/CD
* Encourages small Pull Requests

### Cons

* Requires good CI/CD
* Requires strong code review practices
* Releases may need additional process for projects with strict release schedules

---

# 3. Trunk-Based Development

In Trunk-Based Development, developers integrate their work into a shared main branch frequently.

Branches, if used, are usually very short-lived.

```text
Developer A ----\
                 \
Developer B ------> main/trunk
                 /
Developer C ----/
```

Example:

```text
main
 |
 +--- small feature branch
 |          |
 |          +--- PR
 |               |
 +---------------+
```

The goal is to avoid long-running branches.

### Where it is used

Commonly associated with:

* Continuous Integration
* Continuous Delivery
* Frequent releases
* Teams that integrate code regularly

### Pros

* Small integration changes
* Fewer merge conflicts
* Fast feedback
* Works well with CI/CD
* Encourages frequent integration

### Cons

* Requires strong automated testing
* Requires good CI/CD
* Incomplete features need techniques such as feature flags
* Poorly managed direct commits can affect the main branch

---

# Branching Strategy Comparison

| Strategy    | Main Idea                                                | Best Fit                |
| ----------- | -------------------------------------------------------- | ----------------------- |
| GitFlow     | Multiple branches for development, releases and hotfixes | Scheduled releases      |
| GitHub Flow | Main branch + short-lived feature branches               | Continuous delivery     |
| Trunk-Based | Frequent integration into main/trunk                     | Fast CI/CD environments |

---

# Which strategy would I use?

## Startup shipping fast

I would consider **GitHub Flow or Trunk-Based Development** because both can support short-lived branches and frequent integration.

The final choice depends on the team's CI/CD maturity, testing practices and release process.

---

## Large team with scheduled releases

**GitFlow can be a suitable model** when the organization needs explicit release branches, scheduled releases and hotfix workflows.

The actual choice should depend on the team's release and deployment process.

---

# Open-Source Project Branching Example

For this task, I reviewed the Kubernetes project.

Kubernetes uses a release-branch model around its main development branch. Release branches are created for individual Kubernetes releases while ongoing development continues separately.

A simplified representation is:

```text
main
 |
 +---------------------------->
 |
 +---- release-1.xx
 |
 +---- release-1.yy
 |
 +---- release-1.zz
```

This is different from a pure GitFlow implementation because open-source projects can adapt their branching model to their release and maintenance requirements.

---

# Task 5: Git Commands Reference

## Git Setup & Configuration

### Check Git version

```bash
git --version
```

### Configure username

```bash
git config --global user.name "Your Name"
```

### Configure email

```bash
git config --global user.email "you@example.com"
```

### View configuration

```bash
git config --list
```

---

# Basic Git Workflow

## Initialize repository

```bash
git init
```

## Clone repository

```bash
git clone <repository-url>
```

## Check status

```bash
git status
```

## Stage a file

```bash
git add file.txt
```

## Stage everything

```bash
git add .
```

## Commit

```bash
git commit -m "Add new feature"
```

## View commit history

```bash
git log
```

## Compact history

```bash
git log --oneline
```

## View changes

```bash
git diff
```

## View staged changes

```bash
git diff --staged
```

---

# Branching

## List branches

```bash
git branch
```

## Create branch

```bash
git branch feature/login
```

## Switch branch

```bash
git switch feature/login
```

## Create and switch

```bash
git switch -c feature/login
```

## Older checkout syntax

```bash
git checkout feature/login
```

Create and switch:

```bash
git checkout -b feature/login
```

## Delete branch

```bash
git branch -d feature/login
```

---

# Remote Commands

## Add remote

```bash
git remote add origin <repository-url>
```

## View remotes

```bash
git remote -v
```

## Push branch

```bash
git push origin main
```

## Push and set upstream

```bash
git push -u origin main
```

## Pull changes

```bash
git pull
```

## Fetch changes

```bash
git fetch
```

## Clone repository

```bash
git clone <repository-url>
```

## Fork

A fork creates a personal copy of another repository under my Git hosting account.

Typical workflow:

```text
Original Repository
        |
       Fork
        |
        v
My Repository
        |
      Clone
        |
        v
Local Machine
```

---

# Merge

Merge combines changes from one branch into another.

```bash
git switch main
git merge feature/login
```

Example:

```text
feature
    \
     A ---- B
            \
main --------M
```

---

# Rebase

Rebase moves my commits on top of another branch.

```bash
git switch feature/login
git rebase main
```

Simplified:

```text
Before:

main:    A ---- B
                \
feature:         C ---- D


After rebase:

main:    A ---- B
                  \
feature:           C' ---- D'
```

Rebase creates new commit IDs, so it should be used carefully on shared branches.

---

# Stash

Temporarily save uncommitted changes:

```bash
git stash
```

View stashes:

```bash
git stash list
```

Apply latest stash:

```bash
git stash apply
```

Apply and remove from stash:

```bash
git stash pop
```

Delete stash:

```bash
git stash drop
```

---

# Cherry Pick

Apply a specific commit from another branch:

```bash
git cherry-pick <commit-id>
```

Example:

```text
main:

A ---- B ---- C

feature:

A ---- D ---- E
```

Cherry-picking D:

```text
main:

A ---- B ---- C ---- D'
```

`D'` contains the changes from D but has a new commit ID.

---

# Reset

## Soft

```bash
git reset --soft HEAD~1
```

Commit removed, changes remain staged.

## Mixed

```bash
git reset --mixed HEAD~1
```

Commit removed, changes remain unstaged.

## Hard

```bash
git reset --hard HEAD~1
```

Commit and local changes are discarded.

---

# Revert

Undo a commit safely by creating a new commit:

```bash
git revert <commit-id>
```

Check history:

```bash
git log --oneline
```

The original commit remains in history.

---

# Reflog

`git reflog` records movements of `HEAD`.

```bash
git reflog
```

It can be extremely useful after an accidental reset.

Example:

```text
HEAD@{0} reset: moving to HEAD~1
HEAD@{1} commit: Add feature
```

A previous state can potentially be recovered using:

```bash
git reset --hard <reflog-commit-id>
```

---

# Interview Questions

## 1. What is the difference between reset and revert?

`reset` moves the branch pointer and can rewrite local history.

`revert` creates a new commit that reverses an existing commit.

---

## 2. Which is safer for shared branches?

`git revert` is generally safer because it preserves existing history.

---

## 3. What does `git reset --soft` do?

It moves `HEAD` backward while keeping the changes staged.

---

## 4. What does `git reset --mixed` do?

It moves `HEAD` backward and unstages the changes while keeping them in the working directory.

---

## 5. What does `git reset --hard` do?

It moves `HEAD` backward and resets both the staging area and working directory.

---

## 6. How can you recover from an accidental reset?

Use:

```bash
git reflog
```

Find the previous commit and recover it if necessary.

---

## 7. Can you revert a revert?

Yes.

Git can create another commit that reverses the previous revert.

---

## 8. Why shouldn't you rebase shared branches?

Rebase rewrites commit history and can cause problems for developers who already based their work on the old history.

---

# Key Learnings

Today I learned:

* `git reset` changes where the branch points.
* `git reset --soft` keeps changes staged.
* `git reset --mixed` keeps changes unstaged.
* `git reset --hard` can discard local changes.
* `git revert` creates a new commit to undo an earlier commit.
* `git revert` is generally safer for shared branches.
* `git reflog` can help recover from accidental history changes.
* GitFlow supports structured release workflows.
* GitHub Flow keeps branching simple.
* Trunk-Based Development focuses on frequent integration.
* Branching strategy should match the team's release and CI/CD practices.

---

# Commands Practiced

```bash
git init
git status
git add .
git commit
git log --oneline
git diff

git branch
git switch
git checkout
git merge
git rebase

git remote -v
git fetch
git pull
git push
git clone

git stash
git stash pop
git cherry-pick

git reset --soft
git reset --mixed
git reset --hard

git revert
git reflog
```

---

## 🚀 Day 25 Completed


#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham #Git #GitHub #DevOps #CI/CD
