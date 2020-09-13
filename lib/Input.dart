import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volveretask/Output.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';

class Input extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputState();
  }
}

const MaterialColor _buttonTextColor = MaterialColor(0xFFC41A38, <int, Color>{
  50: Color(0xFFC41A38),
  100: Color(0xFFC41A38),
  200: Color(0xFFC41A38),
  300: Color(0xFFC41A38),
  400: Color(0xFFC41A38),
  500: Color(0xFFC41A38),
  600: Color(0xFFC41A38),
  700: Color(0xFFC41A38),
  800: Color(0xFFC41A38),
  900: Color(0xFFC41A38),
});

class _InputState extends State<Input> {
  var _state = ["Gujarat", "Punjab", "Haryana", "Bihar", "Other"];
  var _selectedState;
  DateTime selectedDate;
  Color currentColor = Colors.white;

  void changeColor(Color color)=>setState(()=>currentColor=color);

  var _formkey = GlobalKey<FormState>();

  TextEditingController name_controller = TextEditingController();
  TextEditingController add_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1947),
        lastDate: DateTime.now(),
        textDirection: TextDirection.ltr,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child){
          return Theme(
            data: ThemeData(
              primarySwatch: _buttonTextColor,
              primaryColor: Color(0xFFC41A38),
              accentColor: Color(0xFFC41A38),
            ),
            child: child,
          );
        }
    );


    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  void _save() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name_controller.text);
    preferences.setInt("color", currentColor.value);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Data"),
      ),
      body: Form(
          key: _formkey,
          //padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Center(
                    child: Text(
                      "Fill The Details",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.text,
                      controller: name_controller,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter Name...";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: "Name: ",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Color(0xFFC41A38),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter Address...";
                        }
                        return null;
                      },
                      style: textStyle,
                      controller: add_controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Color(0xFFC41A38),
                        ),
                        labelText: "Address: ",
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: DropdownButton<String>(
                    elevation: 10,
                    hint: Text("Select State"),
                    value: _selectedState,
                    style: textStyle,
                    items: _state.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String newitem) {
                      setState(() {
                        this._selectedState = newitem;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    cursorColor: Color(0xFFC41A38),
                    readOnly: true,
                    onTap: (){
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: ("${selectedDate.toString()}".split(' ')[0]),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC41A38), width: 2.0),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                      )
                    ),
                  ),
                ),

                RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select your favorite color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  color: currentColor,
                  child: const Text('Favourite Color'),
                  textColor: useWhiteForeground(currentColor)
                      ? const Color(0xffffffff)
                      : const Color(0xff000000),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          elevation: 4.0,

                          color: Colors.black87,
                          onPressed: () {
                            setState(() {
                              if (_formkey.currentState.validate()) {
                                _save();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Output();
                                  },
                                ));
                              }
                            });
                          },
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      Expanded(
                        child: RaisedButton(
                          elevation: 5.0,
                          color: Color(0xFFC41A38),
                          onPressed: () {
                            setState(() {
                              name_controller.text = '';
                              add_controller.text = '';
                              _selectedState = null;
                            });
                          },
                          textColor: Theme.of(context).accentColor,
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}