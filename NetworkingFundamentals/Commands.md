# Networking Commands — Troubleshooting Notes

## 1. Ping

### Command

```bash
ping -c 4 google.com
```

### Output

```text
PING google.com (142.250.195.78) 56(84) bytes of data.
64 bytes from lcboma-be-in-f14.1e100.net (142.250.195.78): icmp_seq=1 ttl=117 time=187 ms
64 bytes from lcboma-be-in-f14.1e100.net (142.250.195.78): icmp_seq=2 ttl=117 time=165 ms
64 bytes from lcboma-be-in-f14.1e100.net (142.250.195.78): icmp_seq=3 ttl=117 time=164 ms
64 bytes from lcboma-be-in-f14.1e100.net (142.250.195.78): icmp_seq=4 ttl=117 time=20.4 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 7529ms
rtt min/avg/max/mdev = 20.354/134.204/186.838/66.345 ms
```

### What I understood

The `ping` command is used to check whether a destination is reachable over a network. It sends ICMP packets and measures the response time. In my test, all 4 packets were received with 0% packet loss, which shows that `google.com` was reachable from my system.

## 2. Traceroute

### Command

```bash
traceroute google.com
```

### Output

```text
traceroute to google.com (142.250.195.78), 30 hops max, 60 byte packets
 1  100.129.160.1 (100.129.160.1)  266.060 ms  265.999 ms  265.953 ms
 2  202.131.133.5.convergentindia.com (202.131.133.5)  265.922 ms  265.888 ms  265.819 ms
 3  115.117.125.189.static-mumbai.vsnl.net.in (115.117.125.189)  256.169 ms  256.130 ms  256.096 ms
 4  172.28.117.90 (172.28.117.90)  256.074 ms  256.061 ms *
 5  115.112.15.114 (115.112.15.114)  259.143 ms  259.131 ms  259.118 ms
 6  * * *
 7  108.170.231.128 (108.170.231.128)  330.877 ms 216.239.56.62 (216.239.56.62)  330.843 ms 142.251.55.240 (142.251.55.240)  330.809 ms
 8  172.253.71.132 (172.253.71.132)  327.939 ms 172.253.75.14 (172.253.75.14)  327.860 ms 142.250.62.66 (142.250.62.66)  327.825 ms
 9  * 142.251.241.173 (142.251.241.173)  25.582 ms 142.251.252.95 (142.251.252.95)  55.950 ms
10  192.178.254.234 (192.178.254.234)  62.954 ms 172.253.70.180 (172.253.70.180)  55.871 ms 192.178.254.230 (192.178.254.230)  55.837 ms
11  192.178.110.207 (192.178.110.207)  274.104 ms 192.178.110.109 (192.178.110.109)  270.790 ms 192.178.242.43 (192.178.242.43)  274.012 ms
12  142.251.69.43 (142.251.69.43)  273.993 ms 142.251.69.45 (142.251.69.45)  273.974 ms  273.955 ms
13  lcboma-be-in-f14.1e100.net (142.250.195.78)  270.680 ms  270.666 ms  270.652 ms
```

### What I understood

The `traceroute` command shows the path taken by packets from my computer to a destination. Each numbered line represents a network hop, such as a router, between my system and the destination. In my test, the packets reached `google.com` after 13 hops. Some hops displayed `*`, which means that the router did not respond to that particular probe.

## 3. Netstat

### Command

```bash
netstat -tuln
```

### Output

```text
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN     
tcp6       0      0 ::1:631                 :::*                    LISTEN     
udp        0      0 0.0.0.0:37308           0.0.0.0:*                          
udp        0      0 0.0.0.0:5353            0.0.0.0:*                          
udp        0      0 127.0.0.54:53           0.0.0.0:*                          
udp        0      0 127.0.0.53:53           0.0.0.0:*                          
udp6       0      0 :::36522                :::*                               
udp6       0      0 :::5353                 :::*                               
```

### What I understood

`netstat -tuln` displays the TCP and UDP ports that are currently listening on the system. It helps identify network services that are waiting for connections. The `-t` option shows TCP connections, `-u` shows UDP, `-l` shows listening sockets, and `-n` displays addresses and port numbers without resolving their names.

## 4. Telnet

### Command

```bash
telnet google.com 80
```

### Output

```text
Trying 142.251.43.14...
Connected to google.com.
Escape character is '^]'.
^]
telnet> quit
Connection closed.
```

### What I understood

`telnet` can be used to test whether a connection can be established to a specific host and port. Here, `telnet google.com 80` successfully connected to Google's port 80, showing that the TCP connection was established successfully.

## 5. Tcpdump

### Command

```bash
sudo tcpdump -i wlo1 host google.com
```

### Output

```text
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on wlo1, link-type EN10MB (Ethernet), snapshot length 262144 bytes

^C
0 packets captured
945 packets received by filter
839 packets dropped by kernel
```

### What I understood

`tcpdump` is a packet-capturing tool used to observe network traffic on a network interface. The `-i wlo1` option specifies my active Wi-Fi interface, and `host google.com` filters traffic related to Google. In this test, tcpdump started successfully, but no matching packets were captured during the short capture period.

## 6. Nslookup

### Command

```bash
nslookup google.com 8.8.8.8
```

