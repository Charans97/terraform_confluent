terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.61.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = "TADHHN6PDJA3WTD3"
  cloud_api_secret = "EUUCz+aO2nEO2uBEwZYofTWyeYHMT9K3Zia9zXi3XCNM1iasG1+yHwTSdqii1HzM"
}

resource "confluent_environment" "development" {
  display_name = "Development"

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_kafka_cluster" "basic" {
  display_name = "basic_kafka_cluster"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "us-east-2"
  basic {}

  environment {
    id = confluent_environment.development.id
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_service_account" "app-manager" {
  display_name = "app-manager"
  description  = "Service account to manage Kafka cluster"
}
