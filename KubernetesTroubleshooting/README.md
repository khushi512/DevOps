# Kubernetes Troubleshooting

## 1. Project Overview

This project demonstrates practical Kubernetes troubleshooting using Minikube on Windows with PowerShell. It covers common Pod failures, image-pull errors, scheduling problems, service connectivity, DNS resolution, Pod-to-Pod communication, and application configuration errors.

The goal is to identify symptoms, investigate the underlying cause, apply a targeted fix, and verify the result using Kubernetes commands.

## 2. Environment

- **Operating system:** Windows
- **Terminal:** PowerShell
- **Cluster:** Minikube using the Docker driver
- **Kubernetes version:** v1.37.0
- **Container runtime:** Docker
- **Namespace:** `default`

## 3. Project Structure

```text
KubernetesTroubleshooting/
├── manifests/
│   ├── configuration-error-pod.yaml
│   ├── containercreating-pod.yaml
│   ├── crashloop-pod.yaml
│   ├── dns-failure-pod.yaml
│   ├── imagepull-pod.yaml
│   ├── pending-pod.yaml
│   └── service-connectivity.yaml
├── screenshots/
│   ├── configuration-error.png
│   ├── containercreating-investigation.png
│   ├── crashloop-investigation.png
│   ├── describe-pod.png
│   ├── dns-investigation.png
│   ├── events.png
│   ├── exec.png
│   ├── explain.png
│   ├── get-pods.png
│   ├── imagepull-investigation.png
│   ├── logs.png
│   ├── pending-investigation.png
│   ├── pod-networking.png
│   ├── service-connectivity-before.png
│   ├── service-connectivity.png
│   ├── top-all-namespaces.png
│   └── top-metrics.png
└── README.md
```

## 4. Task 1 — Kubernetes Diagnostic Commands

The first task explored commands used to inspect and troubleshoot Kubernetes resources.

| Command | Purpose |
|---|---|
| `kubectl get pods` | Check Pod status |
| `kubectl describe pod <pod-name>` | Inspect Pod configuration, conditions, and events |
| `kubectl logs <pod-name>` | Read application logs |
| `kubectl exec <pod-name> -- <command>` | Execute a command inside a container |
| `kubectl get events` | Inspect cluster events |
| `kubectl explain pod` | Explore Kubernetes resource specifications |
| `kubectl top pods` | Inspect Pod resource usage |
| `kubectl top pods -A` | Inspect resource usage across namespaces |

The metrics-server addon was enabled to support resource-usage inspection.

### Task 1 screenshots

- `screenshots/get-pods.png`
- `screenshots/describe-pod.png`
- `screenshots/logs.png`
- `screenshots/exec.png`
- `screenshots/events.png`
- `screenshots/explain.png`
- `screenshots/top-metrics.png`
- `screenshots/top-all-namespaces.png`

## 5. Task 2 — Common Kubernetes Troubleshooting Scenarios

### 5.1 CrashLoopBackOff

**Manifest:** `manifests/crashloop-pod.yaml`

**Problem:** The container's command deliberately exited with status code `1`, causing Kubernetes to restart the container repeatedly.

**Investigation commands:**

```powershell
kubectl get pod troubleshooting-crashloop
kubectl describe pod troubleshooting-crashloop
kubectl logs troubleshooting-crashloop
kubectl get events
```

**Root cause:** The application process terminated unsuccessfully. With `restartPolicy: Always`, Kubernetes attempted to restart it, eventually applying restart backoff.

**Solution:** Changed the command to print a startup message and remain running with `sleep 3600`. Since the Pod's command could not be changed in place, the Pod was deleted and recreated.

**Verification:** The recreated Pod reached `Running` with `1/1` ready and zero restarts.

**Evidence:** `screenshots/crashloop-investigation.png`

### 5.2 ErrImagePull and ImagePullBackOff

**Manifest:** `manifests/imagepull-pod.yaml`

