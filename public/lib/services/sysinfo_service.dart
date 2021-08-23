import 'package:fileryapp/models/system_infomation.dart';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SysInfoService with ChangeNotifier {
  Socket _socket = io(
    kReleaseMode ? Uri.base.origin : "http://localhost:5000",
    OptionBuilder().enableForceNewConnection().disableAutoConnect().build()
  );
  final rangeLimit = 10;
  bool _isConected = false;
  SystemInfomation _systemInfomation = SystemInfomation();

  bool get conected => _isConected;

  SystemInfomation get sysData => _systemInfomation;

  void conect() async {
    FileryLog.v("SocketIo Conection Starting...");
    close();
    await Future.delayed(Duration(milliseconds: 200));
    _socket.connect();

    _socket.onConnect((data) {
      _isConected = true;
      notifyListeners();
      FileryLog.ok("Socket.io is Conected!");
    });

    _socket.emit("sysdata", { "msg": "Hello Server" });

    _socket.on("sysdata", (data) {
      _systemInfomation = SystemInfomation.fromJson(data);
      FileryLog.ok(_systemInfomation.info!.bootTime.toString());
      notifyListeners();
    });

    _socket.onDisconnect((data) {
      _isConected = false;
      notifyListeners();
      FileryLog.v("Disconected : $data");
    });

    _socket.onError((data) {
      _isConected = false;
      notifyListeners();
      FileryLog.v("Disconected : $data");
    });
    
  }

  void close() {
    if (_socket.connected) {
      _socket.close();
      _isConected = false;
      notifyListeners();
    }
  }
}