### Output

```text
;; communications error to 8.8.8.8#53: timed out
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	google.com
Address: 142.250.206.174
Name:	google.com
Address: 2404:6800:4009:826::200e
```

### What I understood

`nslookup` is used to query DNS and find the IP address associated with a domain name. Here, I explicitly queried Google's DNS server at `8.8.8.8`. The lookup returned both an IPv4 address and an IPv6 address for `google.com`. The response was marked as non-authoritative, meaning the answer came from a DNS server that is not the authoritative DNS server for the domain.

## 7. Dig

### Command

```bash
dig google.com
```

### Output

```text
;; communications error to 127.0.0.53#53: timed out

; <<>> DiG 9.18.39-0ubuntu0.24.04.2-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 5478
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 4, ADDITIONAL: 5

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.			IN	A

;; ANSWER SECTION:
google.com.		300	IN	A	142.250.207.238

;; AUTHORITY SECTION:
google.com.		46857	IN	NS	ns4.google.com.
google.com.		46857	IN	NS	ns3.google.com.
google.com.		46857	IN	NS	ns1.google.com.
google.com.		46857	IN	NS	ns2.google.com.

;; ADDITIONAL SECTION:
ns4.google.com.		3937	IN	A	216.239.38.10
ns3.google.com.		61842	IN	A	216.239.36.10
ns1.google.com.		69129	IN	A	216.239.32.10
ns2.google.com.		58790	IN	A	216.239.34.10

;; Query time: 34 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Sep 03 23:29:20 IST 2026
;; MSG SIZE  rcvd: 191
```

### What I understood

`dig` is a DNS lookup tool that provides detailed information about a DNS query and response. In this test, the query returned `NOERROR` and provided an IPv4 address for `google.com`. It also displayed the domain's authoritative name servers and the query time.

## 8. Curl

### Command

```bash id="l3yymt"
curl -I https://www.google.com
```

### Output

```text id="w3m7fz"
HTTP/2 200
content-type: text/html; charset=ISO-8859-1
date: Thu, 03 Sep 2026 18:01:34 GMT
server: gws
x-frame-options: SAMEORIGIN
cache-control: private
```

### What I understood

`curl -I` is used to retrieve only the HTTP response headers from a website. The `HTTP/2 200` response indicates that the request was successful and Google returned a valid response.

## 9. ARP

### Command

```bash id="u7h9qk"
arp -a
```

### Output

```text id="p0c4hx"
? (100.129.171.75) at 2a:a5:40:20:04:3f [ether] on wlo1
? (100.129.165.231) at dc:56:7b:15:3f:9f [ether] on wlo1
? (100.129.163.180) at 60:ff:9e:5c:81:ea [ether] on wlo1
? (100.129.167.116) at 30:f6:ef:06:9c:b7 [ether] on wlo1
? (100.129.160.157) at 14:ab:c5:c1:52:82 [ether] on wlo1
? (100.129.160.34) at 9c:c7:d3:2f:0b:9e [ether] on wlo1
? (100.129.160.1) at f4:1e:57:3d:a6:d6 [ether] on wlo1
? (100.129.171.61) at d2:90:20:a6:cd:74 [ether] on wlo1
? (100.129.162.122) at 82:b5:07:44:51:19 [ether] on wlo1
? (100.129.167.191) at b8:f7:75:04:b6:d6 [ether] on wlo1
? (100.129.161.84) at b4:8c:9d:8c:c0:9b [ether] on wlo1
```

### What I understood

`arp -a` displays the ARP table, which maps IP addresses to MAC addresses for devices known on the local network. The output shows several IP-to-MAC address mappings associated with my Wi-Fi interface `wlo1`.

## 10. Systemctl Status NetworkManager

### Command

```bash
systemctl status NetworkManager
```

### Output

```text
● NetworkManager.service - Network Manager
     Loaded: loaded (/usr/lib/systemd/system/NetworkManager.service; enabled; preset: enabled)
     Active: active (running) since Thu 2026-09-03 22:18:19 IST; 1h 14min ago
       Docs: man:NetworkManager(8)
   Main PID: 971 (NetworkManager)
      Tasks: 5 (limit: 18233)
     Memory: 17.5M (peak: 33.6M)
        CPU: 2.258s
     CGroup: /system.slice/NetworkManager.service
             └─971 /usr/sbin/NetworkManager --no-daemon

Sep 03 22:18:27 khushboo-HP-Pavilion-Laptop-15-eh1xxx NetworkManager[971]: <info>  [1788454107.2598] device (docker0): Activation: starting connection 'docker0'
Sep 03 22:18:27 khushboo-HP-Pavilion-Laptop-15-eh1xxx NetworkManager[971]: <info>  [1788454107.2658] device (docker0): Activation: successful, device activated.
Sep 03 22:18:37 khushboo-HP-Pavilion-Laptop-15-eh1xxx NetworkManager[971]: <info>  [1788454117.9066] manager: NetworkManager state is now CONNECTED_GLOBAL
```

### What I understood

`systemctl status NetworkManager` is used to check the status of the NetworkManager service. The output shows that NetworkManager is loaded, enabled, and currently active and running. The `CONNECTED_GLOBAL` state indicates that the system has a working network connection.
