# Week 01 - Assigments 9 - PROD

GitOps

	9.0	Se debe realizar la configuración de un Manifest en GitHub
	9.1	La modificación del Manifest, sólo deberá afectar el ambiente elegido [tiene que haber, al menos, dos ambientes distintos (staging/prod)]
	9.2	Debe ejecutarse automáticamente, tras únicamente, la modificación del Manifest y SOLO del ambiente elegido

## Pasos

Utilizare esta rama como la rama master del Assigment 9. Los archivos son los que definen debajo.

	master -> w1a9-gitops
		- minifest.json
		- Jenkinsfile

	staging -> w1a9-gitops-staging
		- manifest.json
		- staging-env.json
			- App Name: journal_staging (docker image name)
			- Port: 8081

	prod -> w1a9-gitops-prod
		- manifest.json
		- prod-env.json
			- App Name: journal_latest (docker image name)
			- Port: 8080

En la imagen se puede ver que el pipeline solamente corrio para el stage de Staging y no para Prod utilizando el manifest y los archivos de environment.

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-prod/images/gitops1.png "gitops1.png")

Como solamente contaba con un solo slave, lo que hice fué el deploy de los dos ambientes hacerlo en puertos separados pero con el mismo release de imagen de docker,
esto es para staging escucho en el puerto 8081 y para prod en el 8080

Programamos el poll desde este lugar cada 5 min o el intervalo que se desee.

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-prod/images/gitops2.png "gitops2.png")

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-prod/images/gitops3.png "gitops3.png")

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-prod/images/gitops4.png "gitops4.png")

## Observaciones

### Temas en los que debo profundizar.

	1. Código!. El código no es bueno y es feo. Debo profundizar el desarrollo con leguaje de uso general como java.
	2. Pipelines!. Reforzar el desarrollo de código en groovy.
	3. Terraform!. Profundizar y ejercitar desarrollo de script de terraform con providers como aws, vmware, azure. 
	4. Cerveza!. Si llegó hasta acá leyendo se ganó una pinta a cuenta mia, reclamar via mail a gonzalo.acosta@semperti.com. 

	   NOTA: No comparta el punto 4 con sus companeros, el premio es solo para aquellos que hayan leído hasta el final.

# Salud FIN!
![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-prod/images/Guinness.jpg "Guinness.jpg")

