# Day 32 - Docker Volumes & Networking

## Task 2: Named Volumes

### 1. Create a named volume

```bash
docker volume create postgres-data
```

Verify the volume:

```bash
docker volume ls
docker volume inspect postgres-data
```

### 2. Run PostgreSQL with the named volume

```bash
docker run -d \
  --name postgres-volume \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=testdb \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:16
```

Check the container:

```bash
docker ps
```

### 3. Create a table and add data

Connect to PostgreSQL:

```bash
docker exec -it postgres-volume psql -U postgres -d testdb
```

Create a table:

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    role VARCHAR(50)
);

INSERT INTO employees (name, role)
VALUES
('Riya', 'DevOps Engineer'),
('Amit', 'Cloud Engineer'),
('Neha', 'Developer');

SELECT * FROM employees;
```

Exit PostgreSQL:

```sql
\q
```

### 4. Stop and remove the container

```bash
docker stop postgres-volume
docker rm postgres-volume
```

The container is removed, but the volume is still available.

Verify:

```bash
docker volume ls
```

### 5. Run a brand-new container using the same volume

```bash
docker run -d \
  --name postgres-new \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=testdb \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:16
```

Connect:

```bash
docker exec -it postgres-new psql -U postgres -d testdb
```

Check the data:

```sql
SELECT * FROM employees;
```

### Result

The data is still available.

### Why?

The database files were stored in the Docker named volume instead of the container's writable filesystem.

The container can be deleted and recreated, while the named volume remains.

```text
Container 1
     |
     v
postgres-data volume
     |
     X  Container 1 deleted
     |
     v
Container 2
     |
     v
Data still available
```

### Key Learning

> Named volumes provide persistent storage that survives container deletion.

---

# Task 3: Bind Mounts

## 1. Create a folder on the host

```bash
mkdir -p ~/docker-nginx
cd ~/docker-nginx
```

Create the HTML file:

```bash
vim index.html
```

Add:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Day 32 Docker</title>
</head>
<body>
    <h1>Hello from Docker Bind Mount!</h1>
    <p>This page is coming from my host machine.</p>
</body>
</html>
```

Save the file with:

```text
ESC
:wq
ENTER
```

## 2. Run Nginx with a bind mount

```bash
docker run -d \
  --name nginx-bind \
  -p 8080:80 \
  -v ~/docker-nginx:/usr/share/nginx/html \
  nginx
```

Check:

```bash
docker ps
```

## 3. Access the page

If running on an EC2 server, open:

```text
http://YOUR_EC2_PUBLIC_IP:8080
```

Make sure port `8080` is allowed in the EC2 Security Group.

The browser should display:

```text
Hello from Docker Bind Mount!
```

## 4. Edit the host file

```bash
vim ~/docker-nginx/index.html
```

Change:

```html
<h1>Hello from Docker Bind Mount!</h1>
```

to:

```html
<h1>Hello from Updated Host File!</h1>
```

Save and refresh the browser.

The updated content should appear immediately.

### Why?

The host directory is directly mounted into the container:

```text
Host
~/docker-nginx
      |
      | Bind Mount
      v
Container
/usr/share/nginx/html
```

---

## Named Volume vs Bind Mount

| Named Volume | Bind Mount |
|---|---|
| Managed by Docker | Managed by the user |
| Docker manages the storage location | User specifies the host path |
| Good for persistent application/database data | Good for development and host files |
| `-v volume_name:/path` | `-v /host/path:/container/path` |
| Less dependent on host filesystem structure | Direct access to host files |

### Simple Difference

> **Named Volume:** Docker manages the storage.

> **Bind Mount:** The user chooses and manages the host directory.

---

# Task 4: Docker Networking Basics

## 1. List all Docker networks

```bash
docker network ls
```

Typical output:

```text
NETWORK ID     NAME      DRIVER
xxxxxxx        bridge    bridge
xxxxxxx        host      host
xxxxxxx        none      null
```

## 2. Inspect the default bridge network

```bash
docker network inspect bridge
```

Look at the `Containers` section to see containers connected to the network.

## 3. Run two containers on the default bridge

Run container 1:

```bash
docker run -dit --name container1 alpine sh
```

Run container 2:

```bash
docker run -dit --name container2 alpine sh
```

Check:

```bash
docker ps
```

## 4. Test communication by container name

From `container1`:

```bash
docker exec container1 ping -c 3 container2
```

On the default bridge network, name-based communication normally does not work.

Example:

```text
ping: bad address 'container2'
```

### Result

Name-based communication:

```text
❌ Does not work
```

## 5. Test communication by IP

