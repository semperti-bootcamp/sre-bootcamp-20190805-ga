# Week 01 - Assignments 5
Dockerizar aplicacion Java

1. Se debe proveer el Dockerfile y los archivos necesarios para generar la imagen
2. Debe quedar corriendo el container
3. Debe proveerse un link para probar el funcionamiento del contenedor

	Link: http://10.252.7.178:8080

## Paso 1. Instalar docker y levantar servicio.

yum -y install docker
systemctl start docker
docker version

## Paso 2. Crear Dockerfile con network namespace default

Creo Docker file en ./docker/journal4.0/Dockerfile y corro el siguiente comando.

docker build --rm=true --no-cache --force-rm --tag journal:4.0

Esto crea una imagen

```
#docker images | grep journal
journal             4.0                 ba142ebe3ac7        About an hour ago   706 MB
```

Si definimos jdbc=localhost:3306 la app va a levantar solo si mapeamos el network namespace al default (host), pero esto no permite
levantar el container en otro host. 

```
docker run --rm -p 8080:8080 --net=host --name=journal journal:4.0
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a5-docker/images/java-docker-run.png "java-docker-run.png")

Para que corra en caulquier otro host y se conecte a la misma base debemos hacer lo siguiente.

	1. Modificar los permisos de root o definir un usuario de conexion a la base de datos mysql para que se pueda conectar desde otros host.
	   En este caso, le di permisos a root para todos los host, modo de ejemplo no seguro.

	2. Modifico el jdbc a la ip del host donde corre la base, esto lo hard codeamos por ip porque no tenemos dado de alta una entrada de dns
	   para la base.

```
docker run --rm -d -p 8080:8080 journal:4.0-SNAPSHOT
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a5-docker/images/java-docker-run-mysql-change.png "java-docker-run-mysql.png")
