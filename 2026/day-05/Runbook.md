# Linux Troubleshooting Runbook

## Target Service
Nginx

---

## Environment

### uname -a

```bash
uname -a
```

Observation:
Ubuntu 24.04 running on x86_64.

### cat /etc/os-release

```bash
cat /etc/os-release
```

Observation:
Confirmed Ubuntu 24.04 LTS.

---

## Filesystem

```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```

Observation:
Filesystem is writable and file copy succeeded.

---

## CPU & Memory

```bash
top
```

Observation:
CPU usage around 15%, memory around 40%.

```bash
ps -o pid,pcpu,pmem,comm -p 1503
```

Observation:
Nginx uses 3% CPU and 2% memory.

```bash
free -h
```

Observation:
2 GB RAM free.

---

## Disk

```bash
df -h
```

Observation:
Disk usage at 65%.

```bash
du -sh /var/log
```

Observation:
Log directory size is 1.8 GB.

---

## Network

```bash
ss -tulpn
```

Observation:
Nginx listening on port 80.

```bash
curl -I http://localhost
```

Observation:
Received HTTP 200 OK.

---

## Logs

```bash
journalctl -u nginx -n 50
```

Observation:
No recent service errors.

```bash
tail -50 /var/log/nginx/error.log
```

Observation:
No critical errors found.

---

## Quick Findings

- Server healthy
- Nginx running
- CPU and memory normal
- Disk has enough space
- Website responding successfully
- No critical log errors

---

## If This Worsens

1. Restart Nginx and monitor the service.
2. Enable more detailed logging to capture additional information.
3. Use `strace` or similar tools to inspect the process if it appears stuck.
