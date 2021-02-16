#!/bin/bash
#cfp-dp-dsm.sh <DSMVersion> <DSMBuild> <masteradminPasswd> <AC> <dbName> <dbUser> <dbPasswd>

#Build Parameters
DSM_Version=$1 #20.0
DSM_Build=$2 #123
masterpass=$3
AC=$4
db=$5
user=$6
dbPass=$7
localIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

#Start DSM installation
cd /root/dsm/
yum install -y wget
wget --no-check-certificate https://files.trendmicro.com/products/deepsecurity/en/$DSM_Version/Manager-Linux-$DSM_Version.$DSM_Build.x64.sh
echo "AddressAndPortsScreen.ManagerAddress=$localIP
AddressAndPortsScreen.NewNode=True
UpgradeVerificationScreen.Overwrite=False
LicenseScreen.License.-1=$AC
DatabaseScreen.DatabaseType=PostgreSQL
DatabaseScreen.Hostname=$localIP
DatabaseScreen.Transport=TCP
DatabaseScreen.DatabaseName=$db
DatabaseScreen.Username=$user
DatabaseScreen.Password=$dbPass
AddressAndPortsScreen.ManagerPort=443
AddressAndPortsScreen.HeartbeatPort=4120
CredentialsScreen.Administrator.Username=masteradmin
CredentialsScreen.Administrator.Password=$masterpass
CredentialsScreen.UseStrongPasswords=False
SecurityUpdateScreen.UpdateComponents=True
SecurityUpdateScreen.Proxy=False
SecurityUpdateScreen.ProxyAuthentication=False
SoftwareUpdateScreen.UpdateSoftware=True
SoftwareUpdateScreen.Proxy=False
SoftwareUpdateScreen.ProxyAuthentication=False
SoftwareUpdateScreen.ProxyAuthentication=False
RelayScreen.Install=True
SmartProtectionNetworkScreen.EnableFeedback=False" >> install.properties
sleep 120
chmod 755 /root/dsm/Manager-Linux-$DSM_Version.$DSM_Build.x64.sh     
/root/dsm/Manager-Linux-$DSM_Version.$DSM_Build.x64.sh -q -varfile install.properties >> install.log
systemctl stop dsm_s
sleep 5
/opt/dsm/dsm_c -action changesetting -name settings.configuration.webserviceAPIEnabled -value true
/opt/dsm/dsm_c -action changesetting -name settings.configuration.statusMonitoringAPIEnabled -value true
/opt/dsm/dsm_c -action changesetting -name settings.configuration.agentInitiatedActivation -value 1
/opt/dsm/dsm_c -action changesetting -name settings.configuration.agentInitiatedActivationHostname -value true
/opt/dsm/dsm_c -action changesetting -name settings.configuration.agentInitiatedActivationActiveHost -value 2
/opt/dsm/dsm_c -action changesetting -name settings.configuration.allowReactivateClonedVM -value true
/opt/dsm/dsm_c -action changesetting -name settings.configuration.allowReactivateUnknownVM -value true
sleep 5
systemctl start dsm_s
systemctl status dsm_s >> install.log
echo "EOF" >> install.log 