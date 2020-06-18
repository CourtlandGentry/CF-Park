# CF-Park

Cloud Formation Template for Lab Deployment

# aws-cfp-build-DSM-PSQL10-singleinstance.yml
    This template deploys a single instance for DSM on RHEL8/7 with PostgreSQL 10.6
    Based from Clark's Template | https://github.com/postmanoy/Squad-Projects/tree/master/AWS%20Scripts/DSM-onprem-cloudsetup
    
    How to use: 
    1. Deploy CF template, access https://<Elastic IP assigned>:443
    2. For troubleshooting, you can check the logs at /root/dsm/ >> install.log & dbinstall.log
    
# aws-cfp-LinuxDSA.yml
    This template deploys a Linux Server with DSA installed
    
    Pre-req:
    You need to make sure that a DSA Package is imported in DSM
    You need to specify DSM host/ip address in the CF Parameter
    
# aws-cfp-WindowsDSA.yml
    This template deploys a Windows Server with DSA installed
    
    Pre-req:
    You need to make sure that a DSA Package is imported in DSM
    You need to specify DSM host/ip address in the CF Parameter
    
