$VLANS = Import-Csv -Path "E:\Scripts\VLANS.csv" -Delimiter ";"
#$VLANS

foreach($mVlan in $VLANS){
    Set-NetAdapterAdvancedProperty Ethernet0 -DisplayName "VLAN ID" -DisplayValue $mVlan.VLAN
    Get-NetAdapter Ethernet0 | Remove-NetIPAddress -AddressFamily IPv4 -Confirm:$false
    Get-NetAdapter Ethernet0 | Remove-NetRoute -AddressFamily IPv4 -Confirm:$false
    Get-NetAdapter Ethernet0 | New-NetIPAddress -AddressFamily IPv4 -IPAddress $mVlan.IP -PrefixLength $mVlan.Prefix -DefaultGateway $mVlan.Gateway

    sleep -Seconds 5

    $Gateway = $mVlan.Gateway
    $VLANindex = $mVlan.VLAN


    Invoke-Pester -Script @{ Path = "E:\Scripts\Tests\Ping.test.ps1"; Parameters = @{Gateway = $Gateway; VLAN = $mVlan.VLAN}} -OutputFile "e:\scripts\tests\Result_Test_$VLANindex.xml" -OutputFormat LegacyNUnitXml


    
   #$mVlan

   #Invoke-Pester -Script @{ Path =  'C:\Test.ps1'; Parameters = @{ServerName = 'SRV1'; ServiceName = 'wuauserv'} }
}

###### Al final deberiamos quedar en la 2068 y mandar el resultado a splunk 

###Proceso para automatizar las pruebas

# VRA pone a maquina 
# VRO manda a modo mantenimiento EL host Objetivo
# VRO Apaga DRS y HA en el cluster 
# VRO inicia VMOTION hacia el host objetivo 
# Algo dispara Robot
# : Repita para cada host

# Verifique resultados en splunk 