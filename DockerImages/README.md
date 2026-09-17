# Docker Multi-Stage Build Homework

## Student Details

- **Name:** Khushboo Sigroha
- **Enrollment Number:** 24BCS10340

---

## Task 1: Multi-Stage Docker Build

The multi-stage Docker image was created using the Dockerfile in this folder.

### Docker Image Build

Command used:

```powershell
docker build -t docker-multistage-hello .
```

Build result:

```text
naming to docker.io/library/docker-multistage-hello:latest
```

### Run the Container

Command used:

```powershell
docker run -d -p 8080:8080 --name docker-multistage-app docker-multistage-hello
```

### Application URL

http://localhost:8080

### Expected Application Output

```text
Hello World from Docker multi-stage build
```

---

## Task 2: Evidence

### Application Running

The application was configured to display:

```text
Hello World from Docker multi-stage build
```


### Docker Container Verification

Command used:

```powershell
docker ps
```

The application was configured to run on port `8080`.


## Task 3: Docker Application Deployment

The following three application types were previously deployed using Docker:

| Application Type | Docker Image | Port |
|---|---|---:|
| Node.js | `nodejs-hello-world` | 3000 |
| Python | `python-hello-world` | 5000 |
| Java | `java-hello-world` | 8080 |

All three applications were built and run using Docker in the previous Docker Fundamentals assignment.

---

## Folder Structure

```text
DockerImages/
├── README.md
├── Dockerfile
└── app.py
```

---

## Conclusion

The multi-stage Docker image was successfully built. The application was configured to run on port `8080` and display:

```text
Hello World from Docker multi-stage build
```

Three different application types—Node.js, Python, and Java—were also deployed using Docker.