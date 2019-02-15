echo "provisioning infrastructure..."
terraform apply --auto-approve

echo "building inventory file..."
python3 inventory.py

echo "copying files..."
scp -i $TF_VAR_ssh_private_key -r ./ansible ubuntu@$ubuntu_ip:/home/ubuntu/