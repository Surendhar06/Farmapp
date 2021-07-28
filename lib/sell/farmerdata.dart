import 'dart:io';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:project/RoundedButton.dart';
import 'package:project/sell/sellhome.dart';

class SellRegister extends StatefulWidget {
  const SellRegister({Key key}) : super(key: key);

  @override
  _SellRegisterState createState() => _SellRegisterState();
}

class _SellRegisterState extends State<SellRegister> {
  @override
  File _image;
  //ImagePicker instance.
  final picker = ImagePicker();

  _getImage(ImageSource imageSource) async {
    PickedFile imageFile = await picker.getImage(source: imageSource);
//if user doesn't take any image, just return.
    if (imageFile == null) return;

    setState(
          () {
//Rebuild UI with the selected image.
        _image = File(imageFile.path);
        FarmersData.profilePic = _image as Path;
      },
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            " Register your Profile ",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          backgroundImage: _image == null
                              ? NetworkImage(
                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fvillagesonmacarthur.com%2Fcommunity%2Fblank-avatar%2F&psig=AOvVaw3rSODFFzARmrSxZzQhTz9b&ust=1626883916444000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCMDmroSF8vECFQAAAAAdAAAAABAc")
                              : FileImage(File(_image.path)),
                          radius: 50.0,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -22,
                          child: RawMaterialButton(
                            onPressed: () {
                              _getImage(ImageSource.gallery);
                            },
                            elevation: 2.0,
                            fillColor: Color(0xFFF5F6F9),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.redAccent,
                            ),
                            padding: EdgeInsets.all(8),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 520,
                    width: 350,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5.0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView(children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextField(
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    FarmersData.name = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      hintText: 'Enter your Name'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextField(

                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    FarmersData.phNo = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Phone Number',
                                      hintText: 'Enter your Phone Number'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    FarmersData.age = double.parse(value);
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Age',
                                      hintText: 'Enter your age'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    FarmersData.experience =
                                        double.parse(value);
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Experience',
                                      hintText:
                                      'Enter your Experience in years'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    FarmersData.acre = double.parse(value);
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Acre',
                                      hintText: 'Enter your land Acre'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextField(
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    FarmersData.landType = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Land type',
                                      hintText: 'Enter your land type'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextField(
                                  maxLines: 6,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    FarmersData.Bio = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Bio',
                                      hintText: 'Tell us about yourself'),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                        "Click here to select the fields location"))
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Roundedbuttons(
                      text: "Register",
                      textcolor: Colors.white,
                      colors: Colors.redAccent,

                    onpressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder:(context)=> SellHome(),
                      ));
                    },),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class FarmersData {
  static String name;
  static String phNo;
  static double age;
  static double experience;
  static double acre;
  static String Bio;
  static String landType;
  static Path profilePic;



// FarmersProfile(
//     {@required this.landType,
//     @required this.lat,
//     @required this.long,
//     @required this.name,
//     @required this.phNo});
}