Find the IP address of `container2`:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container2
```

Example:

```text
172.17.0.3
```

Ping the IP:

```bash
docker exec container1 ping -c 3 172.17.0.3
```

### Result

IP-based communication:

```text
✅ Works
```

### Key Learning

On the default `bridge` network:

```text
container1 ---- IP ----> container2
     ❌ name
     ✅ IP
```

---

# Task 5: Custom Networks

## 1. Create a custom bridge network

```bash
docker network create my-app-net
```

Verify:

```bash
docker network ls
```

## 2. Run two containers on the custom network

```bash
docker run -dit \
  --name app1 \
  --network my-app-net \
  alpine sh
```

```bash
docker run -dit \
  --name app2 \
  --network my-app-net \
  alpine sh
```

## 3. Test communication by container name

```bash
docker exec app1 ping -c 3 app2
```

The ping should succeed.

Example:

```text
64 bytes from 172.x.x.x
64 bytes from 172.x.x.x
64 bytes from 172.x.x.x
```

### Result

Name-based communication:

```text
✅ Works
```

## Why does custom networking allow name-based communication?

User-defined bridge networks provide Docker's embedded DNS service.

Docker automatically resolves the container name to its IP address.

```text
             my-app-net
        +-------------------+
        |                   |
     +------+           +------+
     | app1 | --------> | app2 |
     +------+    DNS    +------+
          container name
```

### Key Learning

> User-defined bridge networks provide automatic DNS-based container name resolution and better network isolation.

---

# Task 6: Put It Together

In this task, I combined:

- Custom Docker network
- PostgreSQL database
- Docker named volume
- Application container
- Container-to-container communication

## 1. Create a custom network

```bash
docker network create my-db-net
```

## 2. Create a Docker volume

```bash
docker volume create postgres-data-final
```

## 3. Run PostgreSQL

```bash
docker run -d \
  --name postgres-db \
  --network my-db-net \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=appdb \
  -v postgres-data-final:/var/lib/postgresql/data \
  postgres:16
```

Check:

```bash
docker ps
```

## 4. Run an application container

For testing, I used Alpine:

```bash
docker run -dit \
  --name app-container \
  --network my-db-net \
  alpine sh
```

## 5. Install PostgreSQL client inside the app container

```bash
docker exec app-container apk add --no-cache postgresql-client
```

## 6. Connect to PostgreSQL using the container name

```bash
docker exec -it app-container \
  psql -h postgres-db -U postgres -d appdb
```

Enter the password:

```text
postgres
```

If the connection is successful:

```text
appdb=#
```

This confirms that the application container can reach PostgreSQL using the database container name:

```text
postgres-db
```

### Final Architecture

```text
                  my-db-net
        +---------------------------+
        |                           |
        |   +-------------------+   |
        |   |  app-container    |   |
        |   +---------+---------+   |
        |             |             |
        |             | postgres-db |
        |             v             |
        |   +-------------------+   |
        |   |    PostgreSQL     |   |
        |   +---------+---------+   |
        |             |             |
        +-------------|-------------+
                      |
                      v
              postgres-data-final
                  Docker Volume
```

### Final Result

The application container successfully reached PostgreSQL using the database container name.

The PostgreSQL data is stored in a named Docker volume, so it can survive container deletion.

---

# Key Learnings

## Docker Volumes

Containers are temporary, but Docker volumes provide persistent storage.

```text
Container
    |
    v
Docker Volume
    |
    v
Persistent Data
```

## Bind Mounts

Bind mounts connect a container directly to a directory or file on the host.

```text
Host Directory
      |
      v
Bind Mount
      |
      v
Container
```

## Docker Networking

The default bridge network allows communication using IP addresses, but does not provide the same automatic container-name DNS resolution as a user-defined bridge network.

## Custom Networks

User-defined bridge networks provide:

- Container name resolution
- Automatic DNS
- Network isolation
- Easy container-to-container communication

## Overall Learning

> Containers provide the runtime environment, volumes provide persistent storage, bind mounts connect containers to host files, and custom networks allow containers to communicate using names.

---

# Cleanup

After completing the tasks, the test containers can be removed:

```bash
docker rm -f postgres-new
docker rm -f nginx-bind
docker rm -f container1
docker rm -f container2
docker rm -f app1
docker rm -f app2
docker rm -f postgres-db
docker rm -f app-container
```

Remove test networks:

```bash
docker network rm my-app-net
docker network rm my-db-net
```

Remove test volumes only if the data is no longer needed:

```bash
docker volume rm postgres-data
docker volume rm postgres-data-final
```

> Do not remove a volume if you want to keep its data.
