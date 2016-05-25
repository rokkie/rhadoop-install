# Install RHadoop

Automated script to install RHadoop on Hortonworks Sandbox.
Tested with version 2.1 found at:
(http://hortonworks.com/downloads/#sandbox)

## Instructions
1. Download Hortonworks VM 2.1
2. Import the image
3. Mount/share a folder from the host machine
4. Copy install files to the shared folder
5. Boot VM
6. Login into VM as root via SSH
7. Copy files from shared folder to home directory
8. Run: `./install-rhadoop.sh`
9. Shutdown VM
10. Forward port 8787
    `vboxmanage modifyvm "Hortonworks Sandbox 2.1" --natpf1 tcp8787,tcp,127.0.0.1,8787,,8787`
11. Start VM

Please note that in step 10, the name of your VM may differ.
To get a list of all the VM's run:
`vboxmanage list vms`

