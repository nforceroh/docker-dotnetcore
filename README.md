# docker-dotnetcore
My tweaked .net alpine image as a base image for emby with s6 overlay and NFS support since VMware VIC does not allow for NFS file level volumes

```
docker run -it --rm \
--name test \
-l PUID=3001 \
-l PGID=3000 \
nforceroh/docker-dotnetcore
```