**Problem:** The Pod initially referenced a nonexistent NGINX image tag.

**Investigation commands:**

```powershell
kubectl get pod troubleshooting-imagepull
kubectl describe pod troubleshooting-imagepull
```

**Root cause:** The container image could not be downloaded because the specified tag did not exist in the registry.

`ErrImagePull` indicates an image-pull attempt failed. `ImagePullBackOff` indicates Kubernetes is delaying subsequent retries.

**Solution:** Replaced the invalid image tag with `nginx:1.29-alpine` and recreated the Pod.

**Verification:** The Pod reached `Running` with `1/1` ready.

**Evidence:** `screenshots/imagepull-investigation.png`

### 5.3 Pending Pod

**Manifest:** `manifests/pending-pod.yaml`

**Problem:** The Pod remained Pending because its `nodeSelector` required a node label that the Minikube node did not have.

**Investigation commands:**

```powershell
kubectl get pod troubleshooting-pending -o wide
kubectl describe pod troubleshooting-pending
```

**Root cause:** The scheduler could not find a node matching the configured selector.

**Solution:** Removed the nonexistent node selector and recreated the Pod.

**Verification:** The Pod was scheduled on `minikube`, obtained a Pod IP, and reached `Running` with `1/1` ready.

**Evidence:** `screenshots/pending-investigation.png`

### 5.4 ContainerCreating investigation

**Manifest:** `manifests/containercreating-pod.yaml`

**Problem investigated:** A Pod can remain in `ContainerCreating` while Kubernetes prepares its container, including image retrieval, volume setup, and container configuration.

**Investigation commands:**

```powershell
kubectl get pod troubleshooting-containercreating -w
kubectl describe pod troubleshooting-containercreating
```

**Observed result:** In this run, the Pod progressed to `ErrImagePull` and `ImagePullBackOff` because its image tag did not exist. A separate, sustained `ContainerCreating` failure was not independently reproduced.

**Finding:** Pod status should be interpreted alongside container states and events. The underlying image-pull error provided the actionable diagnosis in this case.

**Evidence:** `screenshots/containercreating-investigation.png`

### 5.5 Service connectivity

**Manifest:** `manifests/service-connectivity.yaml`

**Problem:** The Service existed, but it initially had no usable backend endpoints.

**Investigation commands:**

```powershell
kubectl get service troubleshooting-service
kubectl get endpoints troubleshooting-service
kubectl get endpointslice -l kubernetes.io/service-name=troubleshooting-service
```

**Root cause:** The Service selector did not match the labels on the intended NGINX Pod.

**Solution:** Corrected the selector to `app: troubleshooting-imagepull`.

**Verification:** The EndpointSlice showed the backend Pod IP and port 80. A request from a temporary BusyBox client to `http://troubleshooting-service` returned the NGINX welcome page.

**Evidence:**
- `screenshots/service-connectivity-before.png`
- `screenshots/service-connectivity.png`

### 5.6 DNS resolution

**Manifest:** `manifests/dns-failure-pod.yaml`

**Problem:** The test Pod was initially configured with an invalid DNS nameserver, `192.0.2.1`.

**Investigation command:**

```powershell
kubectl exec troubleshooting-dns-failure -- nslookup troubleshooting-service
```

**Root cause:** The Pod was using the deliberately invalid nameserver instead of Kubernetes cluster DNS.

**Solution:** Changed `dnsPolicy` to `ClusterFirst` and removed the custom nameserver configuration. The Pod was recreated because its DNS settings could not be updated in place.

**Verification:**

```powershell
kubectl exec troubleshooting-dns-failure -- nslookup troubleshooting-service.default.svc.cluster.local
```

The lookup succeeded using the cluster DNS service at `10.96.0.10` and resolved the Service to its ClusterIP.

**Evidence:** `screenshots/dns-investigation.png`

### 5.7 Pod networking and port connectivity

**Problem:** A request to the NGINX Pod IP on port 81 failed, while a request to port 80 succeeded.

