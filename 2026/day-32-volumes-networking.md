Task 1: The Problem
* Docker containers are ephemeral by default.
* When PostgreSQL stored the database inside the container's writable filesystem:
```bash
PostgreSQL
    ↓
Container filesystem
    ↓
postgres-demo
```
* Removing the container removed that filesystem too:
```bash
docker rm postgres-demo
        ↓
Container deleted
        ↓
Data deleted ❌
```
## Result: When I removed the PostgreSQL container, the database and table were lost. This happened because the data was stored inside the container's writable filesystem. 
Containers are temporary, so persistent database data should be stored in a Docker volume.

-------------------------------
# Task 2: Named Volumes

<img width="1436" height="247" alt="image" src="https://github.com/user-attachments/assets/a68d689d-8ac8-489e-a967-c6e03482ac64" />
✅ Result
Your data is still there!
<img width="1917" height="687" alt="image" src="https://github.com/user-attachments/assets/48b7cdb1-9026-43a4-b0c0-a9ff7da5b908" />
Why?
The database files were stored in the Docker volume, not inside the container.
```bash
Container 1
    ↓
postgres-data volume
    ↓
Container 1 deleted ❌

postgres-data volume
    ↓
Container 2
    ↓
Data still available ✅
```
# Task 3: Bind Mounts
* What is the difference between a named volume and a bind mount?
| Named Volume | Bind Mount |
|---|---|
| Managed by Docker | Managed by the user |
| Docker decides storage location | User specifies host path |
| Good for databases | Good for development/config/files |
| `docker volume create` | Create folder yourself |
| `-v myvolume:/path` | `-v /host/path:/container/path` |
| Less dependent on host filesystem | Direct access to host files |
<img width="1172" height="552" alt="image" src="https://github.com/user-attachments/assets/d64bb583-3df7-407d-8a0a-b20eaab87deb" />

---------------------------
Task 4: Docker Networking Basics
1. List all Docker networks on your machine
```bash
docker network ls
```
<img width="1165" height="377" alt="image" src="https://github.com/user-attachments/assets/b65a5647-d228-4232-97c9-2ba57258a971" />
2. Inspect the default bridge
```bash
docker network inspect bridge
```
<img width="1567" height="658" alt="image" src="https://github.com/user-attachments/assets/fd7dc0fb-5aaa-46e3-acdc-38c5913732bb" />
4. Try ping by container name
❌ Name-based communication doesn't work
The default bridge network does not provide Docker's automatic container-name DNS resolution in the same way that user-defined bridge networks do.
``` bash
docker exec container1 ping -c 3 container2
```
<img width="1892" height="576" alt="image" src="https://github.com/user-attachments/assets/bd7d527b-ac79-450b-ac6e-c817cbd98ffe" />
5. Try ping using IP
```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container2
# you will get ip of your container2 
docker exec container1 ping -c 3 172.17.0.3

Default bridge

container1 ──────── IP ────────> container2
      ❌ name
      ✅ IP
```

<img width="1667" height="465" alt="image" src="https://github.com/user-attachments/assets/527ce2e8-799c-4ae7-b9ac-16db116bc1ff" />
# Task 5: Custom Networks
```bash
docker network create my-app-net
docker network ls
# creating container
docker run -dit \
  --name app1 \
  --network my-app-net \
  alpine sh
  # second app 
  docker run -dit \
  --name app2 \
  --network my-app-net \
  alpine sh
  ## for pinging by name 
  docker exec app1 ping -c 3 app2
  ```
<img width="1442" height="380" alt="image" src="https://github.com/user-attachments/assets/a27b53aa-926b-48a0-9c4f-55a6edfd5c6e" />
* Why does custom networking allow name-based communication?
A user-defined bridge network provides automatic DNS-based service discovery between containers.
              my-app-net
        ┌─────────────────────┐
        │                     │
    ┌───────┐             ┌───────┐
    │ app1  │─────────────▶│ app2  │
    └───────┘    DNS       └───────┘
       │                       │
       └──── container name ───┘
 ----------------------------------
# Task 6: Put It Together
Now let's combine volume + networking + database.
We'll use PostgreSQL.
```bash
docker network create my-db-net
docker volume create postgres-data-final
# 3. Run PostgreSQL
docker run -d \
  --name postgres-db \
  --network my-db-net \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=appdb \
  -v postgres-data-final:/var/lib/postgresql/data \
  postgres:16
  # 4. Run an app container
For a simple test, use Alpine:
docker run -dit \
  --name app-container \
  --network my-db-net \
  alpine sh
  ```

* Install PostgreSQL client inside Alpine:
```bash
docker exec app-container apk add --no-cache postgresql-client
# Now connect using the database container name:
docker exec -it app-container \
  psql -h postgres-db -U postgres -d appdb

```
<img width="1631" height="802" alt="image" src="https://github.com/user-attachments/assets/0b30d511-660c-4560-845d-1588c75bea52" />

## final Architechture
                 my-db-net
        ┌──────────────────────────┐
        │                          │
        │   ┌───────────────┐      │
        │   │ app-container │      │
        │   └───────┬───────┘      │
        │           │              │
        │           │ postgres-db  │
        │           ▼              │
        │   ┌───────────────┐      │
        │   │  PostgreSQL   │      │
        │   └───────┬───────┘      │
        │           │              │
        └───────────┼──────────────┘
                    │
                    ▼
          postgres-data-final
              Docker Volume
