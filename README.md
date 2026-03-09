# Infraestructura AWS con Terraform

Este repositorio contiene código de Terraform para desplegar una infraestructura de alta disponibilidad en AWS con Application Load Balancer y servidores web en múltiples Availability Zones.

## Arquitectura

La infraestructura incluye:

- **VPC** en la región us-east-1
- **2 Availability Zones** (us-east-1a y us-east-1b)
- **Subnets públicas** en cada AZ para el ALB
- **Subnets privadas** en cada AZ para los servidores web
- **Internet Gateway** para conectividad a Internet
- **Application Load Balancer** público que distribuye tráfico
- **2 instancias EC2** (una en cada AZ) ejecutando servidores web

## Requisitos Previos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Credenciales de AWS configuradas (AWS CLI o variables de entorno)
- Permisos IAM para crear recursos de VPC, EC2, y ELB

## Configuración de Credenciales AWS

Configura tus credenciales de AWS usando uno de estos métodos:

```bash
# Opción 1: AWS CLI
aws configure

# Opción 2: Variables de entorno
export AWS_ACCESS_KEY_ID="tu-access-key"
export AWS_SECRET_ACCESS_KEY="tu-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Uso

1. **Clonar el repositorio**

```bash
git clone <url-del-repositorio>
cd <nombre-del-repositorio>
```

2. **Configurar variables** (opcional)

```bash
cp terraform.tfvars.example terraform.tfvars
# Edita terraform.tfvars con tus valores personalizados
```

3. **Inicializar Terraform**

```bash
terraform init
```

4. **Revisar el plan de ejecución**

```bash
terraform plan
```

5. **Aplicar la configuración**

```bash
terraform apply
```

6. **Acceder a la aplicación**

Una vez completado el despliegue, Terraform mostrará la URL del ALB:

```bash
terraform output alb_url
```

Abre esa URL en tu navegador para ver los servidores web en funcionamiento.

## Estructura de Archivos

```
.
├── main.tf              # Configuración principal, VPC e Internet Gateway
├── variables.tf         # Definición de variables
├── subnets.tf          # Subnets y tablas de rutas
├── alb.tf              # Application Load Balancer y configuración
├── ec2.tf              # Instancias EC2 y security groups
├── outputs.tf          # Outputs de Terraform
├── terraform.tfvars.example  # Ejemplo de variables
└── README.md           # Este archivo
```

## Variables Principales

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `aws_region` | Región de AWS | `us-east-1` |
| `project_name` | Nombre del proyecto | `aws-infrastructure` |
| `vpc_cidr` | CIDR de la VPC | `10.0.0.0/16` |
| `availability_zones` | AZs a utilizar | `["us-east-1a", "us-east-1b"]` |
| `instance_type` | Tipo de instancia EC2 | `t3.micro` |

## Outputs

Después del despliegue, puedes consultar:

```bash
terraform output vpc_id                  # ID de la VPC
terraform output alb_dns_name           # DNS del ALB
terraform output alb_url                # URL completa del ALB
terraform output web_server_ids         # IDs de las instancias
terraform output web_server_private_ips # IPs privadas de las instancias
```

## Limpieza

Para destruir todos los recursos creados:

```bash
terraform destroy
```

## Costos Estimados

Los recursos principales que generan costos son:
- Application Load Balancer (~$16-20/mes)
- 2 instancias EC2 t3.micro (~$15/mes)
- Transferencia de datos

**Nota:** Los costos pueden variar según el uso y la región.

## Seguridad

- Las instancias EC2 están en subnets privadas sin acceso directo desde Internet
- El ALB solo acepta tráfico HTTP/HTTPS (puertos 80/443)
- Los servidores web solo aceptan tráfico del ALB
- Se recomienda agregar HTTPS con certificados SSL/TLS para producción

## Mejoras Futuras

- [ ] Agregar NAT Gateway para que las instancias privadas accedan a Internet
- [ ] Implementar Auto Scaling Group
- [ ] Configurar HTTPS con ACM (AWS Certificate Manager)
- [ ] Agregar CloudWatch para monitoreo
- [ ] Implementar backups automatizados
- [ ] Agregar WAF (Web Application Firewall)

## Licencia

MIT
