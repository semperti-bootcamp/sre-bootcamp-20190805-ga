# Week 01 - Assignments 2
Configurar VM con Ansible

##  Detalle

	2.0 Deben configurarse todos los elementos solicitados [Java 8, Maven, MySQL, etc.]
	2.1 Deben proveerse screenshots validando los paquetes instalados
	2.2 Deben proveerse los scripts de configuración
	2.3 Deben describirse todos los pasos y requerimientos para ejecutar el script de Ansible

## Pasos

### 1. Configurar ansible

	1. Instalar ansible core en notebook
	2. Creo usuario sin privilegios de conexion
		- User: devops
		- Pass: la empresa
	3. Copiar ssh-key con ssh-copy-id  devops@sre-bootcamp-ga-20190805 (agregado en /etc/hosts)
	4. Configurar ansible.cfg e inventory. 
	5. Test con ansible app -m ping

```
$ ansible app -m ping
sre-bootcamp-ga-20190805 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```
	
### 2. Instalacion de los pre requsitos

Se crearon tres roles por cada componente a instalar. Cada rol tiene variables por default
que son seteadas en el archivo ./ansible/role/{{ nombre_rol }}/defaults/main.yml

	- role: install_java -> 1.8.0
	- role: install_maven -> 3.6.1
	- role: install_mysql -> 5.6

### 3. Pasos para ejecutar el playbook.

```
cd ./ansible/
ansible-playbook install_app_pre_req.yml
```
### 4. Output playbook
![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a2-ansible/images/ansible-roles.png "ansible-roles")

### 5. Check playbook 
![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a2-ansible/images/ansible-check.png "ansible-check")

### 6. Check conexion desde vpn
![alt tag](https://raw.githubusercontent.com/semperti-bootcamp/sre-bootcamp-ga-20190805/w1a2-ansible/images/ansible-vpn-check.png "ansible-vpn-check")
