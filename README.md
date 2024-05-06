# BUILDER
Este repositorio contiene los archivos y mecanismos necesarios para desplegar un jenkins as a service. 
Se debe de suministrir en tiempo de construcción:
- el archivo que contiene el listado:version de los plugins a instalar en el JAAS
- el archivo que contiene la configuración como código de Jenkins,
Esta por definir como se subirá la configuración como código del job que ha de publicarse su endpoint para ser llamado remotamente. 
El proceso de usar este HELM se descompone en 2 pasos:
- el primer paso es construir la imagen con el comando(en local): 
  docker build -t jaasc . 
- el segundo paso es desplegar el chart de helm con los comandos de HELM. Se deben de definir varias cuestiones:
  - primer lugar el como se almacena los valores de los password y token que se ha de definir. Podemos hacerlo desde objetos Secrets de Kubernetes o desde sistemas como vault,
  - para posteriormente en tiempo de ejecución sustituir esta información a través de un mecanismo de script.