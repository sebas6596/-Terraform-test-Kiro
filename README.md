# AWS Infrastructure con Terraform

Este repositorio contiene código de Terraform para implementar una arquitectura AWS con alta disponibilidad que incluye:

- VPC con subnets públicas y privadas en dos zonas de disponibilidad (us-east-1a y us-east-1b)
- Application Load Balancer (ALB) público
- Servidores EC2 en subnets privadas
- Security Groups configurados
- Internet Gateway para acceso público

## Arquitectura

```
VPC (10.0.0.0/16)
├── Availability Zone 1a
│   ├── Public Subnet (10.0.1.0/24)
│   └── Private Subnet (10.0.11.0/24)
│       └── EC2 Instance (Server-web-1a)
├── Availability Zone 1b
│   ├── Public Subnet (10.0.2.0/24)
│   └── Private Subnet (10.0.12.0/24)
│       └── EC2 Instance (Server-web-1b)
└── Application Load Balancer (en subnets públicas)
```

## Estructura del Proyecto

```
.
├── provider.tf              # Configuración de Terraform y provider AWS
├── vpc.tf                   # VPC e Internet Gateway
├── subnets.tf              # Subnets públicas y privadas
├── route_tables.tf         # Tablas de rutas y asociaciones
├── security_groups.tf      # Security Groups para ALB y EC2
├── alb.tf                  # Application Load Balancer y Target Group
├── ec2.tf                  # Instancias EC2
├── variables.tf            # Variables de entrada
├── outputs.tf              # Outputs de la infraestructura
├── terraform.tfvars.example # Ejemplo de variables
├── .gitignore              # Archivos ignorados por Git
└── README.md               # Esta documentación
```

## Requisitos Previos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Cuenta de AWS con credenciales configuradas
- Permisos IAM adecuados para crear recursos

## Variables de Entorno Requeridas

Para Terraform Cloud, configura las siguientes variables de entorno:

### Variables de Entorno (Environment Variables)
- `AWS_ACCESS_KEY_ID` - Tu AWS Access Key ID
- `AWS_SECRET_ACCESS_KEY` - Tu AWS Secret Access Key (marca como sensible)
- `AWS_DEFAULT_REGION` - Región de AWS (ej: us-east-1)

### Variables de Terraform (Terraform Variables)
Puedes configurar estas variables en Terraform Cloud o usar un archivo `terraform.tfvars`:

- `aws_region` - Región de AWS (default: us-east-1)
- `project_name` - Nombre del proyecto (default: aws-infrastructure)
- `vpc_cidr` - CIDR de la VPC (default: 10.0.0.0/16)
- `instance_type` - Tipo de instancia EC2 (default: t2.micro)
- `ami_id` - AMI ID para las instancias EC2

## Configuración para Terraform Cloud

1. Crea una organización y workspace en [Terraform Cloud](https://app.terraform.io/)

2. Configura las variables de entorno en tu workspace:
   - Ve a tu workspace → Variables
   - Agrega las siguientes Environment Variables:
     - `AWS_ACCESS_KEY_ID`
     - `AWS_SECRET_ACCESS_KEY` (marca como sensitive)
     - `AWS_DEFAULT_REGION`

3. Agrega el backend de Terraform Cloud al archivo `main.tf`:

```hcl
terraform {
  cloud {
    organization = "tu-organizacion"
    
    workspaces {
      name = "aws-infrastructure"
    }
  }
}
```

## Uso Local

1. Clona este repositorio:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Copia el archivo de ejemplo de variables:
```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Edita `terraform.tfvars` con tus valores

4. Configura tus credenciales de AWS:
```bash
export AWS_ACCESS_KEY_ID="tu-access-key"
export AWS_SECRET_ACCESS_KEY="tu-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

5. Inicializa Terraform:
```bash
terraform init
```

6. Revisa el plan de ejecución:
```bash
terraform plan
```

7. Aplica la configuración:
```bash
terraform apply
```

8. Para destruir la infraestructura:
```bash
terraform destroy
```

## Outputs

Después de aplicar la configuración, obtendrás:

- `vpc_id` - ID de la VPC creada
- `alb_dns_name` - DNS del Application Load Balancer
- `alb_url` - URL completa para acceder al ALB
- IDs de subnets y instancias EC2

## Acceso a la Aplicación

Una vez desplegada la infraestructura, puedes acceder a tu aplicación usando la URL del ALB:

```bash
terraform output alb_url
```

## Notas Importantes

- Las instancias EC2 están en subnets privadas y solo son accesibles a través del ALB
- El AMI ID por defecto es para Amazon Linux 2 en us-east-1. Actualízalo según tu región
- Los servidores web se configuran automáticamente con Apache mediante user_data
- Asegúrate de revisar los costos de AWS antes de desplegar

## Seguridad

- Nunca subas archivos `terraform.tfvars` con credenciales al repositorio
- Usa Terraform Cloud o AWS Secrets Manager para gestionar credenciales
- Revisa los Security Groups antes de desplegar en producción
- Considera agregar NAT Gateways para que las instancias privadas tengan acceso a internet

## Licencia

MIT
