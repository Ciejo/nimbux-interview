output "url" {
  value = "http://${aws_alb.alb.dns_name}/"
}