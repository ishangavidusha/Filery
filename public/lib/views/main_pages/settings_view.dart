import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({ Key? key }) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Text("Settings"),
      ),
    );
  }
}