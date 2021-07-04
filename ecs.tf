resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family = "task-definition"
  container_definitions = jsonencode([
    {
      "name": "my-first-task",
      "image": aws_ecr_repository.ecr_repo.repository_url
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc" 
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_ecs_service" "ecs_service" {
  name                  = format("%s-service", var.ecs_cluster_name)
  cluster               = aws_ecs_cluster.cluster.id
  task_definition       = aws_ecs_task_definition.task.arn
  launch_type           = "FARGATE"
  desired_count         = 3
  wait_for_steady_state = true
  depends_on = [
    aws_ecs_cluster.cluster,
    aws_ecs_task_definition.task
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name = aws_ecs_task_definition.task.family
    container_port = 3000
  }

  network_configuration {
    subnets = [
      aws_default_subnet.default_subnet_a.id, 
      aws_default_subnet.default_subnet_b.id, 
      aws_default_subnet.default_subnet_c.id
    ]
    assign_public_ip = true
  }
}

resource "aws_security_group" "service_sg" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
