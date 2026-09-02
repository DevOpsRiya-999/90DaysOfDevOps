# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## 🎯 Objective

Today I focused on four networking building blocks that every DevOps engineer should understand:

- DNS – how names become IP addresses
- IP addressing – public/private IPv4 addresses
- CIDR and subnetting – how networks are divided
- Ports – how clients reach services

The goal is not just to memorize commands, but to understand what is happening when an application communicates over a network.

---

# Task 1 – DNS: How Names Become IPs

## What happens when I type `google.com` in a browser?

1. The browser first needs to resolve `google.com` to an IP address.
2. The operating system/browser checks available DNS caches before asking a DNS resolver.
3. The DNS resolver finds the appropriate DNS records and returns an IP address, such as an IPv4 A record.
4. The browser then connects to that IP using the required protocol, such as HTTPS, and communicates with the web server.

### Simple flow

```text
Browser
   ↓
DNS lookup: google.com
   ↓
DNS Resolver
   ↓
IP Address
   ↓
TCP connection
   ↓
TLS/HTTPS
   ↓
Web Server
```

## Important DNS record types

| Record | Meaning |
|---|---|
| A | Maps a domain name to an IPv4 address. |
| AAAA | Maps a domain name to an IPv6 address. |
| CNAME | Creates an alias from one domain name to another domain name. |
| MX | Specifies mail servers responsible for receiving email for a domain. |
| NS | Identifies the authoritative name servers for a domain. |

## Hands-on: Check DNS

Run:

```bash
dig google.com
```

For an easier-to-read answer:

```bash
dig google.com A
```

or:

```bash
dig +noall +answer google.com A
```

### Example output

> The IP address and TTL below are examples. Replace them with the values from your own `dig` output.

```text
google.com.    300    IN    A    142.250.xxx.xxx
```

From this example:

- **A record:** `142.250.xxx.xxx`
- **TTL:** `300` seconds

### DevOps interpretation

TTL tells DNS resolvers how long a DNS response can normally be cached before it needs to be refreshed.

In a real incident, if a DNS record was recently changed, TTL and DNS caching can be important when explaining why different clients may temporarily receive different results.

Useful commands:

```bash
dig google.com
dig +short google.com
dig google.com A
dig google.com MX
dig google.com NS
```

---
![after dig google.com](image.png)


# Task 2 – IP Addressing

## What is an IPv4 address?

An IPv4 address is a **32-bit address** used to identify a network interface/device on an IP network.

It is normally written as four decimal numbers separated by dots.

Example:

```text
192.168.1.10
```

Each part is called an octet:

```text
192    .    168    .    1    .    10
 ↑          ↑          ↑         ↑
Octet      Octet      Octet     Octet
```

Each octet can contain a value from:

```text
0 – 255
```

Because IPv4 has 32 bits:

```text
2^32 = 4,294,967,296
```

possible IPv4 addresses exist in the full address space.

---

## Public vs Private IP

### Private IP

Private IP addresses are used inside private networks such as:

- AWS VPCs
- Office networks
- Home networks
- Internal application networks

Examples:

```text
10.0.1.20
172.16.5.10
192.168.1.10
```
![alt text](image-1.png)

Private IPs are not directly routable across the public Internet.

### Public IP

A public IP is globally routable on the Internet.

Example:

```text
8.8.8.8
```

A public IP may be assigned to an Internet-facing AWS resource, depending on the architecture.

---

## Private IPv4 ranges

The three RFC 1918 private ranges are:

```text
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16
```

More explicitly:

```text
10.0.0.0       – 10.255.255.255

172.16.0.0     – 172.31.255.255

192.168.0.0    – 192.168.255.255
```

### Easy memory trick

```text
10.x.x.x
172.16 – 172.31
192.168.x.x
```

---

## Hands-on: Check my server IP

Run:

```bash
ip addr show
```

or:

```bash
hostname -I
```

Example:

```text
inet 10.0.1.25/24
```

`10.0.1.25` is a **private IP** because it belongs to `10.0.0.0/8`.

### DevOps example

In an AWS VPC, an EC2 instance might have:

```text
Private IP: 10.0.1.25
Public IP:  54.x.x.x
```

The private IP is commonly used for communication inside the VPC.

For example:

```text
EC2
10.0.1.25
   ↓
RDS
10.0.2.50:3306
```

The database can remain private while the application communicates with it internally.

---

# Task 3 – CIDR & Subnetting

## What does `/24` mean?

Consider:

```text
192.168.1.0/24
```

`/24` means the first **24 bits** represent the network portion.

The remaining:

```text
32 - 24 = 8 bits
```

are available for host addresses.

The equivalent subnet mask is:

```text
255.255.255.0
```

### `/24` visual

```text
192.168.1.0/24

Network bits:  24
Host bits:      8

11111111.11111111.11111111.00000000
```

---

## How many usable hosts?

