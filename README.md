# Automated AD deployment

To run this tutorial, you need:
- an OCI account; the footprint should fit inside a trial environment if you're just testing out OCI
- an OCI user that has an API key set up

# To run the script:

## 1. Enter the following values into sample.env.vars
Gather the following information from OCI:
- Tenancy OCID
- User OCID
- Compartment OCID
- API Key Fingerprint
You will also need:
- Path to API private key
- Path to public key for ansible host
- Path to private key for ansible host

Run `source sample.env.vars` to apply the changes

## 2. Enter these values into ansible/group_vars/all
For Active Directory, there are a few pieces of information you need to provide:
 - Domain name: you should choose something in format "domain"."scope" (ex. demo.local)
 - Admin/Domain password: the password for your windows VMs.  Password must meet the following criteria:
  - at least 1 uppercase letter
  - at least 1 lowercase letter
  - at least 1 numeric character
  - at least 1 special character
  - length must be at least 12 characters

## 3. Run the terraform script
Open a terminal session inside this directory and run the following commands:
`terraform init`
`terraform plan`
`terraform apply --auto-approve`

## 4. To clean up the environment:
`terraform destroy --auto-approve`
  