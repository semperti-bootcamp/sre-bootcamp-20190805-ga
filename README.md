# Week 01 - Assigments 7 

Crear Pipeline de CI

	7.0	Debe encontrarse dentro de un folder con el nombre bc-username
	7.1	Debe ejecutarse el build cada vez que se realice un PR
	7.2	Debe contener al menos, las etapas de configuración, unit testing, snapshot, release, upload a Nexus del artefacto de Maven y de la imagen de Docker
	7.3	Debe ejecutarse en un Jenkins slave propio

## Paso 1

Estan los archivos de configuración en el repo. No encontré la manera de configurar lo webhook Jenkins sin estar expuesto a internet, 
lo que probé hacer es configurar el parametro Pool SCM cada 5 min (*/5 * * * *)

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a7-jenkins/images/jenkins.png "jenkins.png")

La imagen del container creada con el pipeline para la version 4.0.3.

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a7-jenkins/images/jenkins2.png "jenkins2.png")

Prueba de que luego del commit con la nueva version el pipeline realizo el pool correctamente y construyo la imagen.

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a7-jenkins/images/jenkins3.png "jenkins3.png")

```
[devops@sre-bootcamp-ga-20190805 ga-bc-pipeline]$ sudo docker images | grep 4.0
gonzaloacosta/journal             4.0.4               8ff37932fb45        2 minutes ago       156 MB
journal                           4.0.4               8ff37932fb45        2 minutes ago       156 MB
gonzaloacosta/journal             4.0.3               6b98cf410f66        12 minutes ago      156 MB
journal                           4.0.3               6b98cf410f66        12 minutes ago      156 MB 
```

## Pasos proximos

Queda mejorar el manejo de varariables y credenciales.
