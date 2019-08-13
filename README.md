# Week 01 - Assigments 9 - PROD

GitOps

	9.0	Se debe realizar la configuración de un Manifest en GitHub
	9.1	La modificación del Manifest, sólo deberá afectar el ambiente elegido [tiene que haber, al menos, dos ambientes distintos (staging/prod)]
	9.2	Debe ejecutarse automáticamente, tras únicamente, la modificación del Manifest y SOLO del ambiente elegido

## Pasos

El trabajo fue realizado en el branch w1a9-gitops-final y deje los branch w1a9-gitops-stage y w1a9-gitops-prod para ejemplificar un modelo donde
podamos ver el deploy utilizando el condicional when por branch. Aclaro que estos dos ultimos branch no son los pedidos en el punto por el bootcamp leader.

Como la premisa era utilizar un solo branch con un solo manifest en donde en un mismo manifest tengamos la configuracion de los dos ambientes, 
tenemos como ejemplo un manifest de este tipo. Donde tenemos los datos de la conexion de los dos ambientes, tanto stage como prod.


```
{
  "stage": {
    "version": {
      "major": 4,
      "minor": 2
    },
    "docker_repo": "gonzaloacosta/journal",
    "app_name": "journals",
    "app": {
      "ip": "10.252.7.178",
      "port": "8081",
      "healthcheck_url": "http://10.252.7.178:8081",
      "name": "journal_staging",
      "artifacts": [
        {
          "app": "journals-4.2.jar"
        }
      ]
    },
    "db": {
      "ip": "10.252.7.178",
      "port": "3306"
    }
  },
  "prod": {
    "version": {
      "major": 4,
      "minor": 1
    },
    "docker_repo": "gonzaloacosta/journal",
    "app_name": "journals",
    "app": {
      "ip": "10.252.7.178",
      "port": "8080",
      "healthcheck_url": "http://10.252.7.178:8080",
      "name": "journal_latest",
      "artifacts": [
        {
          "app": "journals-4.1.jar"
        }
      ]
    },
    "db": {
      "ip": "10.252.7.178",
      "port": "3306"
    }
  }
}
```


	branch -> w1a9-gitops-fina -> manifest.json
		- Prod: app_name: journal_prod y app expuesta en el port 8080
		- Stage: app_name: journal_staging y app expuesta en el port 8081

En la imagen se puede ver que un solo branch hace dos deploy y el condicional para que deploye es que.

	1. En Staging la version a desplegar sea distinta a la que está desplegada.
	2. En Production la version a desplegar debe ser si o si menor o igual a staging.
 
![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-final/images/gitops-final1.png "gitops-final1.png")

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a9-gitops-final/images/gitops-final2.png "gitops-final2.png")

```
[root@sre-bootcamp-ga-20190805 ~]# docker ps -a
CONTAINER ID        IMAGE                       COMMAND                  CREATED              STATUS              PORTS                    NAMES
b560bad26e19        gonzaloacosta/journal:4.1   "java -jar /opt/jo..."   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   journal_latest
0f205678f450        gonzaloacosta/journal:4.2   "java -jar /opt/jo..."   About a minute ago   Up About a minute   0.0.0.0:8081->8080/tcp   journal_staging
[root@sre-bootcamp-ga-20190805 ~]# 
```

## Observaciones

### Temas en los que debo profundizar.

	1. Código!. El código no es bueno y es feo. Profundizar el desarrollo con leguaje de uso general como java.
	2. Pipelines!. Reforzar el desarrollo de código en groovy.
	3. Terraform!. Profundizar y ejercitar desarrollo de script de terraform con providers como aws, vmware, azure. (+1 localstack)
	4. GitOps. Debo reforzar conceptos de GitFlow, son nuevos y no los tengo claro por lo que el codigo en groovy es muy pobre.

# Salud FIN!
![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1ar9-gitops-final/images/Guinness.jpg "Guinness.jpg")

