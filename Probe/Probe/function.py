#!/usr/bin/env python
# -*- coding: utf-8 -*-

import wmi
import os
import socket
import platform
import time


def osInfo():
    info = platform.platform() + "," + platform.machine()
    return info


def diskInfo():
    info=""
    c = wmi.WMI()
    # 获取硬盘分区
    for physical_disk in c.Win32_DiskDrive():
        for partition in physical_disk.associators("Win32_DiskDriveToDiskPartition"):
            for logical_disk in partition.associators("Win32_LogicalDiskToPartition"):
                info = info + str(physical_disk.Caption.encode("UTF8")) + "  " + str(logical_disk.Caption) + "\n"

                # 获取硬盘使用百分情况
    for disk in c.Win32_LogicalDisk(DriveType=3):
        info = info + disk.Caption + str(int(100.0 * int(disk.FreeSpace) / int(disk.Size))) + "% free\n"
    return info


def memInfo():
    c = wmi.WMI()
    info = ""
    for Memory in c.Win32_PhysicalMemory():
        info = info + "Memory Capacity: " + str(int(Memory.Capacity) / 1048576) + "MB\n"
    return info


def cpuInfo():
    c = wmi.WMI()
    # CPU类型
    info = ""
    for processor in c.Win32_Processor():
        info = info + processor.Name.strip() + "\n"
    return info


def portInfo():
    c = wmi.WMI()
    info = ""
        # 获取当前运行的进程
    for process in c.Win32_Process():
        info = info + str(process.ProcessId) + str(process.Name) + "\n"
    return info


def ipInfo():
    # 获取本机计算机名称
    hostname = socket.gethostname()
    # 获取本机ip
    ip = socket.gethostbyname(hostname)
    return ip

