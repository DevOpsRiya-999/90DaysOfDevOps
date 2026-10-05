Task 1: Docker Images
```bash
docker pull nginx
docker pull ubuntu

docker images -a

```
<img width="1917" height="336" alt="image" src="https://github.com/user-attachments/assets/6dee1555-d7cd-42fc-adce-4f8fe172ea1a" />
1> what is alpine and why it is small?
* Alpine Linux is a security-oriented, lightweight Linux distribution designed for power users, routers, firewalls, VPNs, and—most famously—as a base image for Docker containers.
While a standard Ubuntu Docker image takes up around 78 MB, an Alpine Linux base image is only around 5 MB to 7 MB.
* Alpine cuts out all the fat found in traditional Linux operating systems by replacing heavy standard components with minimalist alternatives:
• It uses musl libc instead of glibc: Standard Linux distributions use the GNU C Library (glibc). Alpine uses musl libc, a much smaller, resource-efficient C standard library written from scratch.
• It uses BusyBox instead of GNU Coreutils: Instead of installing hundreds of individual utilities (like ls, cat, grep, sed), Alpine uses BusyBox. BusyBox combines tiny versions of many common UNIX utilities into a single, highly optimized executable file.

2> Inspect an image — what information can you see?
* I can see 
```bash
ubuntu@ip-172-31-47-20:~/Docker-practice$ docker image inspect alpine # change image name accordingly
[
    {
        "Id": "sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6",
        "RepoTags": [
            "alpine:latest"
        ],
        "RepoDigests": [
            "alpine@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6"
        ],
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2026-09-17T20:37:20.889221879Z",
        "Config": {
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh"
            ],
            "WorkingDir": "/"
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 3860589,
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:74d97c428c51a828f9051a7a40a53ff1fc99e54fc30323ce36760701b0b7f711"
            ]
        },
        "Metadata": {
            "LastTagTime": "2026-10-05T18:21:39.523018976Z"
        },
        "Descriptor": {
            "mediaType": "application/vnd.oci.image.index.v1+json",
            "digest": "sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6",
            "size": 9218
        }

```
---------------------------------------------
3> Remove an image you no longer need
```bash
docker -rmi <Image Name>
```
<img width="1896" height="525" alt="image" src="https://github.com/user-attachments/assets/4de83e46-6984-439c-9c2f-4af0163a1dcc" />

-------------------------------
# Task 2: Image Layers
1> Run docker image history nginx — what do you see?
<img width="1911" height="770" alt="image" src="https://github.com/user-attachments/assets/1850b132-61ef-4699-b108-5d20f1a3b37a" />
---------------
2> What Are Layers?
• Build steps: Each command in a configuration file (like FROM, RUN, or COPY) creates a new layer.
• File changes: Each layer stores only the differences, or "diffs," such as added, changed, or deleted files.
• Immutability: Once created, a layer cannot change. Any update adds a brand-new layer on top.
• Unified view: A special system merges all the layers into one single file tree for the application.
#> Why Does Docker Use Layers?
• Saving space: Multiple apps can share the same base layers (like an OS layer) so they are stored only once on your hard drive.
• Faster builds: Docker saves and reuses unchanged layers during builds so it does not repeat work.
• Quick sharing: When downloading or uploading updates, Docker only transfers the new or changed layers instead of the whole file

----------------------------
# Task 3: Container Lifecycle
1.Create a container (without starting it)
```bash
docker create nginx

docker ps -a
```
<img width="1895" height="341" alt="image" src="https://github.com/user-attachments/assets/8fb1d96a-a9d2-4b99-8584-794abcf152de" />

2.Start the container
```bash
docker start nginx < container ID>

```
<img width="1917" height="367" alt="image" src="https://github.com/user-attachments/assets/88098815-6b9b-4dd9-837a-e9c8ba1a941e" />
3.Pause it and check status
```bash
docker pause < container ID>
```
<img width="1917" height="287" alt="image" src="https://github.com/user-attachments/assets/26bae528-c4c1-4e35-96a1-3766585a8750" />
-----------------------------
4.Stop it
```bash
docker stop <container ID>
```
<img width="1917" height="215" alt="image" src="https://github.com/user-attachments/assets/1928c43f-6f84-4f0d-8a3c-957582bb62c2" />
--------------------------
5.Restart 
```bash
docker restart <container ID>
docker rmi <container ID>
docker kill < Container ID>
```
--------------------------
# Task 4: Working with Running Containers
1. Run an Nginx container in detached mode
```bash
docker run -d -p 8080:80 --name my-nginx nginx
```
<img width="1917" height="360" alt="image" src="https://github.com/user-attachments/assets/85c0425c-c5e6-4058-9063-94382fc42e55" />
2.View its logs
```bash
docker logs <container ID>
```
<img width="1711" height="605" alt="image" src="https://github.com/user-attachments/assets/e561ffd3-39b2-4fc1-92d2-fe791aa009da" />
3. Exec into the container and look around the filesystem
```bash
docker exec -it <container ID> bash
```
<img width="1915" height="220" alt="image" src="https://github.com/user-attachments/assets/5fdfa64a-f20c-485d-a062-d5d4a6e93490" />
4.Run a single command inside the container without entering it
```bash
docker exec my-nginx ls /etc/nginx
docker exec my-nginx cat /etc/nginx/nginx.conf
docker exec -e DEBUG=true my-nginx printenv
docker exec -w /var/log/nginx my-nginx ls
```
<img width="1801" height="462" alt="image" src="https://github.com/user-attachments/assets/66658d23-c4c0-40ed-a722-48b438874005" />

5.Inspect the container — find its IP address, port mappings, and mounts
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-nginx
docker inspect -f '{{.NetworkSettings.Ports}}' my-nginx
docker inspect -f '{{json .Mounts}}' my-nginx
```
<img width="1917" height="305" alt="image" src="https://github.com/user-attachments/assets/1a14a18b-8351-40d3-a565-9118887ff38e" />

-----------------------------------
# Task 5: Cleanup
1.Stop all running containers in one command
```bash
ocker stop $(docker ps -aq)
# Remove all stopped containers in one command
docker container prune
# Remove unused images or Safe cleanup
docker image prune -a
docker image prune -f
#Check how much disk space Docker is using
docker system df --verbose
docker system df 
```
<img width="1756" height="835" alt="image" src="https://github.com/user-attachments/assets/326b5148-e5be-4934-9de0-b03b7cfcd8e9" />

