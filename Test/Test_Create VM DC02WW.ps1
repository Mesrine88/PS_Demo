#######################################################
#################### Wilhelm Woitke ###################
################### DC02WW erstellen ##################
#################### c 2023 @ me    ###################
#######################################################



# Variablen definieren
$VMName = "DC02WW"
$ComputerName = "DC02WW"
$RAM = 4GB
$StoragePath = "C:\HyperV\DC02WW"
$VHDPath = "C:\HyperV\DC02WW\Virtual Harddisk\DC02WWHDD000.vhdx"
$VHDXSize = 60GB
$VHDX2Size = 20GB
$NetworkSwitch = "Privat"
$VHD2Path = "C:\HyperV\DC02WW\Virtual Harddisk\DC02WWHDD001.vhdx"
$VHD3Path = "C:\HyperV\DC02WW\Virtual Harddisk\DC02WWHDD002.vhdx"
$VHD4Path = "C:\HyperV\DC02WW\Virtual Harddisk\DC02WWHDD003.vhdx"
$IsoPath = "C:\HyperV\WIN_SERVER_2022_EVAL_x64FRE_de-de.iso"

# VM erstellen
New-VM -Name $VMName -Generation 2 -MemoryStartupBytes $RAM -Path $StoragePath -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDXSize -SwitchName $NetworkSwitch
Set-VM -Name $VMName -DynamicMemory -MemoryMaximumBytes 4GB -ProcessorCount 4

# VM-Einstellungen festlegen
Set-VM -Name $VMName -AutomaticStartAction Nothing -AutomaticStopAction TurnOff

# VHD hinzufügen
Add-VMHardDiskDrive -VMName $VMName -DiskNumber 2 
New-VHD -Path $VHD2Path -SizeBytes $VHDX2Size -Dynamic
Mount-VHD -Path $VHD2Path

#Add-VMHardDiskDrive -VMName $VMName -DiskNumber 3
New-VHD -Path $VHD3Path -SizeBytes $VHDX2Size -Dynamic
Mount-VHD -Path $VHD3Path
#Add-VMHardDiskDrive -VMName $VMName -DiskNumber 4
#New-VHD -Path $VHD4Path -SizeBytes $VHDX2Size -Dynamic

# Integration Services deaktivieren
Disable-VMIntegrationService -VMName $VMName -Name "VSS"
Enable-VMIntegrationService -VMName $VMName -Name "Gastdienstschnittstelle"

# Checkpoints deaktivieren
Set-VM -Name $VMName -CheckpointType Disabled

# ISO-Datei einlegen
Add-VMDvdDrive -VMName $VMName -Path $IsoPath




