# Alpine image with logrotate and Docker.

Based on [linkyard/logroate](https://github.com/linkyard/docker-logrotate)
Used to rotate nginx logs in a swarm

```
/logrotate/log/nginx/*.log {
	daily
	missingok
	rotate 52
	compress
	delaycompress
	notifempty
	sharedscripts
	postrotate
		docker service update --force nginx_nginx
	endscript
}
```

```yaml
version: "3.8"

services:
  logrotate:
    image: procedural/logrotate:latest
    volumes:
      - /mnt/head/log/nginx:/logrotate/log/nginx
      - /var/run/docker.sock:/var/run/docker.sock
    configs:
      - source: logrotate_nginx
        target: /etc/logrotate.conf
    deploy:
      placement:
        constraints:
          - node.role == manager
```