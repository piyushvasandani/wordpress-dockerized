terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>3.0.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.56.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

# Configuring Docker as the provider
provider "docker" {}
resource "aws_vpc" "main" {
  cidr_block = "12.0.0.0/16"

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 1) // Takes 10.0.0.0/16 --> 10.0.1.0/24
  availability_zone       =  "ap-south-1a" // Use the first availability zone by default
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Security group for ECS cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "Allow HTTP traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating an ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name = "cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Creating an ECS task definition

resource "aws_ecs_task_definition" "task" {
  family                   = "example-task"  # Replace with your desired task definition name
        cpu    = "2048"
      memory   = "8192"
  container_definitions    = jsonencode([
    {
      name        = "example-container",
      image       = "piyushvasandani/wordpress",  # Replace with your desired Docker image
      cpu= 1024,
      memory= 4096,
      essential   = true,
      portMappings = [
        {
          containerPort = 80,
          protocol      = "tcp"
        }
      ]
       environment = [
        {
          name  = "MY_DB_HOST",
          value = "0.0.0.0"
        },
        {
          name  = "MY_DB_USER",
          value = "wp_user"
        },
        {
          name="MY_DB_PASSWORD",
          value="Testpassword@123"
        },
        {
          name="MY_DB_NAME"
          value="wp"
        }
      ]

    },
    {
      name        = "mysql-container",
      image       = "piyushvasandani/custom_mysql",  # Replace with your desired MySQL Docker image
      cpu         = 1024,
      memory      = 4096,
      essential   = true,
      portMappings = [
        {
          containerPort = 3306,
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "MYSQL_ROOT_PASSWORD",
          value = "Piyush@123"
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}
# Creating an ECS service
resource "aws_ecs_service" "service" {
  name             = "service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [aws_subnet.public_subnet.id]
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}