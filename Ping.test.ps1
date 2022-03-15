param ($Gateway, $VLAN)
#$Gateway = "192.168.164.1"
Describe "Ping al gateway $Gateway" {

 Context "Ping for VLAN $VLAN" {


it  "Server ping" {

$Chek_connection = Test-NetConnection -ComputerName $Gateway
$Chek_connection.PingSucceeded | should be $true
}
}
}


