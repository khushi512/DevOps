
# Docker Fundamentals

## Folder Structure

```text
DockerFundamentals/
├── nodejs-app/
│   ├── app.js
│   └── Dockerfile
│
├── python-app/
│   ├── app.py
│   └── Dockerfile
│
├── java-app/
│   ├── HelloWorld.java
│   └── Dockerfile
│
├── Apache-app/
│   ├── index.html
│   └── Dockerfile
│
├── React-app/
│   ├── src/
│   ├── package.json
│   ├── package-lock.json
│   └── Dockerfile
│
├── nginx-app/
│   ├── index.html
│   └── Dockerfile
│
└── README.md
```

## 1. Node.js Application

### Description

A simple Node.js web application that displays Hello World.

### Build Docker Image

PowerShell

```
cd nodejs-app
docker build -t nodejs-hello-world .
```

### Run Docker Container

PowerShell

```
docker run -d -p 3000:3000 --name nodejs-app nodejs-hello-world
```

### Verification

Open the following URL in a browser:

```
http://localhost:3000
```

Output:

```
Hello World
```

### Stop and Remove Container

PowerShell

```
docker stop nodejs-app
docker rm nodejs-app
```

## 2. Python Application

### Description

A simple Python web application that displays Hello World.

### Build Docker Image

PowerShell

```
cd python-app
docker build -t python-hello-world .
```

### Run Docker Container

PowerShell

```
docker run -d -p 5000:5000 --name python-app python-hello-world
```

### Verification

Open:

```
http://localhost:5000
```

Output:

```
Hello World
```

### Stop and Remove Container

PowerShell

```
docker stop python-app
docker rm python-app
```

## 3. Java Application

### Description

A simple Java web application that displays Hello World.

### Build Docker Image

PowerShell

```
cd java-app
docker build -t java-hello-world .
```

### Run Docker Container

PowerShell

```
docker run -d -p 8080:8080 --name java-app java-hello-world
```

### Verification

Open:

```
http://localhost:8080
```

Output:

```
Hello World
```

### Stop and Remove Container

PowerShell

```
docker stop java-app
docker rm java-app
```

## 4. Apache Web Server

### Description

A simple HTML page served using the Apache web server.

### Build Docker Image

PowerShell

```
cd Apache-app
docker build -t apache-hello-world .
```

### Run Docker Container

PowerShell

```
docker run -d -p 8081:80 --name apache-app apache-hello-world
```

### Verification

Open:

```
http://localhost:8081
```

Output:

```
Hello World
```

### Stop and Remove Container

PowerShell

```
docker stop apache-app
docker rm apache-app
```

## 5. React Application

### Description

A simple React application that displays Hello World.

### Build Docker Image

PowerShell

```
cd React-app
docker build -t react-hello-world .
```

### Run Docker Container

PowerShell

```
docker run -d -p 3001:80 --name react-app react-hello-world
```

### Verification

Open:

```
http://localhost:3001
```

Output:

```
Hello World
```

### Stop and Remove Container

PowerShell

```
docker stop react-app
docker rm react-app
```

## 6. Nginx Application

### Description

A simple HTML page served using the Nginx web server.

### Build Docker Image

PowerShell

```
cd nginx-app
docker build -t nginx-hello-world .
```

### Run Docker Container

PowerShell

```
docker run -d -p 8082:80 --name nginx-app nginx-hello-world
```

### Verification

Open:

```
http://localhost:8082
```

Output:

```
Hello World
```

### Stop and Remove Container

PowerShell

```
docker stop nginx-app
docker rm nginx-app
```

## Conclusion

All six applications were containerized using Docker. Each application was built into a Docker image, run inside a Docker container, and verified by displaying Hello World in a web browser.
