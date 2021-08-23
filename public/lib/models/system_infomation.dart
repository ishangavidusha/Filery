class SystemInfomationInfoVirtualMemory {
  int? total;
  int? available;
  int? free;
  int? cached;
  int? buffers;

  SystemInfomationInfoVirtualMemory({
    this.total,
    this.available,
    this.free,
    this.cached,
    this.buffers,
  });
  SystemInfomationInfoVirtualMemory.fromJson(Map<String, dynamic> json) {
    total = json["total"]?.toInt();
    available = json["available"]?.toInt();
    free = json["free"]?.toInt();
    cached = json["cached"]?.toInt();
    buffers = json["buffers"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["total"] = total;
    data["available"] = available;
    data["free"] = free;
    data["cached"] = cached;
    data["buffers"] = buffers;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoVirtualMemory(total: $total, available: $available, free: $free, cached: $cached, buffers: $buffers)';
  }
}

class SystemInfomationInfoSwapMemory {
  int? total;
  int? used;
  int? free;
  int? percent;
  int? sin;
  int? sout;

  SystemInfomationInfoSwapMemory({
    this.total,
    this.used,
    this.free,
    this.percent,
    this.sin,
    this.sout,
  });
  SystemInfomationInfoSwapMemory.fromJson(Map<String, dynamic> json) {
    total = json["total"]?.toInt();
    used = json["used"]?.toInt();
    free = json["free"]?.toInt();
    percent = json["percent"]?.toInt();
    sin = json["sin"]?.toInt();
    sout = json["sout"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["total"] = total;
    data["used"] = used;
    data["free"] = free;
    data["percent"] = percent;
    data["sin"] = sin;
    data["sout"] = sout;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoSwapMemory(total: $total, used: $used, free: $free, percent: $percent, sin: $sin, sout: $sout)';
  }
}

class SystemInfomationInfoNetIoCounters {
  int? bytesSent;
  int? bytesRecv;
  int? packetsSent;
  int? packetsRecv;
  int? errin;
  int? errout;
  int? dropin;
  int? dropout;

  SystemInfomationInfoNetIoCounters({
    this.bytesSent,
    this.bytesRecv,
    this.packetsSent,
    this.packetsRecv,
    this.errin,
    this.errout,
    this.dropin,
    this.dropout,
  });
  SystemInfomationInfoNetIoCounters.fromJson(Map<String, dynamic> json) {
    bytesSent = json["bytesSent"]?.toInt();
    bytesRecv = json["bytesRecv"]?.toInt();
    packetsSent = json["packetsSent"]?.toInt();
    packetsRecv = json["packetsRecv"]?.toInt();
    errin = json["errin"]?.toInt();
    errout = json["errout"]?.toInt();
    dropin = json["dropin"]?.toInt();
    dropout = json["dropout"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["bytesSent"] = bytesSent;
    data["bytesRecv"] = bytesRecv;
    data["packetsSent"] = packetsSent;
    data["packetsRecv"] = packetsRecv;
    data["errin"] = errin;
    data["errout"] = errout;
    data["dropin"] = dropin;
    data["dropout"] = dropout;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoNetIoCounters(bytesSent: $bytesSent, bytesRecv: $bytesRecv, packetsSent: $packetsSent, packetsRecv: $packetsRecv, errin: $errin, errout: $errout, dropin: $dropin, dropout: $dropout)';
  }
}

class SystemInfomationInfoDiskUsageRoot {
  String? device;
  String? fstype;
  String? mountpoint;
  int? total;
  int? used;

  SystemInfomationInfoDiskUsageRoot({
    this.device,
    this.fstype,
    this.mountpoint,
    this.total,
    this.used,
  });
  SystemInfomationInfoDiskUsageRoot.fromJson(Map<String, dynamic> json) {
    device = json["device"]?.toString();
    fstype = json["fstype"]?.toString();
    mountpoint = json["mountpoint"]?.toString();
    total = json["total"]?.toInt();
    used = json["used"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["device"] = device;
    data["fstype"] = fstype;
    data["mountpoint"] = mountpoint;
    data["total"] = total;
    data["used"] = used;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoDiskUsageRoot(device: $device, fstype: $fstype, mountpoint: $mountpoint, total: $total, used: $used)';
  }
}

class SystemInfomationInfoDiskUsage {
  SystemInfomationInfoDiskUsageRoot? root;

  SystemInfomationInfoDiskUsage({
    this.root,
  });
  SystemInfomationInfoDiskUsage.fromJson(Map<String, dynamic> json) {
    root = (json["root"] != null) ? SystemInfomationInfoDiskUsageRoot.fromJson(json["root"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (root != null) {
      data["root"] = root!.toJson();
    }
    return data;
  }
}

class SystemInfomationInfoDiskIoCounters {
  int? readCount;
  int? writeCount;
  int? readBytes;
  int? writeBytes;
  int? readTime;
  int? writeTime;
  int? readMergedCount;
  int? writeMergedCount;
  int? busyTime;

  SystemInfomationInfoDiskIoCounters({
    this.readCount,
    this.writeCount,
    this.readBytes,
    this.writeBytes,
    this.readTime,
    this.writeTime,
    this.readMergedCount,
    this.writeMergedCount,
    this.busyTime,
  });
  SystemInfomationInfoDiskIoCounters.fromJson(Map<String, dynamic> json) {
    readCount = json["readCount"]?.toInt();
    writeCount = json["writeCount"]?.toInt();
    readBytes = json["readBytes"]?.toInt();
    writeBytes = json["writeBytes"]?.toInt();
    readTime = json["readTime"]?.toInt();
    writeTime = json["writeTime"]?.toInt();
    readMergedCount = json["readMergedCount"]?.toInt();
    writeMergedCount = json["writeMergedCount"]?.toInt();
    busyTime = json["busyTime"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["readCount"] = readCount;
    data["writeCount"] = writeCount;
    data["readBytes"] = readBytes;
    data["writeBytes"] = writeBytes;
    data["readTime"] = readTime;
    data["writeTime"] = writeTime;
    data["readMergedCount"] = readMergedCount;
    data["writeMergedCount"] = writeMergedCount;
    data["busyTime"] = busyTime;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoDiskIoCounters(readCount: $readCount, writeCount: $writeCount, readBytes: $readBytes, writeBytes: $writeBytes, readTime: $readTime, writeTime: $writeTime, readMergedCount: $readMergedCount, writeMergedCount: $writeMergedCount, busyTime: $busyTime)';
  }
}

class SystemInfomationInfoCpuStats {
  int? ctxSwitches;
  int? interrupts;
  int? softInterrupts;
  int? syscalls;

  SystemInfomationInfoCpuStats({
    this.ctxSwitches,
    this.interrupts,
    this.softInterrupts,
    this.syscalls,
  });
  SystemInfomationInfoCpuStats.fromJson(Map<String, dynamic> json) {
    ctxSwitches = json["ctxSwitches"]?.toInt();
    interrupts = json["interrupts"]?.toInt();
    softInterrupts = json["softInterrupts"]?.toInt();
    syscalls = json["syscalls"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["ctxSwitches"] = ctxSwitches;
    data["interrupts"] = interrupts;
    data["softInterrupts"] = softInterrupts;
    data["syscalls"] = syscalls;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoCpuStats(ctxSwitches: $ctxSwitches, interrupts: $interrupts, softInterrupts: $softInterrupts, syscalls: $syscalls)';
  }
}

class SystemInfomationInfo {
  int? bootTime;
  int? cpuCount;
  SystemInfomationInfoCpuStats? cpuStats;
  double? cpuLoad;
  SystemInfomationInfoDiskIoCounters? diskIoCounters;
  SystemInfomationInfoDiskUsage? diskUsage;
  SystemInfomationInfoNetIoCounters? netIoCounters;
  SystemInfomationInfoSwapMemory? swapMemory;
  SystemInfomationInfoVirtualMemory? virtualMemory;

  SystemInfomationInfo({
    this.bootTime,
    this.cpuCount,
    this.cpuStats,
    this.cpuLoad,
    this.diskIoCounters,
    this.diskUsage,
    this.netIoCounters,
    this.swapMemory,
    this.virtualMemory,
  });
  SystemInfomationInfo.fromJson(Map<String, dynamic> json) {
    bootTime = json["bootTime"]?.toInt();
    cpuCount = json["cpuCount"]?.toInt();
    cpuStats = (json["cpuStats"] != null) ? SystemInfomationInfoCpuStats.fromJson(json["cpuStats"]) : null;
    cpuLoad = json["cpuLoad"]?.toDouble();
    diskIoCounters = (json["diskIoCounters"] != null) ? SystemInfomationInfoDiskIoCounters.fromJson(json["diskIoCounters"]) : null;
    diskUsage = (json["diskUsage"] != null) ? SystemInfomationInfoDiskUsage.fromJson(json["diskUsage"]) : null;
    netIoCounters = (json["netIoCounters"] != null) ? SystemInfomationInfoNetIoCounters.fromJson(json["netIoCounters"]) : null;
    swapMemory = (json["swapMemory"] != null) ? SystemInfomationInfoSwapMemory.fromJson(json["swapMemory"]) : null;
    virtualMemory = (json["virtualMemory"] != null) ? SystemInfomationInfoVirtualMemory.fromJson(json["virtualMemory"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["bootTime"] = bootTime;
    data["cpuCount"] = cpuCount;
    if (cpuStats != null) {
      data["cpuStats"] = cpuStats!.toJson();
    }
    data["cpuLoad"] = cpuLoad;
    if (diskIoCounters != null) {
      data["diskIoCounters"] = diskIoCounters!.toJson();
    }
    if (diskUsage != null) {
      data["diskUsage"] = diskUsage!.toJson();
    }
    if (netIoCounters != null) {
      data["netIoCounters"] = netIoCounters!.toJson();
    }
    if (swapMemory != null) {
      data["swapMemory"] = swapMemory!.toJson();
    }
    if (virtualMemory != null) {
      data["virtualMemory"] = virtualMemory!.toJson();
    }
    return data;
  }

  @override
  String toString() => 'SystemInfomationInfo(bootTime: $bootTime, cpuCount: $cpuCount, cpuLoad: $cpuLoad)';
}

class SystemInfomation {
  String? msg;
  SystemInfomationInfo? info;

  SystemInfomation({
    this.msg,
    this.info,
  });
  SystemInfomation.fromJson(Map<String, dynamic> json) {
    msg = json["msg"]?.toString();
    info = (json["info"] != null) ? SystemInfomationInfo.fromJson(json["info"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["msg"] = msg;
    if (info != null) {
      data["info"] = info!.toJson();
    }
    return data;
  }

  @override
  String toString() => 'SystemInfomation(msg: $msg)';
}
