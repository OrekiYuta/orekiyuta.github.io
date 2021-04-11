---
title: Vritual Disk Mapping
date: 2021-04-10 17:38:55
tags: Batch
---

## Create Vritual Disk Mapping
- 将物理盘符中的目录映射到虚拟盘符，能够在一定的场景发挥作用

```bat
    @echo off
    ::在物理盘符下创建文件夹
    ::如果存在虚拟盘符就执行删除盘符映射关系
    ::创建虚拟盘符并映射到物理盘符的文件夹
    ::打开虚拟盘符

    ::H 物理盘符名
    md H:\RECYCLED\UDrives.{25336920-03F9-11CF-8FD0-00AA00686F13}>NUL
    ::M 虚拟盘符名
    if exist M:\NUL goto delete
    ::映射虚拟盘符 M 到 物理盘符 H 下的 RECYCLED\UDrives.{25336920-03F9-11CF-8FD0-00AA00686F13} 目录
    subst M: H:\RECYCLED\UDrives.{25336920-03F9-11CF-8FD0-00AA00686F13}
    start M:\
    goto end
    :delete
    subst /D M:
    :end
```
<!-- more -->

```bat
    @echo off
    set inputTimes=3
    echo.
    echo Notice:Three opportunities.
    echo.

    :1
    set /p password=Input password：
    if \"%password%\"==\"IamPassword\" goto o

    set /a inputTimes-=1
    if \"%inputTimes%\"==\"0\" cls&echo.&echo =<Passenger no entry>!!!=&echo.&pause&echo.&exit

    cls&echo.&echo There are %inputTimes% opportunities left&echo.&goto 1

    :o
    cls&echo.
    echo= Welcome!!! =
    md H:\RECYCLED\UDrives.{25336920-03F9-11CF-8FD0-00AA00686F13}>NUL
    if exist M:\NUL goto delete
    subst M: H:\RECYCLED\UDrives.{25336920-03F9-11CF-8FD0-00AA00686F13}
    start M:\
    goto end
    :delete
    subst /D M:
    :end
```