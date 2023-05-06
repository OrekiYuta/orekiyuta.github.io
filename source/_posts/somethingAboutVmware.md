---
title: Something About VMware
date: 2022-01-01 22:35:16
tags: VMware
---
## Scene
- Bulid server in VMware 
- Some issues encountered
<!-- more -->

## Solution
### VMware Workstation and Device/Credential Guard incompatible
- ![](/images/somethingAboutVMware/Snipaste_2021-12-29_20-51-30.png)
- ![](/images/somethingAboutVMware/Snipaste_2021-12-29_20-52-08.png)
- 👉[Device Guard and Credential Guard hardware readiness tool](https://www.microsoft.com/en-us/download/details.aspx?id=53337)
```shell
    Set-ExecutionPolicy RemoteSigned

    ./DG_Readiness_Tool_v3.6.ps1 -Disable -AutoReboot
        
    ./DG_Readiness_Tool_v3.6.ps1 -Enable -AutoReboot

    ./DG_Readiness_Tool_v3.6.ps1 -Ready
```

- close Hyper-V `bcdedit /set hypervisorlaunchtype off  `

### vmci.sys incompatible
- ![](/images/somethingAboutVMware/Snipaste_2021-12-29_21-28-29.png)
- open .vmx file, set `vmci0.present = "FALSE"`

## Other 
- some setting in dnf
```shell
    .encoding = "GBK"
    config.version = "8"
    virtualHW.version = "10"
    numvcpus = "4"
    cpuid.coresPerSocket = "4"
    scsi0.present = "TRUE"
    scsi0.virtualDev = "lsisas1068"
    sata0.present = "TRUE"
    memsize = "4096"
    mem.hotadd = "TRUE"
    ide0:0.present = "TRUE"
    ide0:0.fileName = "vmfordnf.vmdk"
    ethernet0.present = "TRUE"
    ethernet0.virtualDev = "e1000"
    ethernet0.wakeOnPcktRcv = "FALSE"
    ethernet0.addressType = "static"
    usb.present = "TRUE"
    sound.present = "TRUE"
    sound.virtualDev = "hdaudio"
    sound.fileName = "-1"
    sound.autodetect = "TRUE"
    mks.enable3d = "TRUE"
    pciBridge0.present = "TRUE"
    pciBridge4.present = "TRUE"
    pciBridge4.virtualDev = "pcieRootPort"
    pciBridge4.functions = "8"
    pciBridge5.present = "TRUE"
    pciBridge5.virtualDev = "pcieRootPort"
    pciBridge5.functions = "8"
    pciBridge6.present = "TRUE"
    pciBridge6.virtualDev = "pcieRootPort"
    pciBridge6.functions = "8"
    pciBridge7.present = "TRUE"
    pciBridge7.virtualDev = "pcieRootPort"
    pciBridge7.functions = "8"
    vmci0.present = "FALSE"
    hpet0.present = "TRUE"
    usb.vbluetooth.startConnected = "TRUE"
    displayName = "vmfordnf"
    guestOS = "windows7"
    nvram = "vmfordnf.nvram"
    virtualHW.productCompatibility = "hosted"
    powerType.powerOff = "soft"
    powerType.powerOn = "soft"
    powerType.suspend = "soft"
    powerType.reset = "soft"
    hypervisor.cpuid.v0="FALSE"
    extendedConfigFile = "vmfordnf.vmxf"
    uuid.bios = "56 4d 87 ee d7 81 67 f3-2d 2e 3a db bc 71 88 24"
    uuid.location = "56 4d 87 ee d7 81 67 f3-2d 2e 3a db bc 71 88 24"
    replay.supported = "FALSE"
    replay.filename = ""
    ide0:0.redo = ""
    pciBridge0.pciSlotNumber = "17"
    pciBridge4.pciSlotNumber = "21"
    pciBridge5.pciSlotNumber = "22"
    pciBridge6.pciSlotNumber = "23"
    pciBridge7.pciSlotNumber = "24"
    scsi0.pciSlotNumber = "160"
    usb.pciSlotNumber = "32"
    ethernet0.pciSlotNumber = "33"
    sound.pciSlotNumber = "34"
    vmci0.pciSlotNumber = "36"
    sata0.pciSlotNumber = "37"
    scsi0.sasWWID = "50 05 05 6e d7 81 67 f0"
    ethernet0.generatedAddressOffset = "0"
    vmci0.id = "-1549065039"
    monitor.phys_bits_used = "40"
    vmotion.checkpointFBSize = "134217728"
    cleanShutdown = "TRUE"
    softPowerOff = "TRUE"
    usb:1.speed = "2"
    usb:1.present = "TRUE"
    usb:1.deviceType = "hub"
    usb:1.port = "1"
    usb:1.parent = "-1"
    tools.syncTime = "FALSE"
    disable_acceleration = "TRUE"
    mce.enable = "TRUE"
    monitor_control.vt32 = "TRUE"
    prefvmx.useRecommendedLockedMemSize = "TRUE"
    MemTrimRate = "0"
    monitor.virtual_mmu = "automatic"
    monitor.virtual_exec = "automatic"
    ethernet0.address = "20:50:56:37:0D:A5"
    tools.remindInstall = "TRUE"
    ehci.present = "TRUE"
    SMBIOS.reflectHost = "TRUE"
    ehci.pciSlotNumber = "35"
    ethernet0.linkStatePropagation.enable = "FALSE"
    vhv.enable = "TRUE"
    cpuid.1.eax = "00001111111010111111101111111111"
    cpuid.1.ebx = "00000000000000000000011011110001"
    cpuid.1.ecx = "0--------------0----------------"
    cpuid.1.edx = "-----------0---------0----------"

    hgfs.mapRootShare = "TRUE"
    usb.generic.autoconnect = "FALSE"
    bios.forceSetupOnce = "FALSE"
    toolsInstallManager.updateCounter = "1"
    sharedFolder0.present = "TRUE"
    sharedFolder0.enabled = "TRUE"
    sharedFolder0.readAccess = "TRUE"
    sharedFolder0.writeAccess = "TRUE"
    gui.exitOnCLIHLT = "TRUE"
    monitor_control.restrict_backdoor = "TRUE"
    monitor_control.enable_fullcpuid = "TRUE"
    board-id.reflectHost = "TRUE"
    hw.model.reflectHost = "TRUE"
    serialNumber.reflectHost = "TRUE"
    SMBIOS.noOEMStrings = "TRUE"
    svga.autodetect = "TRUE"
    msg.autoAnswer = "FALSE"
    mks.noBeep = "FALSE"
    sched.mem.pshare.enable = "FALSE"
    sched.mem.maxmemctl = "0"
    MemAllowAutoScaleDown = "FALSE" 
    mem.ShareScanTotal = "0"
    mem.ShareScanVM = "0"
    vmi.present.getPtrLocation.disable = "TRUE"
    isolation.tools.setPtrLocation.disable = "TRUE"
    isolation.tools.setVersion.disable = "TRUE"
    isolation.tools.getVersion.disable = "TRUE"
    monitor_control.disable_directexec = "TRUE"
    monitor_control.disable_chksimd = "TRUE"
    monitor_control.disable_ntreloc = "TRUE"
    monitor_control.disable_selfmod = "TRUE"
    monitor_control.disable_reloc = "TRUE"
    monitor_control.disable_btinout = "TRUE"
    monitor_control.disable_btmemspace = "TRUE"
    monitor_control.disable_btpriv = "TRUE"
    monitor_control.disable_btseg = "TRUE"
    svga.guestBackedPrimaryAware = "TRUE"
    vmx.buildType = "release"
    priority.grabbed = "high"
    mainMem.useNamedFile = "FALSE"
    ethernet0.connectionType = "nat"
    usb:0.present = "TRUE"
    usb:0.deviceType = "hid"
    usb:0.port = "0"
    usb:0.parent = "-1"
    sata0:0.present = "FALSE"
    ide0:1.present = "FALSE"
    sata0:1.present = "FALSE"
    floppy0.present = "FALSE"
```
- another
```shell
    isolation.tools.setVersion.disable = "TRUE"
    isolation.tools.getVersion.disable = "TRUE"
    monitor_control.enable_fullcpuid = TRUE
    cpuid.1.eax = "00001111111010111111101111111111"
    cpuid.1.ebx = "00000000000000000000011011110001"
    cpuid.80000002.0.eax="0110:0101:0111:0100:0110:1110:0100:1001"
    cpuid.80000002.0.ebx="0010:1001:0101:0010:0010:1000:0110:1100"
    cpuid.80000002.0.ecx="0110:1111:0110:0101:0101:1000:0010:0000"
    cpuid.80000002.0.edx="0010:1001:0101:0010:0010:1000:0110:1110"
    cpuid.80000003.0.eax="0101:0101:0101:0000:0100:0011:0010:0000"
    cpuid.80000003.0.ebx="0010:0000:0010:0000:0010:0000:0010:0000"
    cpuid.80000003.0.ecx="0010:0000:0010:0000:0010:0000:0010:0000"
    cpuid.80000003.0.edx="0101:1000:0010:0000:0010:0000:0010:0000"
    cpuid.80000004.0.eax="0011:0101:0011:0111:0011:0110:0011:0101"
    cpuid.80000004.0.ebx="0010:0000:0100:0000:0010:0000:0010:0000"
    cpuid.80000004.0.ecx="0011:0111:0011:0000:0010:1110:0011:0011"
    cpuid.80000004.0.edx="0000:0000:0111:1010:0100:1000:0100:0111"
```