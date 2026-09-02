# Map the OSI vs TCP/IP models in your own words



L7	--> Application	Application/service communication	--> HTTP, HTTPS, DNS, SSH
L6 --> 	Presentation	Data format/encryption layer -->	TLS, JSON, encoding
L5 --> 	Session	Manages sessions/ browser case ---->	Sessions, RPC
L4 -->	Transport layer/	Reliable/fast delivery	--> TCP(sharing photos,massages), UDP( video call,live strimming )
L3 -->	Network	IP addressing & routing	--> IPv4, IPv6, ICMP
L2 -->	Data Link	(MAC & local network communication) -->	Ethernet, ARP
L1 -->	Physical layer	Actual transmission medium	-->Cable, Wi-Fi, NIC

## TCP/IP Model
OSI                    TCP/IP

L7 Application ─────┐
L6 Presentation     │
L5 Session ─────────┴── Application

L4 Transport ───────── Transport

L3 Network ─────────── Internet

L2 Data Link ────────┐
L1 Physical ─────────┴── Link

===================================================
As a DevOps engineer, don't get too focused on memorizing all seven OSI layers. During an incident, you're usually asking:

**DNS problem? → Application/name resolution
Can't establish TCP connection? → Transport/firewall/service
Can't reach IP? → Network/routing/security group
Interface problem? → Link**
========================================================
## 2. Where do common protocols sit?
## IP

IP works at:

### OSI L3 / TCP-IP Internet layer

It handles addressing and routing.

Example:

Client 10.0.1.10
       ↓
Server 10.0.2.20
TCP / UDP

## TCP and UDP work at:

#### OSI L4 / TCP-IP Transport layer

TCP:

Connection-oriented
Reliable
Used by HTTPS, SSH, etc.

UDP:

Connectionless
Lower overhead
Commonly used by DNS and other services.
HTTP / HTTPS

## HTTP/HTTPS are:

OSI L7 / TCP-IP Application layer

For HTTPS:

HTTP
 ↓
TLS encryption
 ↓
TCP
 ↓
IP
 ↓
Network
## DNS

DNS is generally considered:

OSI L7 / TCP-IP Application layer

Example:

google.com
     ↓
DNS lookup
     ↓
142.250.x.x

================================================

## Hands-on Checklist (run these; add 1–2 line observations)
1.Identity: hostname -I (or ip addr show) — 172.31.27.26
<img width="1056" height="405" alt="image" src="https://github.com/user-attachments/assets/e74d711a-f4c9-4206-bb52-246b9c9fde95" />

2. Reachability: ping <target> — ping -c 4 google.com ( 4 packets transmitted, 4 received, 0% packet loss, time 3004ms)
<img width="1206" height="397" alt="image" src="https://github.com/user-attachments/assets/6640dcba-f144-47be-8b2e-d709d82769f9" />

3. Path: traceroute <target> (or tracepath) — tracepath google.com / tracepath google.com
<img width="1526" height="908" alt="image" src="https://github.com/user-attachments/assets/0904ae64-5e9a-4755-8aab-1a61533e9b57" />
### DevOps observation

"Traceroute helps identify where latency or routing problems may occur, but individual * hops don't necessarily indicate an outage."
4. Ports: ss -tulpn (or netstat -tulpn) — list one listening service and its port.(sudo ss -tulpn)

<img width="1902" height="332" alt="image" src="https://github.com/user-attachments/assets/86ab6d4b-d17d-4b07-88ae-620282ebb9a4" />
Important DevOps concept

There are two different questions:

Is the service running?

sudo ss -tulpn

Can I actually connect to it?

nc -zv localhost 22

These are not exactly the same thing.
===========================
5. Name resolution: dig <domain> or nslookup <domain> — record the resolved IP.
Run:

dig google.com

For a shorter result:

dig +short google.com

Example:

142.250.xxx.xxx

You can also use:

nslookup google.com
<img width="720" height="906" alt="image" src="https://github.com/user-attachments/assets/6a5dd9f8-e5f9-4ae7-8ad8-a3d94b7e32b3" />

6. HTTP check: curl -I <http/https-url> — note the HTTP status code.< curl -I https://example.com  >

<img width="1010" height="381" alt="image" src="https://github.com/user-attachments/assets/95a68a89-d9a2-4bd2-8aeb-bee36a2f738b" />

Other common statuses:

200 → OK
301 → Redirect
302 → Redirect
400 → Bad Request
401 → Unauthorized
403 → Forbidden
404 → Not Found
500 → Internal Server Error
502 → Bad Gateway
503 → Service Unavailable
504 → Gateway Timeout
7. Connections snapshot: netstat -an | head — count ESTABLISHED vs LISTEN (rough).
< netstat -an | head  >
<img width="1210" height="341" alt="image" src="https://github.com/user-attachments/assets/c0d4963e-71d0-49d5-9da9-bc5754eb34aa" />
<img width="962" height="133" alt="image" src="https://github.com/user-attachments/assets/2e751978-95a3-4b1e-abcd-17bb33294421" />
## 8. Mini Task – Port Probe
< sudo ss -tulpn | grep :22 > 
<img width="1846" height="160" alt="image" src="https://github.com/user-attachments/assets/70dec2c8-785f-47f6-9cb2-233a016eb17d" />
## 9. Real DevOps Troubleshooting Flow
Imagine a developer says:

"The application is down."
Imagine a developer says:

"The application is down."
Application Down
      │
      ▼
Is server reachable?
      │
   ping / SSH
      │
      ▼
Does DNS resolve?
      │
     dig
      │
      ▼
Is required port listening?
      │
     ss
      │
      ▼
Can I connect to the port?
      │
      nc
      │
      ▼
Does HTTP respond?
      │
     curl
      │
      ▼
Check application logs

What layer would you inspect if DNS fails?
## 11. Reflection Answers

Q. What layer would you inspect if DNS fails?

DNS is an Application-layer protocol.

I would start with:
dig
nslookup
cat /etc/resolv.conf

- Then investigate the configured DNS resolver, DNS server reachability, VPC DNS configuration, or upstream DNS service.
==================
q> What if HTTP 500 appears?

HTTP 500 means the request reached the HTTP service, but the server encountered an internal application error.

So I would investigate:

Application logs
        ↓
Web server / reverse proxy logs
        ↓
Application dependencies
        ↓
Database / API / service dependencies

For example:

sudo journalctl -u nginx

or application-specific logs.

12. Two follow-up checks during a real incident

I would run:
I would run:

Check 1 – Service status
sudo systemctl status nginx

or:

sudo systemctl status <service-name>
Check 2 – Logs
sudo journalctl -u nginx --since "10 minutes ago"

For an application:

sudo journalctl -u <application-service> --since "10 minutes ago"

The exact commands depend on how the application is deployed.

