

/etc/gitlab-runner/config.toml
```
concurrent = 2

[[runners]]
  name = "local-docker-runner"
  executor = "docker"
  [runners.docker]
    privileged = true
    shm_size = 0
```

