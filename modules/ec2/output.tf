output "instance_id" {
  description = "ID of the created EC2 instance."
  value       = google_compute_instance.ec2_instance[*].instance_id

}
