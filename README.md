# CF-Park

Cloud Formation Template for Lab Deployment

# aws-cfp-build-DSM-PSQL10-singleinstance.yml
    This template deploys a single instance for DSM on RHEL8/7 with PostgreSQL 10.6
    Based from Clark's Template | https://github.com/postmanoy/Squad-Projects/tree/master/AWS%20Scripts/DSM-onprem-cloudsetup
    
    How to use: 
    1. Deploy CF template, access https://<Elastic IP assigned>:443
    2. For troubleshooting, you can check the logs at /root/dsm/ >> install.log & dbinstall.log
    
# Deep Security Agent
    The following templates deploys an EC2 instance with DSA installed
    
    aws-cfp-Linux-DSA.yml        -  AMZLinux, RHEL, CentOS, Ubuntu, SUSE, Kali
    aws-cfp-Windows-DSA.yml      -  Windows Server 2019, 2016, 2012R2, 2008R2, 2003

    Pre-req:
     You need to make sure that a DSA Package is imported in DSM
     You need to specify DSM host/ip address in the CF parameters
    
# For Cloud One - Workload Security Agent
    The following templates deploys an EC2 instance with DSA installed
    
    aws-cfp-Linux-C1WS.yml        -  AMZLinux, RHEL, CentOS, Ubuntu, SUSE, Kali
    aws-cfp-Windows-C1WS.yml      -  Windows Server 2019, 2016, 2012R2, 2008R2, 2003 
    
    Note: Need to specify TenantID and token in the CF parameters
    
     
    
