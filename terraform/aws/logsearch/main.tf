resource "aws_elasticsearch_domain" "example" {
  domain_name           = "example"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type = "t2.small.elasticsearch"
    dedicated_master_enabled = false
    instance_count = 1
    ebs_options {
      ebs_enabled = true
      volume_size = 10
    }
  }

  tags = {
    Domain = "TestDomain"
  }
}

