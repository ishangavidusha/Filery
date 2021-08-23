import 'dart:convert';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SysInfoService with ChangeNotifier {
  Socket _socket = io(
    kReleaseMode ? Uri.base.origin : "http://localhost:5000",
    OptionBuilder().setTransports(['websocket']).setPath("/sysinfo").enableForceNewConnection().disableAutoConnect().build()
  );
  final rangeLimit = 10;
  Map<String, dynamic> _sysData = {};
  bool _isConected = false;

  bool get conected => _isConected;

  Map<String, dynamic> get sysData => _sysData;

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
      _sysData = jsonDecode(data);
      FileryLog.ok(_sysData.toString());
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