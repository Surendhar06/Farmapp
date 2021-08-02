import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:project/Main%20Page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

import '../admin product.dart';


class Addloan extends StatefulWidget {
  @override
  _AddloanState createState() => _AddloanState();
}

class _AddloanState extends State<Addloan> {
  File _image;
  final picker = ImagePicker();
  String _uploadFileURL;




  loan productServices = loan();

  loanuser sellservices = loanuser();


 TextEditingController mbl = TextEditingController();
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController repay = TextEditingController();
  TextEditingController acres = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController hname = TextEditingController();
  TextEditingController hdate = TextEditingController();
  TextEditingController hperiod = TextEditingController();
  TextEditingController hnext = TextEditingController();
  TextEditingController nsowing = TextEditingController();
  TextEditingController nsdate = TextEditingController();
  TextEditingController nsperiod = TextEditingController();


  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

//  GlobalKey<FormState> _secfromkey = GlobalKey<FormState>();
  final SnackBar _save = SnackBar(content: Text("Product added Successfully"),);

  List<String> selectedSize = <String>[];


  bool isLoading = false;

  var selectedType;
  List<String> _accountType = <String>[
    'Rice', 'Wheat',
    'Grains',
    'Cereals',
    'Fruits&Vegetables',
    'Pulses',
    'Oils',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          title: Text(
            'Add Loan',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(

          child: ListView(
            children: <Widget>[
              isLoading ? CircularProgressIndicator :
              Padding(
                child: Text(
                  'Loan Applicant Photo',
                  style: TextStyle(color: Colors.red,fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(8.0),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(

                      padding: EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: _displayChild1(),
                        onPressed: () {
                          chooseImage().whenComplete(() => showDialog(
                              context: context,
                              builder:(cmt)=> AlertDialog(
                                title: Text('Confirm Upload ?'),
                                content: Container(
                                  height: MediaQuery.of(context).size.height / 3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(_image.path), fit: BoxFit.cover)),
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel')),
                                  FlatButton(
                                      onPressed: () {

                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Confirm'))
                                ],
                              )));
                        },
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 30.0),
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.8), width: 2.0),
                      ),
                    ),
                  ),


                ],
              ),

              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productnamecontroller,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Name',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter  name';
                  } else if (value.length > 20) {
                    return 'name must be less than 20 characters';
                  }
                },

                ),
              ),





              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: mbl,
                  decoration: InputDecoration(
                    labelText: 'Mbl No.',
                    hintText: 'Mbl no.',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter number';
                  } else if (value.length > 13) {
                    return 'number must be less than 13 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    hintText: 'Age 18+',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter Correct age';
                  } else if (value.length > 3) {
                    return 'Age must be greater than 18years';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: exp,
                  decoration: InputDecoration(
                    labelText: 'Farmer Experience Year',
                    hintText: 'Experience yr',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter experience';
                  } else if (value.length > 3) {
                    return ' experience must be less than 3 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: date,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: 'dd/mm/yyyy',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter date';
                  } else if (value.length > 11) {
                    return 'Date must be less than 11 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: acres,
                  decoration: InputDecoration(
                    labelText: 'Acres',
                    hintText: 'Acres',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter Acres';
                  } else if (value.length > 5) {
                    return 'Acres must be less than 5 characters';
                  }
                },

                ),
              ),


              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: location,
                  decoration: InputDecoration(
                    labelText: 'Field Location',
                    hintText: 'location',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter location';
                  } else if (value.length > 10) {
                    return 'location must be less than 10 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Address',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter Address';
                  } else if (value.isEmpty) {
                    return 'Enter ur Address';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: amount,
                  decoration: InputDecoration(
                    labelText: 'Money needed',
                    hintText: 'Amount',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter Money needed';
                  } else if (value.length > 10) {
                    return 'Amount must be less than 10 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: hname,
                  decoration: InputDecoration(
                    labelText: 'Recently Harvest product Name',
                    hintText: 'product name',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter recently harvest product name ';
                  } else if (value.length > 15) {
                    return 'recently harvest product name must be less than 15 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: hdate,
                  decoration: InputDecoration(
                    labelText: 'Recently Harvest product date',
                    hintText: 'dd/mm/yyyy',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter recently harvest product date';
                  } else if (value.length > 11) {
                    return 'Recently harvest product date must be less than 11 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: hperiod,
                  decoration: InputDecoration(
                    labelText: 'Recently Harvest growth period',
                    hintText: 'growth period',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter growth period';
                  } else if (value.length > 10) {
                    return 'growth period must be less than 10 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: hnext,
                  decoration: InputDecoration(
                    labelText: 'Next Harvest Available are not:',
                    hintText: 'Yes or No',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter Next harvest available are not';
                  } else if (value.length > 4) {
                    return 'harvest available must be less than 4 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: nsowing,
                  decoration: InputDecoration(
                    labelText: 'Next Sowing Product Name',
                    hintText: 'sowing product name',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter next sowing product name';
                  } else if (value.length > 10) {
                    return 'sowing product name must be less than 10 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: nsdate,
                  decoration: InputDecoration(
                    labelText: 'Next Sowing Product Date',
                    hintText: 'dd/mm/yyyy',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter next sowing product date';
                  } else if (value.length > 11) {
                    return 'sowing product date must be less than 11 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: nsperiod,
                  decoration: InputDecoration(
                    labelText: 'Next Sowing growth Period',
                    hintText: 'growth period',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter next sowing growth period';
                  } else if (value.length > 10) {
                    return 'sowing growth period must be less than 10 characters';
                  }
                },

                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: repay,
                  decoration: InputDecoration(
                    labelText: 'Repay Details',
                    hintText: 'Repay Details',
                  ),validator: (value) {
                  if (value.isEmpty) {
                    return 'you must enter Repay details';
                  } else if (value.length > 30) {
                    return 'Repay details must be less than 30 characters';
                  }
                },

                ),
              ),





              FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Add Loan'),
                  onPressed: () async {

                    uploadFile();

                    _fromkey.currentState.reset();
                    setState(() {
                      isLoading = false;
                    });
                    Toast.show('Loan Application added', context);
                  }
              ),
              // select category
            ],
          ),
        ));
  }


  Widget _displayChild1() {
    if (_image == null) {
      return Icon(
        Icons.add,

        color: Colors.grey,
      );
    } else {
      return Image.file(
        _image,
        fit: BoxFit.fill,

      );
    }
  }


  Future chooseImage() async {

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });

    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }

  //task.whenComplete(() async {
  //downloadURL = await firebaseStorageRef.getDownloadURL();
  Future  uploadFile() async {



    var firebaseStorageRef = FirebaseStorage.instance.ref().child('Loan${Path.basename(_image.path)}');
    var task = firebaseStorageRef.putFile(_image);

    task.whenComplete(() async {
      String downloadURL = await firebaseStorageRef.getDownloadURL();


      print('file uploaded');
      await
        setState(() {
print(amount.text);
print(mbl.text);
print(downloadURL);
          productServices.upLoadProduct(

            username: productnamecontroller.text,
            amount:amount.text,
            mbl:mbl.text,
            address:address.text,
            images:downloadURL,
            date:date.text,
            location:location.text,
            exp:exp.text,
            repay:repay.text,
            acres:acres.text,
            age:age.text,
            hname:hname.text,
            hdate:hdate.text,
            hperiod:hperiod.text,
            hnext:hnext.text,
            nsowing:nsowing.text,
            nsdate:nsdate.text,
            nsperiod:nsperiod.text,

          );
sellservices.upLoadProduct(

  username: productnamecontroller.text,
  amount:amount.text,
  mbl:mbl.text,
  address:address.text,
  images:downloadURL,
  date:date.text,
  location:location.text,
  exp:exp.text,
  repay:repay.text,
  acres:acres.text,
  age:age.text,
  hname:hname.text,
  hdate:hdate.text,
  hperiod:hperiod.text,
  hnext:hnext.text,
  nsowing:nsowing.text,
  nsdate:nsdate.text,
  nsperiod:nsperiod.text,


);


        });
      });
  }




}



