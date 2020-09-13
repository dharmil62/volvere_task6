import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Output extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OutputState();
  }
}

class _OutputState extends State<Output> {
  var _name;
  int _color;


  static get preferences => 0xffffffff;


  Future<SharedPreferences> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _name = preferences.getString("name");
    _color = preferences.getInt("color");

    return preferences;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        elevation: 6.0,
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return Container(
              color: Color(_color),
              //color: _color,
              child: ListTile(
                title: Text(
                  _name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}