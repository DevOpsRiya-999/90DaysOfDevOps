# Day 31 – Dockerfile: Build Your Own Images
Task 1: Your First Dockerfile
```bash
# Dockerfile
FROM ubuntu
RUN apt-get update && apt-get install -y curl
CMD ["echo", "Hello from my custom image!"]

```
<img width="1917" height="642" alt="image" src="https://github.com/user-attachments/assets/b389cb48-23bb-46a3-a799-1336c59a72d9" />
------------------------------------------
Task 2: Dockerfile Instructions

<img width="1491" height="562" alt="image" src="https://github.com/user-attachments/assets/6a589f99-5d91-45e4-8471-499c606637f3" />
<img width="1913" height="882" alt="image" src="https://github.com/user-attachments/assets/f5911d02-39b8-4cec-8305-81553a115b2c" />

-----------------------------------
Task 3: CMD vs ENTRYPOINT

<img width="1856" height="566" alt="image" src="https://github.com/user-attachments/assets/6eb8dc22-e1a6-491c-8bd0-15284ad3a4ce" />

Write in your notes: When would you use CMD vs ENTRYPOINT?
• Use ENTRYPOINT when your container is intended to act as a dedicated executable (a single-purpose tool like a CLI tool, a specific database server, or a background worker) where you want a core command to always run.
• Use CMD when you want to provide a flexible default command or fallback parameter that users can easily override right from the command line when they run docker run.
• The Best Practice: Combine them. Use ENTRYPOINT to set the fixed base binary/executable, and use CMD to supply the default arguments or file paths.
----------------------------------
Task 4: Build a Simple Web App Image

-------------------------------
Why does layer order matter for build speed?
1. The Domino Effect (Cache Busting): Docker builds images layer-by-layer, reading the Dockerfile from top to bottom. The moment one layer changes, that specific layer's cache is broken ("busted"). Crucially, every single subsequent layer below it is also forced to invalidate and rebuild from scratch, even if those lower files didn't change.
2. Efficiency Strategy: By placing structural configurations (like installing packages, setting environments, or pulling base images) at the top, Docker can reuse those cached steps indefinitely. By placing volatile application code (COPY .) at the very bottom, you ensure that everyday code updates only trigger a rebuild of the very last layer, dropping build times from minutes to milliseconds.
