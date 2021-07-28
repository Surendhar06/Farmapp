import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

import '../admin product.dart';
import '../firebaseservices.dart';


class Adds extends StatefulWidget {
  @override
  _AddsState createState() => _AddsState();
}

class _AddsState extends State<Adds> {





  ProductServices productServices = ProductServices();


  File _image;
  final picker = ImagePicker();


  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController Pricecontroller = TextEditingController();
  TextEditingController photourls = TextEditingController();


  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

//  GlobalKey<FormState> _secfromkey = GlobalKey<FormState>();
  final SnackBar _save = SnackBar(content: Text("Product added Successfully"),);

  List<String> selectedSize = <String>[];
  File _image1;
  File _image2;
  File _image3;
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
    SystemChrome.setEnabledSystemUIOverlays([]);
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
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Form(
          key: _fromkey,
          child: ListView(
            children: <Widget>[
              isLoading ? CircularProgressIndicator :
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: _displayChild1(),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              1);
                          print('hey');
                        },
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 30.0),
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.8), width: 2.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: _displayChild2(),
                        onPressed: () {
                          _selectImage(
                            // ignore: deprecated_member_use
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              2);
                          print('hey2');
                        },
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 30.0),
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.8), width: 2.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: _displayChild3(),
                        onPressed: () {
                          _selectImage(
                            // ignore: deprecated_member_use
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              3);
                          print('hey3');
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
              Padding(
                child: Text(
                  'please enter 5 characters as maximum',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(8.0),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productnamecontroller,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter product name';
                    } else if (value.length > 5) {
                      return 'product name must be less than 10 characters';
                    }
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: photourls,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    hintText: 'Image URL',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter image';
                    } else if (value.length > 5) {
                      return 'url name must be less than 10 characters';
                    }
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(12.0),
                child: DropdownButton(
                  items: _accountType
                      .map((value) =>
                      DropdownMenuItem(
                        child: Text(
                          value,
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                        value: value,
                      ))
                      .toList(),
                  onChanged: (selectedAccountType) {
                    print('$selectedAccountType');
                    setState(() {
                      selectedType = selectedAccountType;
                    });
                  },
                  value: selectedType,
                  isExpanded: false,
                  hint: Text(
                    'Category',
                    style: TextStyle(color: Color(0xff11b719)),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
//                  initialValue: '1',
                  controller: quantitycontroller,

                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter product name';
                    } else if (value.length > 10) {
                      return 'product name must be less than 10 characters';
                    }
                  },
                ),
              ),


              Container(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
//                  initialValue: '0.00',
                  controller: Pricecontroller,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: '\$',
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter product name';
                    } else if (value.length > 5) {
                      return 'product name must be less than 5characters';
                    }
                  },
                ),
              ),

              Text(
                'Avilable Quantity',
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: selectedSize.contains('0.5g'),
                      onChanged: (value) => changeSelectedSize(value, '0.5g'),
                    ),
                    Text('0.5g'),
                    Checkbox(
                      value: selectedSize.contains('1kg'),
                      onChanged: (value) => changeSelectedSize(value, '1kg'),
                    ),
                    Text('1kg'),
                    Checkbox(
                      value: selectedSize.contains('5kg'),
                      onChanged: (value) => changeSelectedSize(value, '5kg'),
                    ),
                    Text('5kg'),
                    Checkbox(
                      value: selectedSize.contains('10kg'),
                      onChanged: (value) => changeSelectedSize(value, '10kg'),
                    ),
                    Text('10kg'),
                    Checkbox(
                      value: selectedSize.contains('15kg'),
                      onChanged: (value) => changeSelectedSize(value, '15kg'),
                    ),
                    Text('15kg'),

                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: selectedSize.contains('20kg'),
                      onChanged: (value) => changeSelectedSize(value, '20kg'),
                    ),
                    Text('20kg'),

                    Checkbox(
                      value: selectedSize.contains('30kg'),
                      onChanged: (value) => changeSelectedSize(value, '30kg'),
                    ),
                    Text('30kg'),

                    Checkbox(
                      value: selectedSize.contains('40kg'),
                      onChanged: (value) => changeSelectedSize(value, '40kg'),
                    ),
                    Text('40kg'),
                    Checkbox(
                      value: selectedSize.contains('50kg'),
                      onChanged: (value) => changeSelectedSize(value, '50kg'),
                    ),
                    Text('50kg'),

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: selectedSize.contains('1L'),
                      onChanged: (value) => changeSelectedSize(value, '1L'),
                    ),
                    Text('1L'),
                    Checkbox(
                      value: selectedSize.contains('5L'),
                      onChanged: (value) => changeSelectedSize(value, '5L'),
                    ),
                    Text('5L'),
                    Checkbox(
                      value: selectedSize.contains('6L'),
                      onChanged: (value) => changeSelectedSize(value, '6L'),
                    ),
                    Text('6L'),
                    Checkbox(
                      value: selectedSize.contains('7.5L'),
                      onChanged: (value) => changeSelectedSize(value, '7.5L'),
                    ),
                    Text('7.5L'),

                    Checkbox(
                      value: selectedSize.contains('10L'),
                      onChanged: (value) => changeSelectedSize(value, '10L'),
                    ),
                    Text('10L'),
                  ],
                ),
              ),
              FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Add product'),
                  onPressed: () async {
                    validateAndUpload();


                    _fromkey.currentState.reset();
                    setState(() {
                      isLoading = false;
                    });
                    Toast.show('product added', context);
                  }
              ),
              // select category
            ],
          ),
        ));
  }

  void changeSelectedSize(bool value, String Size) {
    if (selectedSize.contains(Size)) {
      setState(() {
        selectedSize.remove(Size);
      });
    } else {
      setState(() {
        selectedSize.insert(0, Size);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int ImageNumber) async {
    File tempimg = await pickImage;
    switch (ImageNumber) {
      case 1:
        setState(() {
          _image1 = tempimg;
        });
        break;
      case 2:
        setState(() {
          _image2 = tempimg;
        });
        break;
      case 3:
        setState(() {
          _image3 = tempimg;
        });
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Icon(
        Icons.add,
        color: Colors.grey,
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Icon(
        Icons.add,
        color: Colors.grey,
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Icon(
        Icons.add,
        color: Colors.grey,
      );
    } else {
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }


  Future validateAndUpload() async {

    String imageUrl1;
   String imageUrl2;
    String imageUrl3;
    CollectionReference imgColRef;

    var firebaseStorageRef = FirebaseStorage.instance.ref().child("image@");


    var task1 = firebaseStorageRef.child("image54").putFile(_image1);


    var task2 = firebaseStorageRef.child("images").putFile(_image2);


    var task3 = firebaseStorageRef.child("image").putFile(_image3);


    List imageList = [imgColRef, imageUrl2, imageUrl3];

    task1.whenComplete(() async {
      print('file uploaded');
      await firebaseStorageRef.getDownloadURL().then((fileURL) {
        setState(() {
          imageUrl1 = fileURL;
        });
      });
    });
    task2.whenComplete(() async {
      print('file uploaded');
      await firebaseStorageRef.getDownloadURL().then((fileURL) {
        setState(() {
          imageUrl2 = fileURL;
        });

      });
    });

    task3.whenComplete(() async {
      print('file uploaded');
      await firebaseStorageRef.getDownloadURL().then((fileURL) {
        setState(() {
          imageUrl3 = fileURL;
        });
      }).whenComplete(() async {
        await imgColRef.add({'url': imageUrl2});
        print('link added to database');
      });
    });


    productServices.upLoadProduct(
      productName: productnamecontroller.text,
      price: double.parse(Pricecontroller.text),
      quantity: selectedSize,
      category:selectedType,
      photo:photourls.text,
      image: imageList,
      Description: quantitycontroller.text,
    );
  }


}
