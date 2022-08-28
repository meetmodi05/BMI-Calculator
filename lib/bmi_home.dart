import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import "package:google_fonts/google_fonts.dart";

enum genderGroup { male, female }

class MyBMIForm extends StatefulWidget {
  MyBMIForm({Key? key}) : super(key: key);

  @override
  State<MyBMIForm> createState() => _MyBMIFormState();
}

class _MyBMIFormState extends State<MyBMIForm> {
  genderGroup _value = genderGroup.male;
  String buttonName = 'Click';
  String? heighterror = null;
  String bmimessage = "";
  TextEditingController _agecontroller = new TextEditingController();
  TextEditingController _weightcontroller = new TextEditingController();
  TextEditingController _heightcontroller = new TextEditingController();
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  void ShowAlert(String var1) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("BMI"),
            content: Text("$var1"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          );
        });
  }

  void Exitcall() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("BMI"),
            content: Text("Are You Want to Exit ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          );
        });
  }

  void CalculateBMI() {
    var height = double.parse(_heightcontroller.text) != null
        ? double.parse(_heightcontroller.text)
        : 0.0;
    var weight = double.parse(_weightcontroller.text) != null
        ? double.parse(_weightcontroller.text)
        : 0.0;
    int age = int.parse(_agecontroller.text) != null
        ? int.parse(_agecontroller.text)
        : 0;

    var bmi = weight / (height * height) * 10000;
    if (bmi > 16 && bmi < 18.5) {
      setState(() {
        bmimessage =
        "${bmi.toString().substring(0,
            4)} \nooh no! Your BMI is UnderWeight You Should gain your Weight";
      });
    }
    if (bmi > 18.5 && bmi < 24.9) {
      setState(() {
        bmimessage =
        "${bmi.toString().substring(0,
            4)} \nWow! Your BMI is Normal, You can Enjoy Your Favourite Food";
      });
    }
    if (bmi > 24.9 && bmi < 29.9) {
      setState(() {
        bmimessage =
        "${bmi.toString().substring(
            0, 4)} \nooh no! Your BMI is Overweight, You have to do Exercise";
      });
    }
    if (bmi > 29.9) {
      setState(() {
        bmimessage =
        "${bmi.toString().substring(
            0, 4)} \nooh no! Your BMI is Obesis, You have to Join Gym";
      });

      // setState(() {
      //   bmimessage=bmi.toString();
      // });
    }
    ShowAlert(bmimessage.toString());
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop: () {
    //     Exitcall();
    //     return true;
    //   },
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("BMI Calculator"),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Value is Required";
                        }
                        if (int.parse(value) < 12 || int.parse(value) > 100) {
                          return "Enter Valid Age";
                        }
                        return null;
                      },
                      controller: _agecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Enter Your Age',
                            style: GoogleFonts.ubuntu(fontSize: 18),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required Field";
                        }
                        if (double.parse(value) > 275 ||
                            double.parse(value) < 85) {
                          return "Enter Valid Height";
                        }
                        return null;
                      },
                      controller: _heightcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: heighterror,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Height In Centimeter',
                            style: GoogleFonts.ubuntu(fontSize: 18)),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required Field";
                          }
                          if (double.parse(value) > 450 ||
                              double.parse(value) < 30) {
                            return "Enter Correct Weight";
                          }
                          return null;
                        },
                        controller: _weightcontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Enter Your Weight',
                                style: GoogleFonts.ubuntu(fontSize: 18))),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: genderGroup.male,
                        groupValue: _value,
                        onChanged: (genderGroup? val) {
                          if (int.parse(_heightcontroller.text) > 275 ||
                              int.parse(_heightcontroller.text) < 75) {
                            setState(() {
                              heighterror =
                              "Height must between 75cm to 275cm for male";
                              _value = val!;
                            });
                          } else {
                            setState(() {
                              heighterror = null;
                              _value = val!;
                            });
                          }
                        },
                      ),
                      Text(
                        "Male",
                        style: GoogleFonts.ubuntu(fontSize: 20),
                      ),
                      Radio(
                        value: genderGroup.female,
                        groupValue: _value,
                        onChanged: (genderGroup? val) {
                          if (double.parse(_heightcontroller.text) > 225 ||
                              double.parse(_heightcontroller.text) < 75) {
                            setState(() {
                              heighterror =
                              "Height must between 75cm to 225cm for female";
                              _value = val!;
                            });
                          } else {
                            setState(() {
                              heighterror = null;
                              _value = val!;
                            });
                          }
                        },
                      ),
                      Text(
                        "Female",
                        style: GoogleFonts.ubuntu(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                CalculateBMI();
                                // _agecontroller.clear();
                                // _heightcontroller.clear();
                                // _weightcontroller.clear();
                              }
                              return null;
                            },
                            child: Center(
                              child: Text('Calculate',
                                  style: GoogleFonts.ubuntu(fontSize: 20)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(8.0)),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.cyanAccent)),
                            onPressed: () {
                              _agecontroller.clear();
                              _heightcontroller.clear();
                              _weightcontroller.clear();
                            },
                            child: Text("Clear",
                                style: GoogleFonts.ubuntu(fontSize: 20)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    child: Center(
                      child: Text("$bmimessage",
                          style: GoogleFonts.acme(fontSize: 25)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
