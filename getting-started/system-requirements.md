# System Requirements

## Minimum Hardware & Software

| Component | Requirement |
|-----------|-------------|
| **Operating System** | Ubuntu 22.04.5 LTS (recommended) or Windows 11 Pro/Enterprise |
| **Processor (CPU)** | Intel® 12th Gen i7, i9, or Xeon® — at least 12 cores / 20 threads |
| **Memory (RAM)** | 32 GB minimum |
| **Disk Space** | 2 TB available (M.2 SSD recommended) |
| **Browser** | Google Chrome® or Microsoft Edge® |

> **Using a MinION or other ONT sequencing device?** Higher hardware specs are required for basecalling. See Oxford Nanopore Technology's documentation for device-specific minimums.

---

## Network Requirements

An internet connection is required for installation. After installation, the Software supports offline operation, but an internet connection is recommended during routine use to access the latest MinKNOW compatibility studies and to recover from Docker image failures.

### Required Outbound Endpoints (TCP 443)

| Endpoint | Purpose |
|----------|---------|
| `asgn-one-reporter.bio-techne.com` | Application files |
| `*.execute-api.us-east-1.amazonaws.com` | Authentication services |
| `*.dkr.ecr.*.amazonaws.com` | Docker container registry |
| `archive.ubuntu.com` / `security.ubuntu.com` | Ubuntu APT packages |
| `download.docker.com` | Docker Engine |
| `raw.githubusercontent.com` | Dapr and Nextflow |

### Required Local Ports

| Port | Service |
|------|---------|
| `9000` | Web User Interface |
| `80` | Nginx |
| `3500`, `5123`, `8100`, `8101`, `8103`, `8104` | Backend services |

> **Firewall restrictions?** Your organization's network must permit outbound HTTPS traffic (TCP 443) to all endpoints listed above before installation.
