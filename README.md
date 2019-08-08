# Week 01 - Assigments 8 

Crear Pipeline de CD

	8.0	Debe encontrarse dentro de un folder con el nombre bc-username
	8.1	Debe ejecutarse el build cada vez que se realice un PR
	8.2	Debe contener al menos las etapas de descarga de imagen, ejecución de contenedor y prueba de acceso a la aplicación mediante un curl y su output

## Pasos

Para promover una nueva version debemos modificar la versión desde el Jenkisfiles en el apartado environment.

```
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
        VERSION = "4.0.10"
    }
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a8-jenkins-cd/images/jenkins-cd1.png "jenkins-cd1.png")

La imagen del container creada con el pipeline para la version 4.0.3.

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a8-jenkins-cd/images/jenkins-cd2.png "jenkins-cd2.png")

Chequeamos que quede corriendo, en el log de jenkins esta el curl.

```
[devops@sre-bootcamp-ga-20190805 ansible]$ sudo docker images | grep 4.0.10
gonzaloacosta/journal   4.0.10              c9860d2486b4        About a minute ago   156 MB
journal                 4.0.10              c9860d2486b4        About a minute ago   156 MB
[devops@sre-bootcamp-ga-20190805 ansible]$ sudo docker ps -a
CONTAINER ID        IMAGE                          COMMAND                  CREATED              STATUS              PORTS                    NAMES
afc9d9ff0fae        gonzaloacosta/journal:latest   "java -jar /opt/jo..."   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   journal_latest
[devops@sre-bootcamp-ga-20190805 ansible]$
```
