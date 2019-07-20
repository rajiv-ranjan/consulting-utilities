### Clean up after the commands are executed


The version with the dnf cache is almost twice the size of the image without the metadata and cache. Package manager cache, Ruby gem temp files, nodejs cache, even downloaded source tarballs are all perfect candidates for cleaning up.

Merge multiple RUN as single line in dockerfile

```dockerfile
FROM fedora:28
LABEL maintainer Chris Collins <collins.christopher@gmail.com>

RUN dnf install -y nginx
```


```dockerfile
# Dockerfile w/o cache
FROM fedora:28
LABEL maintainer Chris Collins <collins.christopher@gmail.com>

RUN dnf install -y nginx \
        && dnf clean all \
        && rm -rf /var/cache/yum
```
