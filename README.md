# volume-sharer

On my windows 10 laptop from work it is possible to make use of Docker, but due to security restrctions that are in place, I am not able to bind mount a windows folder in a container.

In order to be able to still work easily with data volumes and access the content of them from within my windows environment I updated the dperson/samba container image to not only contain a Docker installation to check all data volumes, but also keep on refreshing the list of shares whenever a data volumes are added/removed.

# Usage

Most important is that we need to volume mount the docker volumes directory, as well as the docker socket.

This means that we will need the following:
* ```-v /var/lib/docker/volumes:/docker_volumes``` to bind mount the directory holding all docker volumes
* ```-v /var/run/docker.sock:/var/run/docker.sock``` to bind mount the docker socket, allowing the docker within the container to query information about the volumes

## Windows
When running under windows, it will typically already run the SMB shares on the ports 139 and 445 so you cannot use these ports. In order to work around this, you can state that you do not want to bind the ports to the windows host system, but that I want to bind them to the docker image running in Hyper-V.

This is achieved by giving it the same net as the Hyper-V by using the following commandline:
```docker run --name volume-sharer  --rm -v /var/lib/docker/volumes:/docker_volumes -p 139:139 -p 445:445  -v /var/run/docker.sock:/var/run/docker.sock -d gdiepen/volume-sharer``` 



## Linux
If you don't have samba running on your host-system, you can bind the ports. The complete commandline will be:

```docker run --name volume-sharer  --rm -v /var/lib/docker/volumes:/docker_volumes -p 139:139 -p 445:445  -v /var/run/docker.sock:/var/run/docker.sock -d gdiepen/volume-sharer```