For a traditional IPv4 subnet:

```text
Total addresses = 2^(host bits)
Usable hosts = Total addresses - 2
```

The two traditionally unavailable addresses are:

- Network address
- Broadcast address

### `/24`

```text
Host bits = 8

2^8 = 256 total IPs

256 - 2 = 254 usable hosts
```

### `/16`

```text
Host bits = 16

2^16 = 65,536 total IPs

65,536 - 2 = 65,534 usable hosts
```

### `/28`

```text
Host bits = 4

2^4 = 16 total IPs

16 - 2 = 14 usable hosts
```

> Note: Cloud networking, especially AWS VPC subnetting, has additional reserved-address rules. Do not blindly apply the traditional `total - 2` rule to every cloud platform scenario.

---

## CIDR Table

| CIDR | Subnet Mask | Total IPs | Traditional Usable Hosts |
|---|---|---:|---:|
| `/24` | `255.255.255.0` | 256 | 254 |
| `/16` | `255.255.0.0` | 65,536 | 65,534 |
| `/28` | `255.255.255.240` | 16 | 14 |

### Important CIDR formula

```text
Host bits = 32 - prefix length

Total IPs = 2^(host bits)

Traditional usable IPv4 hosts = 2^(host bits) - 2
```

---

## Why do we subnet?

Subnetting divides a larger network into smaller networks.

We subnet to:

- Organize infrastructure
- Reduce unnecessary broadcast domains
- Improve network management
- Apply security boundaries
- Separate application tiers
- Use IP addresses efficiently
- Design cloud networks such as public/private subnets

### Real AWS DevOps example

A VPC could be:

```text
VPC: 10.0.0.0/16
       |
       +-- Public Subnet:  10.0.1.0/24
       |
       +-- Private App:    10.0.2.0/24
       |
       +-- Private DB:     10.0.3.0/24
```

Traffic can then be controlled with:

- Route tables
- Security groups
- Network ACLs
- NAT Gateway
- Internet Gateway


---

# Task 4 – Ports: The Doors to Services

## What is a port?

A port is a logical endpoint used by TCP or UDP to identify a specific service/process on a host.

An IP identifies the machine/interface.

A port helps identify the service.

Think:

```text
IP Address = Building address
Port       = Door number
Service    = Business behind the door
```

Example:

```text
10.0.1.25:22
```

means:

```text
Host: 10.0.1.25
Port: 22
Service: SSH
```

---

## Why do we need ports?

One server can run many services at the same time.

Example:

```text
10.0.1.25:22     → SSH
10.0.1.25:80     → HTTP
10.0.1.25:443    → HTTPS
10.0.1.25:3306   → MySQL
```

The port allows network traffic to reach the intended service.

---

## Common ports

| Port | Service | Typical use |
|---:|---|---|
| 22 | SSH | Secure remote administration |
| 80 | HTTP | Web traffic |
| 443 | HTTPS | Secure web traffic |
| 53 | DNS | Name resolution |
| 3306 | MySQL | MySQL database |
| 6379 | Redis | Redis database/cache |
| 27017 | MongoDB | MongoDB database |

### Security note

Knowing a port number does not mean the service should be publicly accessible.

For example:

```text
22    → SSH
3306  → MySQL
6379  → Redis
27017 → MongoDB
```

Database ports should normally be restricted to only the application/network components that need them.

In AWS, this usually involves Security Groups and private networking.

---

## Hands-on: Check listening ports

Run:

```bash
sudo ss -tulpn
```
![alt text](image-2.png)

Example:

```text
tcp   LISTEN   0   128   0.0.0.0:22      0.0.0.0:*   users:(("sshd",pid=1234))
tcp   LISTEN   0   128   0.0.0.0:80      0.0.0.0:*   users:(("nginx",pid=2345))
```

From this example:

```text
22 → SSH/sshd
80 → HTTP/nginx
```

### Important

Your actual server may show different ports.

Use:

```bash
sudo ss -tulpn
```

and record **two real listening ports from your machine** in the final submission.

---

# Task 5 – Putting It Together

## Question 1

### You run:

```bash
curl http://myapp.com:8080
```

What networking concepts are involved?

### Answer

Several concepts are involved:

1. `myapp.com` must be resolved through DNS to an IP address.
2. The client connects to port `8080` using TCP.
3. HTTP is used at the application layer.
4. The traffic is routed using the destination IP.

Flow:

```text
myapp.com
   ↓
DNS
   ↓
IP address
   ↓
TCP :8080
   ↓
HTTP
   ↓
Application
```

### 5-year DevOps perspective

I would also ask:

```text
Does DNS resolve?
       ↓
Is the IP reachable?
       ↓
Is TCP/8080 allowed?
       ↓
Is the service listening?
       ↓
Does HTTP return a valid response?
```

Useful checks:

