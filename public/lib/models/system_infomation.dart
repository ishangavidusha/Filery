import 'package:fileryapp/utils/bytes_converter.dart';

class SystemInfomationInfoVirtualMemory {
  int? total;
  int? used;
  int? available;
  int? free;
  int? cached;
  int? buffers;

  SystemInfomationInfoVirtualMemory({
    this.total,
    this.used,
    this.available,
    this.free,
    this.cached,
    this.buffers,
  });
  SystemInfomationInfoVirtualMemory.fromJson(Map<String, dynamic> json) {
    total = json["total"]?.toInt();
    used = json["used"]?.toInt();
    available = json["available"]?.toInt();
    free = json["free"]?.toInt();
    cached = json["cached"]?.toInt();
    buffers = json["buffers"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["total"] = total;
    data["used"] = used;
    data["available"] = available;
    data["free"] = free;
    data["cached"] = cached;
    data["buffers"] = buffers;
    return data;
  }

  @override
  String toString() {
    return "${byteSize(used)} / ${byteSize(total)}";
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
  double? netIn;
  double? netOut;

  SystemInfomationInfoNetIoCounters({
    this.netIn,
    this.netOut,
  });
  SystemInfomationInfoNetIoCounters.fromJson(Map<String, dynamic> json) {
    netIn = json["netIn"]?.toDouble();
    netOut = json["netOut"]?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["netIn"] = netIn;
    data["netOut"] = netOut;
    return data;
  }

  @override
  String toString() {
    return 'SystemInfomationInfoNetIoCounters(netIn: $netIn, netOut: $netOut)';
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

class SystemInfomationInfo {
  int? bootTime;
  int? cpuCount;
  double? cpuLoad;
  SystemInfomationInfoDiskUsage? diskUsage;
  SystemInfomationInfoNetIoCounters? netIoCounters;
  SystemInfomationInfoSwapMemory? swapMemory;
  SystemInfomationInfoVirtualMemory? virtualMemory;

  SystemInfomationInfo({
    this.bootTime,
    this.cpuCount,
    this.cpuLoad,
    this.diskUsage,
    this.netIoCounters,
    this.swapMemory,
    this.virtualMemory,
  });
  SystemInfomationInfo.fromJson(Map<String, dynamic> json) {
    bootTime = json["bootTime"]?.toInt();
    cpuCount = json["cpuCount"]?.toInt();
    cpuLoad = json["cpuLoad"]?.toDouble();
    diskUsage = (json["diskUsage"] != null) ? SystemInfomationInfoDiskUsage.fromJson(json["diskUsage"]) : null;
    netIoCounters = (json["netIoCounters"] != null) ? SystemInfomationInfoNetIoCounters.fromJson(json["netIoCounters"]) : null;
    swapMemory = (json["swapMemory"] != null) ? SystemInfomationInfoSwapMemory.fromJson(json["swapMemory"]) : null;
    virtualMemory = (json["virtualMemory"] != null) ? SystemInfomationInfoVirtualMemory.fromJson(json["virtualMemory"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["bootTime"] = bootTime;
    data["cpuCount"] = cpuCount;
    data["cpuLoad"] = cpuLoad;
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
