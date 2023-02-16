# Campus-Infra
Infraestructura en Terraform para el Campus-JH

## La infraestructura consta de varios módulos:
- **IAM**: Maneja roles y permisos.
- **VPC**: Setea las subredes, tablas de rutas y reglas de entrada y salida.
- **EC2**: Configura el AMI y las llaves de acceso a la instancia declarada en main.tf.
- **RDS**: Genera un subnet group, security group y levanta la base de datos.

Estos son los módulos principales, luego hay archivos de suma importancia:
- **state.tf**: Almacena el backend y archivos del estado de la infraestructura de manera segura.
- **provider.tf**: Se configura el proveedor cloud (AWS en este caso) y la region.
- **main.tf**: Importa todos los modulos, despliega una instancia de ec2 y aprovisiona la maquina con algunos scripts.
_(Aprovisionamiento a la espera de una mejor solucion con Ansible, Chef, Puppet o similares)_
