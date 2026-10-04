1 What is Docker?
* Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly.
With Docker, you can manage your infrastructure in the same ways you manage your applications.
By taking advantage of Docker's methodologies for shipping, testing, and deploying code, you can significantly reduce the delay between writing code and running it in production.
----------------------------------------------
2 why Docker?
* Docker provides the ability to package and run an application in a loosely isolated environment called a container.
 The isolation and security let you run many containers simultaneously on a given host.
 Containers are lightweight and contain everything needed to run the application, so you don't need to rely on what's installed on the host.
  You can share containers while you work, and be sure that everyone you share with gets the same container that works in the same way.
---------------------------------------------
3 Containers vs Virtual Machines — what's the real difference?
* Containers and virtual machines are very similar resource virtualization technologies. Virtualization is the process in which a system singular resource like RAM, CPU, Disk, or Networking can be ‘virtualized’ and represented as multiple resources. The key differentiator between containers and virtual machines is that virtual machines virtualize an entire machine down to the hardware layers and containers only virtualize software layers above the operating system level.
* <img width="3840" height="1332" alt="image" src="https://github.com/user-attachments/assets/a38b70b0-d110-4b72-9118-361b79c1594b" />
<img width="3840" height="1332" alt="image" src="https://github.com/user-attachments/assets/e8660f87-c4f7-4068-8725-1c237eb64cad" />

-------------------------------------
5 What is the Docker architecture? (daemon, client, images, containers, registry)
* Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The Docker client and daemon can run on the same system, or you can connect a Docker client to a remote Docker daemon. The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface. Another Docker client is Docker Compose, that lets you work with applications consisting of a set of containers.
<img width="1233" height="651" alt="image" src="https://github.com/user-attachments/assets/395dcbda-9494-4be7-86d9-e03b44ac3f72" />

--------------------------------------
4 Docker daemon? ( Dockerd)
*The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. 
A daemon can also communicate with other daemons to manage Docker services.

--------------------------------------
