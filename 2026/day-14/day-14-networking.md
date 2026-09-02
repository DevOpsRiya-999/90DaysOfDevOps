// Map the OSI vs TCP/IP models in your own words



L7	--> Application	Application/service communication	--> HTTP, HTTPS, DNS, SSH
L6 --> 	Presentation	Data format/encryption layer -->	TLS, JSON, encoding
L5 --> 	Session	Manages sessions/ browser case ---->	Sessions, RPC
L4 -->	Transport layer/	Reliable/fast delivery	--> TCP(sharing photos,massages), UDP( video call,live strimming )
L3 -->	Network	IP addressing & routing	--> IPv4, IPv6, ICMP
L2 -->	Data Link	(MAC & local network communication) -->	Ethernet, ARP
L1 -->	Physical layer	Actual transmission medium	-->Cable, Wi-Fi, NIC

// TCP/IP Model
OSI                    TCP/IP

L7 Application ─────┐
L6 Presentation     │
L5 Session ─────────┴── Application

L4 Transport ───────── Transport

L3 Network ─────────── Internet

L2 Data Link ────────┐
L1 Physical ─────────┴── Link

===================================================
