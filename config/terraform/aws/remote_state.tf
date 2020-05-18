data "terraform_remote_state" "backend" {
  backend = "s3"

  config = {
    bucket = "covidshield-terraform"
    key    = "aws/backend/default.tfstate"
    region = "ca-central-1"
  }
}
