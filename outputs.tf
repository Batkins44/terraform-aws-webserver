# After 'terraform apply', this prints the public IP so you can visit your site
output "web_server_public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}
