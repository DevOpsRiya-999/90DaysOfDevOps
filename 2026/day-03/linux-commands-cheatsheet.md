
# 🔧 Process Management
## Command	What it's for
* ps aux	full snapshot of every process — pipe to grep to hunt one down
* ps -ef --forest	same idea but shows parent/child tree, good for spotting zombie chains
* top	live view, sorted by CPU by default — press M to sort by memory instead
* htop	prettier top, lets you scroll & kill with F9 — install it if it's not there
* pgrep -fl <name>	find PID(s) by process name without the ps+grep dance
* pkill -f <name>	kill by name instead of hunting for the PID first
* kill -15 <pid>	polite kill (SIGTERM) — let the process clean up after itself
* kill -9 <pid>	the "I don't care anymore" kill (SIGKILL) — last resort
* nice -n 10 <cmd>	start a process at lower priority so it doesn't hog the box
* renice -n 5 -p <pid>	change priority on something already running
* jobs	list background/suspended jobs in the current shell
* bg / fg	resume a stopped job in background / bring it to foreground
* nohup <cmd> &	keep a process alive after you log out / close the terminal
* systemctl status <svc>	check if a service is up, and see its recent log tail
* systemctl restart <svc>	bounce a service — first thing to try when something's stuck
# 📁 File System
## Command	What it's for
* df -h	disk space per mounted filesystem, human-readable — check this first when "disk full"
* du -sh */	size of each folder in current dir — good for finding what ate the space
* find / -size +500M 2>/dev/null	hunt down big files system-wide, ignore permission-denied noise
* lsof +D /path	see which processes have files open under a directory (great before unmounting)
* lsof -i :8080	what's actually listening on/using a port
* chmod 755 file	rwx for owner, rx for group/others — typical for scripts
* chown user:group file	fix ownership after a deploy or copy from another user
* ln -s /path/target linkname	symlink — handy for versioned dirs (current -> release-1.4)
* tar -czvf out.tar.gz dir/	compress a folder; -xzvf to pull it back apart
* rsync -avz src/ dest/	copy/sync that resumes and only moves what changed
* stat file	timestamps + permissions + inode, more detail than ls -l
# 🌐 Networking Troubleshooting
Command	What it's for
* ping -c 4 host	basic "is it even reachable" check, -c so it doesn't run forever
* ip addr (or ip a)	show interfaces and assigned IPs — the modern replacement for ifconfig
* ip route	check the routing table when traffic's going out the wrong interface
* dig +short domain	quick DNS lookup, no fluff — add @8.8.8.8 to bypass local resolver and test if it's a DNS issue
* curl -I https://url	headers only — fast way to check if a site/API is alive and what it's returning
* curl -v https://url	verbose curl, shows the full handshake — my go-to for "why is this API failing"
traceroute host	see where the connection is actually dying along the path
* ss -tulnp	who's listening on what port and which process owns it (replaces old netstat)
* nmap -p 1-1000 host	scan a range of ports on a host — use responsibly, only on stuff you own
* tcpdump -i eth0 port 443	packet capture filtered to a port, for when you need to see what's really on the wire
## Notes to self
* Always try the polite kill before the nuclear one.
* df lies about free space sometimes if a deleted file is still held open by a process — check lsof | grep deleted.
* If ping works but curl doesn't, it's almost always DNS or a firewall/port issue, not routing.
