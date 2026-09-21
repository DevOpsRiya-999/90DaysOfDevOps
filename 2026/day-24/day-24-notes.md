# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge — Hands-On

<img width="1255" height="953" alt="image" src="https://github.com/user-attachments/assets/f2357298-ab14-4e06-8adb-9f1ffdc79ede" />
<img width="1220" height="610" alt="image" src="https://github.com/user-attachments/assets/ea91d3ad-e63d-4d0d-abda-00f8d73d7a51" />

## 1.What is a fast-forward merge?
>>A fast-forward merge occurs when you try to merge a target branch into your current branch, and the current branch has no new commits since the two branches separated.
       (main)
         ↓
A ------- B
           \
            C ------- D
                      ↑
                  (feature)

========================
Q. Merge feature-signup into main — what happens this time?

Unlike a standard "fast-forward" merge (where Git simply moves the pointer forward because main didn't have any new changes), Git must now reconcile two separate timelines.1. 
A New "Merge Commit" is CreatedBecause both branches have unique commits, Git automatically finds the last common ancestor of both branches. It combines the changes from both timelines and generates a brand-new commit on the main branch.Git will automatically open your default text editor (like Nano or Vim) prompting you to save a commit message. It defaults to something like: Merge branch 'feature-signup'.
Simply save and close the editor to complete the merge.
======================
## 1. The Histories Have Diverged (Three-Way Merge)
- This is the most common scenario, exactly like the feature-signup example you asked about earlier.A merge commit is required when both the branch you are on (main) and the branch you are
pulling in (feature) have received new commits since they split apart.
          (main)
            ↓
A -- B ---- C ---- F  <-- (New Merge Commit)
      \           /
       D ------- E
                 ↑
             (feature)
- Why it happens: Because main has moved forward to commit C, Git cannot simply slide the main pointer forward to E without losing commit C's history.
- The Result: Git performs a three-way merge (comparing commits C, E, and their common ancestor B). It combines the changes and automatically generates a brand-new Merge Commit (F) to tie the two timelines back together:
===============================
Q. What is a merge conflict? (try creating one intentionally by editing the same line in both branches)
>>A merge conflict is an event that occurs when Git cannot automatically reconcile differences between two branches.
<img width="1510" height="618" alt="image" src="https://github.com/user-attachments/assets/dbdf1864-d8dc-49f9-818d-f81b87f28523" />
## What Happens Now?
Auto-merging story.txt
CONFLICT (content): Merge conflict in story.txt
Automatic merge failed; fix conflicts and then commit the result.

=======================
Task 2: Git Rebase — Hands-On

<img width="1477" height="1020" alt="image" src="https://github.com/user-attachments/assets/315b8054-a3f7-40ec-902a-d13a5f0356fc" />
===========================
## Step 6: Observe the Final Result!
<img width="1322" height="683" alt="image" src="https://github.com/user-attachments/assets/abbd28b2-2668-46f7-8744-e295453ac6c6" />
## Q.What does rebase actually do to your commits?
>> Rebase rewrites your project history. It takes the commits you made on feature-dashboard, temporarily lifts them off the branch, and replays them one by one on top of the latest commit of main.
## Q.When would you use rebase vs merge?
>> Use Rebase when:
- Local cleanup: You want to clean up your local feature branch, pull in the latest updates from your team's tracking branch, and keep a completely flat, 
readable timeline before submitting a pull request.
- Linear preference: Your team hates "merge commit clutter" and prefers a perfectly straight history file.
### Use Merge when:
- Shared/Public branches: You are working on long-running shared branches (like merging a finished feature into main or develop).
- Preserving context: You want a bulletproof historical record of exactly when a branch split off and when it was integrated back in, keeping the real chronological order intact.
==========================
## Task 4: Git Stash — Hands-On

Both git stash pop and git stash apply restore your temporarily shelved changes, but they handle the stash memory differently.
The core difference is what happens to the stash after you bring it back:
## Use git stash pop when:
-You only want a quick, temporary holding zone.
- You are certain you won't need that specific snapshot of changes ever again once restored.
- Tip: If a merge conflict happens during a pop, Git is smart—it will keep the stash safe in your list until you resolve the conflict.
## Use git stash apply when:
- You want to apply the exact same set of changes to multiple branches.
- You are testing out an experimental fix and want to keep a backup copy of those changes safely tucked away just in case your test fails.
================================

## Task 5: Cherry Picking
### What does cherry-pick do?
>> The git cherry-pick <commit-hash> command takes a single, specific commit from another branch, copies its code changes, 
and applies it as a brand-new commit onto your current active branch.
<img width="1571" height="955" alt="image" src="https://github.com/user-attachments/assets/9424d37b-eefb-4377-8e5b-5a35d0d7e789" />
<img width="1600" height="862" alt="image" src="https://github.com/user-attachments/assets/ed61149d-f034-4f2f-8636-d8cffa953a9a" />
