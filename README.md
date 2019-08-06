# Week 01 - Assignments 5
Dockerizar aplicacion Java

1. Se debe proveer el Dockerfile y los archivos necesarios para generar la imagen
2. Debe quedar corriendo el container
3. Debe proveerse un link para probar el funcionamiento del contenedor

## Paso 1. Instalar docker y levantar servicio.

yum -y install docker
systemctl start docker
docker version

## Paso 2. Crear Dockerfile

Creo Docker file en ./docker/journal3.3/Dockerfile y corro el siguiente comando.

docker build --rm=true --no-cache --force-rm --tag journal:3.3

Esto crea una imagen

```
#docker images | grep journal
journal             3.3                 ba142ebe3ac7        About an hour ago   706 MB
```

luego corremos la app dockerizada

```
docker run --rm -p 8080:8080 --net=host --name=journal journal:3.3
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a5-docker/images/java-docker-run.png "java-docker-run.png")

