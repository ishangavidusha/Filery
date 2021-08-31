import 'dart:async';

import 'package:fileryapp/models/system_infomation.dart';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:fileryapp/utils/stack_queue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SysInfoService with ChangeNotifier {
  Socket _socket = io(
    kReleaseMode ? Uri.base.origin : "http://localhost:5000",
    OptionBuilder().disableAutoConnect().build()
  );
  final rangeLimit = 10;
  FileryStack<SystemInfomationInfoVirtualMemory> _ramUsageHistory = FileryStack<SystemInfomationInfoVirtualMemory>();
  bool _isConected = false;
  late SystemInfomation _systemInfomation;
  late Timer _sysDataCallTimer;

  bool get conected => _isConected;
  String get currentRamUsageString => _ramUsageHistory.peek() != null ? _ramUsageHistory.peek().toString() : "";
  List<SystemInfomationInfoVirtualMemory> get ramUsage => this._ramUsageHistory.data;

  double getCpuLoad() {
    try {
      return _systemInfomation.info!.cpuLoad ?? 0.0;
    } catch (e) {
      FileryLog.e(e.toString());
      return 0.0;
    }
  }

  void ramDataManager() {
    if (_systemInfomation.info!.virtualMemory != null) {
      _ramUsageHistory.pushAndPop(_systemInfomation.info!.virtualMemory ?? SystemInfomationInfoVirtualMemory(
        available: 0,
        total: 0,
        free: 0,
        cached: 0,
        buffers: 0
      ));
    }
  }

  void _populate() {
    this._ramUsageHistory.populate(SystemInfomationInfoVirtualMemory(
      available: 0,
      used: 0,
      total: 0,
      free: 0,
      cached: 0,
      buffers: 0
    ), 60);
  }

  void _startTimer() {
    _socket.emit("sysdata", { "msg": "Hello Server" });
  }
 
  void conect() async {
    FileryLog.v("SocketIo Conection Starting...");
    close();
    _populate();
    _socket.clearListeners();
    await Future.delayed(Duration(milliseconds: 200));
    _socket.connect();

    _socket.onConnect((data) {
      try {
        if (_sysDataCallTimer.isActive) {
          _sysDataCallTimer.cancel();
        }
      } catch (e) {
        FileryLog.e(e.toString());
      }
      _sysDataCallTimer = Timer.periodic(Duration(seconds: 1), (Timer t) => _startTimer());
      _isConected = true;
      notifyListeners();
      FileryLog.ok("Socket.io is Conected!");
    });

    

    _socket.on("sysdata", (data) {
      _systemInfomation = SystemInfomation.fromJson(data);
      FileryLog.v(_systemInfomation.info!.cpuLoad.toString());
      ramDataManager();
      notifyListeners();
    });

    _socket.onDisconnect((data) {
      _isConected = false;
      notifyListeners();
      try {
        if (_sysDataCallTimer.isActive) {
          _sysDataCallTimer.cancel();
        }
      } catch (e) {
        FileryLog.e(e.toString());
      }
      FileryLog.v("Disconected : $data");
    });

    _socket.onError((data) {
      _isConected = false;
      try {
        if (_sysDataCallTimer.isActive) {
          _sysDataCallTimer.cancel();
        }
      } catch (e) {
        FileryLog.e(e.toString());
      }
      notifyListeners();
      FileryLog.v("Disconected : $data");
    });
    
  }

  void close() {
    try {
      if (_sysDataCallTimer.isActive) {
        _sysDataCallTimer.cancel();
      }
    } catch (e) {
      FileryLog.e(e.toString());
    }
    if (_socket.connected) {
      _socket.close();
      _isConected = false;
      notifyListeners();
    }
  }
}