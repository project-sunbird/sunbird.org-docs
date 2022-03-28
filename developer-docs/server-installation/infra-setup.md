#### Automation on Azure infrastructure creation

You can run the following steps to create azure infrastructure using ansible.

Easiest way to use the script will be to use azure cloud shell, as the cloud shell comes with all prerequisites bundled.
- login to portal.azure.com
- click on the cloudshell -> select bash ( if you're using it for the first time )

If you want to run this on your local machine, Follow this [guide](https://docs.microsoft.com/en-us/azure/developer/ansible/install-on-linux-vm?tabs=azure-cli#install-ansible-on-the-virtual-machine).


#### Create service principal for kubernetes cluster

Command to create SP:
```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your_subscription_id>" --name <NameOfSP>

# Replace the <> with your values
```

Note down the output of above command as we will need those to fill-up some variables in the ansible playbook

#### Create Maxmind licence key
```bash
1. Signup at maxmind.com if you don't have an account
2. Goto https://www.maxmind.com/en/accounts/current/license-key
3. Click Generate a new license key.
```

#### Clone the repo and go to deploy directory

```bash
git clone https://github.com/project-sunbird/sunbird-devops -b release-4.7.0

cd sunbird-devops/deploy
```

####  Update variables in azure-provision.yaml file

```bash
version: "ChangeThis"  # sunbird version Ex: 4.7.0
sp_client_id: "ChangeThis"  # substitute the value of `appId` from the output of the create SP command
sp_client_secret: "ChangeThis"  # substitute the value of `password` from the output of the create SP command
ssh_public_key_file_location: "ChangeThis"  # path to your ssh public key Ex: /home/sunbird/.ssh/my_pub.key
geoip_licence_key: "ChangeThis"  # substitute the one that you generated at # Create Maxmind licence key step
```

#### Run the playbook
```bash
ansible-playbook -c local azure-provision.yaml

# Resulting infrastructure information will be stored in sunbird-devops/deploy/azure-resources.txt file.
```

Running the playbook creates these azure resources

* Resource group
* VNET and subnet
* 6 VMs (size: Standard_D4s_v4)
* Public IP for Jenkins
* AKS cluster with 4 nodes (size: Standard_D4s_v4)
* Storage account
* ACR  ( Image registry)

and performs some steps needed for the sunbird installation like uploading maxmind database to blob storage etc. Please refer to the task section of the playbook to get the complete list
