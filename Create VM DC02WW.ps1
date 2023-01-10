# Variablen definieren
$VMName = "DC02WW"
$ComputerName = "DC02WW"
$RAM = 4096GB
$StoragePath = "D:\VM\DC02WW"
$VHDPath = "D:\VM\DC02WW\Virtual Harddisk\DC02WWHDD000.vhdx"
$VHDXSize = 60GB
$VHDX2Size = 20GB
$NetworkSwitch = "Privat"
$VHD2Path = "D:\VM\DC02WW\Virtual Harddisk\DC02WWHDD001.vhdx"
$VHD3Path = "D:\VM\DC02WW\Virtual Harddisk\DC02WWHDD002.vhdx"
$VHD4Path = "D:\VM\DC02WW\Virtual Harddisk\DC02WWHDD003.vhdx"
$IsoPath = "D:\Daten\Isos\Server 2022\WIN_SERVER_2022_EVAL_x64FRE_de-de.iso"

# VM erstellen
New-VM -Name $VMName -ComputerName $ComputerName -MemoryStartupBytes $RAM -MaxMemoryStartupBytes $RAM -Path $StoragePath -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDXSize -dynamic -SwitchName $NetworkSwitch

# VM-Einstellungen festlegen
Set-VM -Name $VMName -AutomaticStartAction Nothing -AutomaticStopAction TurnOff

# VHD hinzufügen
Add-VMDisk -VMName $VMName -Path $VHD2Path -SizeBytes $VHDX2Size -dynamic
Add-VMDisk -VMName $VMName -Path $VHD3Path -SizeBytes $VHDX2Size -dynamic
Add-VMDisk -VMName $VMName -Path $VHD4Path -SizeBytes $VHDX2Size -dynamic

# Integration Services deaktivieren
Set-VMIntegrationService -VMName $VMName -Name "VSS" -Enabled $false
Set-VMIntegrationService -VMName $VMName -Name "Gastdienste" -Enabled $true

# Checkpoints deaktivieren
Set-VM -Name $VMName -CheckpointType Disabled

# ISO-Datei einlegen
Set-VMDvdDrive -VMName $VMName -Path $IsoPath