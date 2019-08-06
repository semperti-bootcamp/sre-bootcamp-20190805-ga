# Week 01 - Assignments 3
Correr aplicacion Java

	1. Configurar la conexión de la base de datos desde Code/src/main/resources/application.properties
	2. Ubicate en la carpeta del código y ejecutá "mvn spring-boot:run".
	3. Revisá la siguiente dirección http://localhost:8080
	4. [Opcional] Por defecto, la aplicación almacena los PDFs en el directorio <User_home>/upload. Si querés cambiar este directorio, podés utilizar la propiedad -Dupload-dir=<path>.
	5. [Opcional] Los PDFs predefinidos pueden encontrarse en la carpeta PDF. Si querés ver los PDFs, tenés que copiar los contenidos de esta carpeta a lo definido en el paso anterior.

## Pasos

### 1. Conectarse a CentOS 

 Ip: 10.252.7.178

```
ssh root@10.252.7.178
```

### 2. Clono repo, testeo y creo .jar 

```
git clone https://github.com/semperti-bootcamp/week01
sed -i -e 's/spring.datasource.password=/&semperti/g' application.properties
cd Code
mvn spring-boot:run
mvn clean package
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a3-java/images/java-test.png "java-test")

### 4. Java Run Web

Correr los siguientes comandos.

```
mkdir ~/upload
cp -pvr /root/week1/PDFs/* /root/upload/
java -jar target/journal-1.0.jar
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload
curl http://localhost:8080
```
Pruebo desde mi notebook

```
$ curl http://10.252.7.178:8080
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Semperti - Journal System</title>
    <script src="js/angular-min.js"></script>
    <script src="js/app.js"></script>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body ng-app="JournalApp" ng-controller="CategoryController">
<h2>Bienvenido al sistema de jornales de Semperti</h2>




<div ng-controller="getCategories">
    <table>
        <thead>
        <td>Categoría</td>
        <td>Subscribirse</td>
        </thead>
        <tbody>

        <tr ng-repeat="category in categories">
            <td>{{category.name}}</td>
            <td>
                <a href="/login">Login</a>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a3-java/images/java-run-web.png "java-web")

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a3-java/images/java-run-web-pdf.png "java-web-pdf")

