# Variablen definieren
$VMName = "DC01WW"
$ComputerName = "DC01WW"
$RAM = 4096GB
$StoragePath = "D:\VM\DC01WW"
$VHDPath = "D:\VM\DC01WW\Virtual Harddisk\DC01WWHDD000.vhdx"
$VHDXSize = 60GB
$NetworkSwitch1 = "Extern"
$NetworkSwitch2 = "Privat"
$VHD2Path = "D:\VM\DC01WW\Virtual Harddisk\DC01WWHDD001.vhdx"
$IsoPath = "D:\Daten\Isos\Server 2022\WIN_SERVER_2022_EVAL_x64FRE_de-de.iso"

# VM erstellen
New-VM -Name $VMName -ComputerName $ComputerName -MemoryStartupBytes $RAM -MaxMemoryStartupBytes $RAM -Path $StoragePath -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDXSize

# VM-Einstellungen festlegen
Set-VM -Name $VMName -AutomaticStartAction Nothing -AutomaticStopAction TurnOff

# Netzwerkeinstellungen festlegen
Add-VMNetworkAdapter -VMName $VMName -SwitchName $NetworkSwitch1
Add-VMNetworkAdapter -VMName $VMName -SwitchName $NetworkSwitch2

# VHD hinzufügen
Add-VMDisk -VMName $VMName -Path $VHD2Path -SizeBytes $VHDXSize

# Integration Services deaktivieren
Set-VMIntegrationService -VMName $VMName -Name "VSS" -Enabled $false
Set-VMIntegrationService -VMName $VMName -Name "Gastdienste" -Enabled $true

# Checkpoints deaktivieren
Set-VM -Name $VMName -CheckpointType Disabled

# ISO-Datei einlegen
Set-VMDvdDrive -VMName $VMName -Path $IsoPath