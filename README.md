# Week 01 - Assignments 6

Subir imagen a Nexus o Docker Hub

	1. La imagen de Docker debe quedar accesible desde Nexus
	2. Se debe proveer el comando para subir una imagen a Nexus junto con un comando para descargar la imagen y correr el contenedor
	3. Debe proveerse el sistema lógico de taggeo de imágenes

## Paso 1. Subir imagen a Nexus 

Tenemos problemas con la autenticacion sobre Nexus, las pruebas que hice para verificarlo son las siguientes.

### 1. Nexus

Cuando intento hacer le login con las credenciales falla, tanto con http/https.

```
[root@sre-bootcamp-ga-20190805 week01]# docker login -u Bootcamp -p Bootcamp1! 10.252.7.162:8081
Error response from daemon: Get https://10.252.7.162:8081/v1/users/: http: server gave HTTP response to HTTPS client
[root@sre-bootcamp-ga-20190805 week01]#
```

Encontre esta nota donde dice que recreando un repo podemos tener algo de suerte, no lo recree pero si cree otro.

	https://stackoverflow.com/questions/53009082/push-docker-image-to-nexus-3

Luego encontre esta nota, donde habla de los dos puertos que utiliza para el proxy (ir a buscar afuera) y el privado (nuestro interno)

En la configuracion de nuestro repo en nexus veo que esta habilitado para el proxy el 8082 y repo 8081.

	Nota: 
	https://blog.sonatype.com/using-nexus-3-as-your-repository-part-3-docker-images

	Nuestro repo
	http://10.252.7.162:8081/repository/docker_repo/

```
Important to notice: the Docker repo requires 2 different ports. We are going to use 8082 for pull from the proxy repo and 8083 for pull and push to the private repo.
```

En el servidor de nexus veo que el container docker donde corre nexus solo expone un puerto el 8081.

```
[root@jenkinsmaster ~]# docker ps -a
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS                   PORTS                    NAMES
180412733a7c        docker.io/sonatype/nexus3   "sh -c ${SONATYPE_DIR"   8 weeks ago         Up 5 weeks               0.0.0.0:8081->8081/tcp   reverent_brattain
8fcbf4d555db        docker.io/sonatype/nexus3   "sh -c ${SONATYPE_DIR"   8 weeks ago         Exited (0) 8 weeks ago                            angry_babbage
71543d6a143e        sonatype/nexus3             "sh -c ${SONATYPE_DIR"   8 weeks ago         Exited (1) 5 weeks ago   0.0.0.0:8081->8081/tcp   nexus
[root@jenkinsmaster ~]#
```

Tendriamos que probar de exponer los dos puertos o a lo sumo re-crear el repo solo para docker como dice la nota

## 2. Docker Hub

Tagueo, publico y descargo imagenes a un repo. Dejo todos los pasos.

```
docker login docker.io
docker tag journal:3.3-SNAPSHOT gonzaloacosta/journal:3.3-SNAPSHOT
docker push gonzaloacosta/journal:3.3-SNAPSHOT
docker rmi gonzaloacosta/journal:3.3-SNAPSHOT --force
docker pull gonzaloacosta/journal:3.3-SNAPSHOT
docker run --rm -d -p 8080:8080 docker.io/gonzaloacosta/journal:3.3-SNAPSHOT
docker ps -a
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a6-docker-images/images/java-docker-push-rmi-pull.png "java-docker-push-rmi-pull.png")
