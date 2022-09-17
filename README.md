# fly.io-alpine-vscode


Pasos:
1. Instalar Fly CLI
2. Iniciar sesión con el comando flyctl auth login
3. Abrir terminal, powershell y acceder a la carpeta de la plantilla
4. Editar el archivo Dockerfile y modificar en PASSWORD=12345 (12345) por otra contraseña.
5. Ejecutar "fly deploy" pero no iniciar el deploy para crear el archivo de configuración "fly.toml"
Cuanto nos aparezca "Would you like to deploy now? (y/N)" escribimos "n" y pulsamos enter.
6. Editar archivo "fly.toml" y  debajo de [env]  agregar las siguientes línea:

Asignar unidad persistente myapp_data a la ubicación /root
```
[mounts]
  destination = "/root"
  source = "myapp_data"
```

7. Crear una unidad persistente con el comando "fly volumes create myapp_data --region lhr --size 1"
Es importante tener en cuenta que en total solo podemos tener 3GB en total de unidades persistente
pero lo recomendable es tener solo 1GB para poder asignar 1GB a los 3 contenedors gratuitos.

8. Ejecutamos "fly launch" para desplegar el contenedor de nuesta APP.
Es importante tener en cuenta que todos sus proyectos deben de estar dentro de "/root" ya que ahí los datos no se borrarán.

Al terminar mostrará un mensaje así, eso quiere decir que se ha desplegado correctamente!

![alt text](https://i.ibb.co/ccwX81S/Screenshot-2.jpg)

9. Accede a su navegador con la URL o IP creada por fly.io.
10. A disfrutar de VSCODE!
![alt text](https://i.ibb.co/LZ9XDc5/Screenshot-8.jpg)

