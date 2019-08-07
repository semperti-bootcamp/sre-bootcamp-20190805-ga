# Week 01 - Assignments 7 

Crear Pipeline de CI

	7.0	Debe encontrarse dentro de un folder con el nombre bc-username
	7.1	Debe ejecutarse el build cada vez que se realice un PR
	7.2	Debe contener al menos, las etapas de configuración, unit testing, snapshot, release, upload a Nexus del artefacto de Maven y de la imagen de Docker
	7.3	Debe ejecutarse en un Jenkins slave propio

## Paso 1

Estan los archivos de configuración en el repo. No encontré la manera de configurar lo webhook Jenkins sin estar expuesto a internet, 
lo que probé hacer es configurar el parametro Pool SCM cada 5 min (*/5 * * * *)

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a7-jenkins/images/jenkins.png "jenkins.png")
