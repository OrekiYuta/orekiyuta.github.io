---
title: Enable Hyper-V Service
date: 2021-10-04 23:04:16
tags: [Windows,Docker]
---

## Scene
- After installed Docker Desktop , Cannot enable Hyper-V service.
- ![](/images/enableHyper-Vservice/Snipaste_2021-10-04_22-49-16.png)

<!-- more -->

## Solution
- Check Windows Configuration.
- ![](/images/enableHyper-Vservice/Snipaste_2021-10-04_22-51-11.png)
- win + r , input "cmd".
- Execute `systeminfo`.
- ![](/images/enableHyper-Vservice/Snipaste_2021-10-04_22-50-14.png)
- Must all the Hyper-V Requirements are YES.
- For me , "Virutalization Enabled In Firmware : NO".

- My PC mainboard is Interl H61 , Click "delete" button show the Bios.
- Then, Find and Enabled the Virutalization Configuration.
- ![](/images/enableHyper-Vservice/IMG_20211004_225913.jpg)
- ![](/images/enableHyper-Vservice/IMG_20211004_225923.jpg)

- Final, Check the systeminfo , Open the Docker Desktop as well.
- ![](/images/enableHyper-Vservice/Snipaste_2021-10-04_23-18-11.png)

## Other 
- 👉 [Windows 10 Hyper-V System Requirements](https://docs.microsoft.com/zh-cn/virtualization/hyper-v-on-windows/reference/hyper-v-requirements#verify-hardware-compatibility)