import 'package:flutter/material.dart';

class DirectoryView extends StatefulWidget {
  const DirectoryView({ Key? key }) : super(key: key);

  @override
  _DirectoryViewState createState() => _DirectoryViewState();
}

class _DirectoryViewState extends State<DirectoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Text("Directory"),
      ),
    );
  }
}