```bash
dig +short myapp.com
ping -c 4 <IP>
nc -zv <IP> 8080
sudo ss -tulpn | grep :8080
curl -v http://myapp.com:8080
```

---

# Question 2

## App can't reach:

```text
10.0.1.50:3306
```

What would you check first?

I would troubleshoot from the application outward:

### 1. Check the destination IP

```bash
ping -c 4 10.0.1.50
```

> Ping may be blocked, so failure alone does not prove the database is unreachable.

### 2. Test TCP port 3306

```bash
nc -zv 10.0.1.50 3306
```

This is more directly useful because the application needs TCP connectivity to the MySQL port.

### 3. Check routing

```bash
ip route
```

### 4. Check database service

On the database server:

```bash
sudo systemctl status mysql
```

### 5. Check whether MySQL is listening

```bash
sudo ss -tulpn | grep :3306
```

### 6. Check firewall/security controls

In a real AWS environment, check:

```text
EC2 Security Group
Network ACL
Route Table
Subnet
VPC connectivity
```

Also verify that MySQL is listening on the expected interface, not only on localhost.

---

# 🔥 Real DevOps Troubleshooting Example

## Scenario

Application:

```text
10.0.1.20
```

Database:

```text
10.0.2.50:3306
```

Application reports:

```text
Connection timed out
```

I would not immediately restart MySQL.

I would follow:

```text
Application
    ↓
Can it resolve the DB hostname?
    ↓
Is route available?
    ↓
Can it reach 10.0.2.50?
    ↓
Is TCP/3306 reachable?
    ↓
Is MySQL listening?
    ↓
Is Security Group allowing 3306?
    ↓
Is NACL allowing traffic?
    ↓
Is MySQL configured to accept remote connections?
    ↓
Check MySQL/application logs
```

This layered approach helps identify the exact failure point.

---

# 🧠 What a 5-Year DevOps Engineer Should Know

At around 5 years of DevOps experience, I would expect to be comfortable with these areas:

## Basic networking

You should understand:

```text
IP
Subnet
CIDR
Default Gateway
Routing
DNS
TCP
UDP
Ports
HTTP/HTTPS
```

## Linux troubleshooting

You should be comfortable using:

```bash
ip addr
ip route
ping
traceroute
ss
netstat
dig
nslookup
curl
nc
```

## Cloud networking

You should understand concepts such as:

```text
VPC
Public subnet
Private subnet
Route table
Internet Gateway
NAT Gateway
Security Group
Network ACL
Load Balancer
```

For AWS DevOps, you should be able to explain a flow such as:

```text
Internet
   ↓
Load Balancer
   ↓
Private Application Subnet
   ↓
Database Subnet
   ↓
RDS
```

and explain how routing and security controls allow or deny the traffic.

## Troubleshooting mindset

A strong DevOps engineer doesn't just know commands.

They know what question each command answers:

| Command | Question |
|---|---|
| `ip addr` | What IP/interface do I have? |
| `ip route` | Where will traffic go? |
| `ping` | Can I get basic IP/ICMP reachability? |
| `traceroute` | What path does traffic take? |
| `dig` | Does DNS resolve and what records are returned? |
| `ss` | What ports/connections are active? |
| `nc` | Can I establish TCP connectivity to this port? |
| `curl` | Does the application endpoint respond? |
| `systemctl` | Is the service running? |
| `journalctl` | What does the service log say? |

---

# 📌 Day 15 Quick Revision

```text
DNS
Domain → IP

IPv4
32-bit address

Private IP
10.0.0.0/8
172.16.0.0/12
192.168.0.0/16

CIDR
/24 → 255.255.255.0
/16 → 255.255.0.0
/28 → 255.255.255.240

Ports
22    → SSH
80    → HTTP
443   → HTTPS
53    → DNS
3306  → MySQL
6379  → Redis
27017 → MongoDB

Core troubleshooting:

DNS
 ↓
IP
 ↓
Route
 ↓
Port
 ↓
Service
 ↓
Application
 ↓
Logs
```

---

# ✍️ My 3 Key Learnings

### 1. DNS

DNS converts human-friendly names into IP addresses, allowing applications to locate services without users needing to remember IP addresses.

### 2. CIDR/Subnetting

CIDR defines how many bits belong to the network portion of an IP address. Subnetting helps us divide networks into smaller, controlled network segments.

### 3. Ports

An IP identifies a host, while a port identifies the service endpoint. Checking the port is critical when troubleshooting application-to-application connectivity.

---

# 🚀 Final DevOps Takeaway

The biggest lesson from Day 15 is:

```text
Don't just ask:
"Is the server up?"

Ask:
"Where exactly is the communication failing?"
```

A practical troubleshooting sequence is:

```text
DNS
 ↓
IP
 ↓
Route
 ↓
Port
 ↓
TCP
 ↓
Service
 ↓
Application
 ↓
Logs
```

This is the level of networking knowledge I want to build toward as a DevOps engineer.

---


