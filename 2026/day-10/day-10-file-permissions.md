# Day 10 Challenge

## Files Created
devops.txt
notes.txt
script.sh


## Permission Changes
ubuntu@ip-172-31-31-247:~$ ls -l
total 8
-rw-rw-r-- 1 ubuntu ubuntu  0 Aug 11 09:53 devops.txt
-rw-rw-r-- 1 ubuntu ubuntu 15 Aug 11 09:55 notes.txt
-rw-r--r-- 1 root   root   17 Aug 11 09:56 script.sh

- rw- r-- r--
  │   │   │
  │   │   └── Others
  │   └────── Group
  └────────── Owner
| Permission | Value | Meaning |
| ---------- | ----: | ------- |
| r          |     4 | Read    |
| w          |     2 | Write   |
| x          |     1 | Execute |
## 4. Modify permissions
Make script.sh executable
chmod +x script.sh
<img width="523" height="135" alt="image" src="https://github.com/user-attachments/assets/25064a2a-4c60-477b-9a2b-91ec0ce6efce" />
Before:
- Not executable

After:
- `755` - Executable by owner, group and others
<img width="620" height="107" alt="image" src="https://github.com/user-attachments/assets/ac2670a3-94d9-4574-95d6-26402ffaa5c7" />

## Commands Used
```bash
touch devops.txt
cat > notes.txt
vim script.sh
ls -l
cat notes.txt
vim -R script.sh
head -n 5 /etc/passwd
tail -n 5 /etc/passwd
chmod +x script.sh
chmod -w devops.txt
chmod 640 notes.txt
mkdir project
chmod 755 project
./script.sh
<img width="462" height="735" alt="image" src="https://github.com/user-attachments/assets/72a6a114-de95-4f0f-8a51-df6951f27979" />

## What I Learned

1.Linux permissions control who can read, write and execute files.
2.chmod is used to change file and directory permissions.
3.r = 4, w = 2, and x = 1 are used to calculate numeric permissions.


### Quick cheat sheet

```text
chmod +x file.sh     → Add execute permission
chmod -x file.sh     → Remove execute permission
chmod -w file        → Remove write permission
chmod 640 file       → rw- r-- ---
chmod 755 directory  → rwx r-x r-x

r = 4
w = 2
x = 1

6 = 4 + 2 = rw-
7 = 4 + 2 + 1 = rwx
5 = 4 + 1 = r-x
4 = r--
0 = ---
