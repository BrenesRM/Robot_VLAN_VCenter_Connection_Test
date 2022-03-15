$VLANS = Import-Csv -Path "E:\Scripts\VLANS.csv" -Delimiter ";"

foreach($mVlan in $VLANS){
    Set-NetAdapterAdvancedProperty Ethernet0 -DisplayName "VLAN ID" -DisplayValue $mVlan.VLAN
    Get-NetAdapter Ethernet0 | Remove-NetIPAddress -AddressFamily IPv4 -Confirm:$false
    Get-NetAdapter Ethernet0 | Remove-NetRoute -AddressFamily IPv4 -Confirm:$false
    Get-NetAdapter Ethernet0 | New-NetIPAddress -AddressFamily IPv4 -IPAddress $mVlan.IP -PrefixLength $mVlan.Prefix -DefaultGateway $mVlan.Gateway

    sleep -Seconds 5

    $Gateway = $mVlan.Gateway
    $VLANindex = $mVlan.VLAN

    Invoke-Pester -Script @{ Path = "E:\Scripts\Ping.test.ps1"; Parameters = @{Gateway = $Gateway; VLAN = $mVlan.VLAN}} -OutputFile "e:\scripts\Result_Test_$VLANindex.xml" -OutputFormat LegacyNUnitXml

}

###Doc the process

# You need a New machine.
# Start the process of the script.
# Send the XML result to analizer logs for the indexation and monitoring.