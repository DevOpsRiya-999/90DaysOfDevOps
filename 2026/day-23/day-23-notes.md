## Task 1: Understanding Branches

1. What is a branch in Git?
>> In Git, a branch is a lightweight, movable pointer to a specific commit in your repository's history.
It represents an independent line of development, essentially serving as an isolated workspace where you can write, test, and save changes without affecting the stable, main project code


2.Why do we use branches instead of committing everything to main?
>>Using branches instead of committing everything directly to main is a standard best practice because it protects your project from breaking and makes team collaboration possible.

3.What is HEAD in Git?
>>  * >>this pointer is HEAD
>>In Git, HEAD is a special pointer that references your current active branch or specific commit in the repository.

4.What happens to your files when you switch branches?
>>When you switch branches using git switch <branch-name> (or the older git checkout <branch-name>),
Git instantly rewrites the files in your working directory to match the snapshot of the branch you are moving to.

## Task 2: Branching Commands — Hands-On
1.List all branches in your repo
<img width="975" height="151" alt="image" src="https://github.com/user-attachments/assets/2951ebd7-9c2a-4ddc-947b-faa04050eb78" />
2. Create a new branch called feature-1

<img width="1311" height="88" alt="image" src="https://github.com/user-attachments/assets/a44bc75f-ff68-41ed-902b-25fa9f442304" />
3.Switch to feature-1
<img width="1096" height="275" alt="image" src="https://github.com/user-attachments/assets/51884490-1f7d-490d-90eb-5eb1985a78f2" />
4.Create a new branch and switch to it in a single command — call it feature-2
<img width="1006" height="247" alt="image" src="https://github.com/user-attachments/assets/64bf2137-063f-492d-8543-a9b287010a67" />
5. Try using git switch to move between branches — how is it different from git checkout?
>>In modern Git, git switch is a specialized command used exclusively for changing or creating branches, whereas git checkout is a multi-purpose legacy tool that can change branches, 
restore files, and manipulate individual commits.Git introduced git switch in version 2.23 to separate checkout's confusing, dual responsibilities into two simpler, dedicated commands:
git switch (for branches) and git restore (for files).

6.Make a commit on feature-1 that does not exist on main
<img width="1090" height="857" alt="image" src="https://github.com/user-attachments/assets/fe0475d3-fb53-4f4e-a28b-54754b679a12" />
7. Switch back to main — verify that the commit from feature-1 is not there
<img width="1116" height="415" alt="image" src="https://github.com/user-attachments/assets/dba33ca3-a21d-4279-86e7-c0dbaece4551" />
8.Delete a branch you no longer need
#  Delete the branch safely
```bash
git branch -d branch-name
git branch -D branch-name # Force Delete (-D): If you are absolutely certain you want to destroy the branch and throw away all unmerged work inside it
git push origin --delete branch-name  #If you pushed the branch to a platform like GitHub and want to remove it from the cloud as well, run this command:
```



