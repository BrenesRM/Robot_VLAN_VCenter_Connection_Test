# Robot_VLAN_VCenter_Connection_Test

The test robot is a VM Machine with two powershell scripts:

The script number one set the VLAN, IP, Gateway of the network, from a csv.
The second script is a pester .ps1 who validate the connection throw a ping to the gateway, the result will be a xml file result.
Requirements:

A csv file with vlan number, gateway, IP for the network, a prefix (/24 for example).
A PortGroup type trunk, a network connection for the VM.
