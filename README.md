# Week 01 - Assignments 4
Correr aplicacion Java

	1. Se debe cargar en Nexus un snapshot de la aplicación Java 
	2. Se debe cargar en Nexus un release de la aplicación Java 
	3. Se deben realizar mediante un script de Ansible 
	4. Se debe proveer todos los archivos necesarios para realizar estas tareas 

## Pasos

### 1. Preparo pom.xml configurando los repo de Nexus
 
Edito pom.xml y agregar "repository" y "snapshotReposity"
```
...
  <distributionManagement>  
      <repository>  
          <id>nexus-releases</id>  
          <name>Nexus Release Repository</name>  
          <url>http://10.252.7.162:8081/repository/maven-releases/</url>  
      </repository>  
      <snapshotRepository>  
          <id>nexus-snapshots</id>  
          <name>Nexus Snapshot Repository</name>  
         <url>http://10.252.7.162:8081/repository/maven-snapshots/</url>
      </snapshotRepository>  
  </distributionManagement> 
```		
y agrego dependecia

```
  <dependency>
	  <groupId>org.apache.maven.plugins</groupId>
	  <artifactId>maven-release-plugin</artifactId>
	  <version>2.5.3</version>
	  <type>maven-plugin</type>
  </dependency>
```

### 2. Creo snapshot de java y publico a Nexus tomo como ejemplo version 3.1

```
mvn versions:set -DnewVersion=3.1-SNAPSHOT
mvn clean deploy
ls ./target/journals-3.1-SNAPSHOT.jar
journals-3.1-SNAPSHOT.jar
grep SNAPSHOT pom.xml
    <version>3.1-SNAPSHOT</version> 
```
### 3. Creo nuevo release de java y publico a Nexus Ej, version 3.2
```
mvn versions:set -DnewVersion=3.2
mvn clean deploy
ls ./target/journals-3.2.jar
journals-3.2.jar
mvn versions:set -DnewVersion=3.2
mvn clean deploy
```

### 4. Hago nuevo deploy con script de ansible veriones 3.3 y 3.3 SNAPSHOT

Para nuevo release 3.3
```
ansible-playbook maven-deploy.yml -e "new_version=3.3"
```

Para nuevo SNAPSHOT 3.3 
```
ansible-playbook maven-deploy.yml -e "new_version=3.3 snapshot=True"
```

![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a4-nexus/images/java-deploy-nexus-ansible.png "java-deploy-nexus-ansible")

