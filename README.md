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

## Configuración de Jenkins.
La configuración de Jenkins la podemos dividir en al menos 2 archivos, en uno de ellos se hará un listado de los plugins que deben de instarlarse en la imagen y en otro es la configuración de Jenkins para funcionar. 
### Plugins
Deberemos de realizar una instalación de plugins según la plataforma y funcionalidades que vayamos a definir. La configuración mínnima necesitaremos plugin para trabajar con: SCM (git), DSL(scripts para definir pipelines), seguridad (si fuera necesario externalizar el repositorio de información)
### Usuarios y permisos
En este aspecto al menos deberemos definir un subconjunto mínimo de usuario genéricos, usando el mecanismo interno de almacenamiento de identidades de Jenkins. Para ello al menos deberiamos definir los siguientes:
- un usuadio **administrador**
- un usuario **ejecutor** genérico para todos los jobs que intentaremos preconfigurar,
- un usuario **lector** que nos servirá para conocer los builds ya realizados,
- un usuario **tokenizado** que nos asociará un token a un usuario **ejecutor** que nos ayudará para la ejecución remota del job/s definidos
#### Usuario administrador
Definir un usuario administrador
#### Usuarios ejecutores, para ejecución remota
Definir un usuario ejecutor con capacidad de ejecución del proyecto y otro con capacidad de ejecución remota
#### Usuarios lectores
Definir un usuario lector para poder recuperar via API las ejecuciones de los jobs 
### Nodos
Definiremos al menos 3 tipos de nodos para que se repartan las acciones, 
- intentaremos definir uno de ellos con capacidad para levantar contenedores y otro
- con capacidad para levantar pods, ya sean de forma:
  - directa con comandos kubectl y archivos yml, ya sean definidos localmente o remotamente desde un SCM
  - indirecta a partir de archivos de HELM, ya sean definidos localmente o remotamente desde un SCM
### Jobs predefinidos, 
Definiremos un job con las siguientes características de poder ser invocados, indepndientemente si son definidos en Jenkins como en un repositorio remoto
#### como un DSL definido
Un job de tipo DSL y llamada remota completamente definido en el archivo de configuración.
#### Desde un repositorio. JenkinsFile
Un job de tipo SCM de forma que descarge de un repositorio remoto un jenkinsfile que ejecute un pipeline. 
#### Invocación remota.
Ambos tipos, definidos anteriormente se puedan invocar remotamente. 
### Mecanismo de invocación remota.