**Investigation commands:**

```powershell
kubectl get pod troubleshooting-imagepull -o wide
kubectl exec troubleshooting-dns-failure -- wget -qO- --timeout=5 http://10.244.0.21:81
kubectl exec troubleshooting-dns-failure -- wget -qO- --timeout=5 http://10.244.0.21:80
```

**Observed result:** Port 81 returned `Connection refused`; port 80 returned the NGINX welcome page.

**Root cause:** NGINX was listening on port 80, not port 81.

**Solution:** Used the correct destination port.

**Verification:** Successful HTTP response from the Pod IP on port 80 confirmed that Pod-to-Pod communication worked for this test. This scenario demonstrated port-level troubleshooting; it did not establish a general cluster networking failure.

**Evidence:** `screenshots/pod-networking.png`

### 5.8 Application configuration error

**Manifest:** `manifests/configuration-error-pod.yaml`

**Problem:** The application expected the `APP_MODE` environment variable. When it was absent, the process printed an error and exited with status code `1`.

**Investigation commands:**

```powershell
kubectl get pod troubleshooting-config
kubectl logs troubleshooting-config
```

**Observed log:**

```text
ERROR: APP_MODE is not configured
```

**Root cause:** The required environment variable was missing from the container configuration.

**Solution:** Added the following environment variable to the manifest and recreated the Pod:

```yaml
env:
  - name: APP_MODE
    value: "development"
```

**Verification:** The Pod reached `Running` with `1/1` ready and zero restarts. The logs showed:

```text
Application started in development mode
```

**Evidence:** `screenshots/configuration-error.png`

## 6. Task 3 — Mini-Project Summary

### Problem statement

Kubernetes workloads can become unavailable because of invalid container images, application crashes, scheduling constraints, service selector mismatches, DNS configuration errors, incorrect ports, or missing application configuration. These failures may initially present as similar symptoms, making systematic investigation necessary.

### Investigation approach

The project used a repeatable troubleshooting process:

1. **Identify:** Inspect resource status using `kubectl get`.
2. **Investigate:** Use `kubectl describe`, logs, events, and targeted connectivity tests.
3. **Diagnose:** Relate the observed error or event to the underlying configuration or application issue.
4. **Fix:** Change the relevant manifest or configuration.
5. **Verify:** Recreate resources when required, then confirm their status and behavior.
6. **Document:** Record the cause, resolution, commands, and supporting screenshots.

### Key findings

- Pod status alone may not reveal the underlying cause; events and logs provide additional evidence.
- Image-pull errors require checking the image name and tag.
- Scheduling constraints can leave a Pod Pending even when the cluster is running.
- A Service can exist without a working backend when its selector does not match Pod labels.
- DNS failures can result from incorrect Pod DNS configuration rather than a cluster-wide DNS failure.
- A reachable Pod IP does not guarantee that every port is accepting connections.
- Missing environment variables can cause application startup failures and repeated container restarts.
- Fixes must respect Kubernetes resource immutability; some changes require deleting and recreating a Pod.

### Outcome

The project practiced identifying and resolving multiple common Kubernetes failure scenarios in a local Minikube cluster. Each completed scenario was verified using command output, and the investigation evidence was organized in the `screenshots` directory.

The ContainerCreating scenario was investigated, but a distinct persistent ContainerCreating failure was not reproduced during this exercise.

## 7. General Troubleshooting Checklist

When a Kubernetes workload is not working:

- [ ] Check Pod and workload status.
- [ ] Inspect Pod details, conditions, and events.
- [ ] Review current application logs.
- [ ] Check image names, tags, and pull errors.
- [ ] Verify scheduling requirements and node availability.
- [ ] Check labels, Service selectors, and EndpointSlices.
- [ ] Test DNS resolution and connectivity using the correct destination port.
- [ ] Validate required environment variables and configuration resources.
- [ ] Apply the fix and verify the resulting behavior.
