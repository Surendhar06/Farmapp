import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/sell/farmerdata.dart';
import 'package:project/sell/sellhome.dart';

import 'Main Page.dart';
import 'package:project/Main%20Page.dart';



class SelectionType extends StatefulWidget {
  const SelectionType({Key key}) : super(key: key);

  @override
  _SelectionTypeState createState() => _SelectionTypeState();
}

class _SelectionTypeState extends State<SelectionType> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "I am here to ",
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 30,
                    textStyle: TextStyle(),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    RaisedButton(
                      color: Colors.redAccent,
                      splashColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 15.0),
                      child: Text(
                        "Buy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder:(context)=> MainPage(),
                        ));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      color: Colors.white,
                      splashColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 15.0),
                      child: Text(
                        "Sell",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder:(context)=> SellRegister(),
                        ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}