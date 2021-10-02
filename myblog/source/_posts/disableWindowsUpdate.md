---
title: Disable Windows Update
date: 2021-10-02 02:37:02
tags: Windows
---

## Scene
- Disable Windows Update
<!-- more -->

## Solution
- win + r , input "services.msc"
- ![](/images/disableWindowsUpdate/Snipaste_2021-10-02_02-39-27.png)
- win + r , input "regedit"
- make item "WindowsUpdate"
- ![](/images/disableWindowsUpdate/Snipaste_2021-10-02_02-42-00.png)
- make item "AU"
- ![](/images/disableWindowsUpdate/Snipaste_2021-10-02_02-44-11.png)
- make DWORD "AUOptions"
- ![](/images/disableWindowsUpdate/Snipaste_2021-10-02_02-45-30.png)
- value "2"
- ![](/images/disableWindowsUpdate/Snipaste_2021-10-02_02-47-01.png)