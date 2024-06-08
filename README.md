# Google Cloud Run with uptime monitoring

## Setup

To use this you will need:
- Terraform
- A GCP account

1. Login to gcloud
   ```bash
   gcloud auth application-default login 
   ```
2. Run plan changes
   ```bash
   terraform plan
   ```
3. Apply changes
   ```bash
   terraform apply
   ```
4. Destroy infrastructure
   ```bash
   terraform destroy
   ```

## Testing uptime monitoring

To test uptime monitoring you need to:

1. Update the email address listed in [uptime-check/main.tf](./uptime-check/main.tf#L67)
   ```diff
   +  email_address = "YOUR EMAIL"
   -  email_address = "canines_panacea_0u@icloud.com"
   ```
2. Break Cloud Run service by [changing ingress setting](./cloud-run/main.tf#L10)
    ```diff
   +  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"
   -  ingress  = "INGRESS_TRAFFIC_ALL"
   ```  
3. Apply changes
   ```bash
   terraform apply
   ```
4. Check your email
