---
title: Bitwarden On Docker
date: 2021-02-02 23:32:12
tags: [Docker,Bitwarden]
---

## Docker
```bash
yum install docker
# ------
su root
systemctl enable docker
systemctl start docker
systemctl restart docker

```
## Portainer
```bash
sudo docker pull portainer/portainer
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

## Bitwarden
```bash
docker pull bitwardenrs/server:latest
docker run -d --name bitwarden -v /var/run/bitwarden/:/data/ -p 80:9001 bitwardenrs/server:latest
```
<!-- more -->

## Other

### Job for docker.service failed because the control process exited with error code. See "systemctl status docker.service" and "journalctl -xe" for details.
```bash
rm /etc/docker/daemon.json
systemctl restart docker
```

### Image accelerator
- https://cr.console.aliyun.com/cn-beijing/instances/mirrors


```bash
sudo systemctl cat docker | grep '\-\-registry\-mirror'
sudo nano /etc/docker/daemon.json
```
```bash
{
  "registry-mirrors": ["this link from aliyun"]
}
```
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## Refer
- [bitwarden](https://bitwarden.com/download/)
- [dani-garcia/bitwarden_rs](https://github.com/dani-garcia/bitwarden_rs)
- [Install and Deploy](https://bitwarden.com/help/article/install-on-premise/)
- [bitwarden/setup](https://hub.docker.com/r/bitwarden/setup)