import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Main%20Page.dart';
import 'package:project/RoundedButton.dart';
import 'package:project/admin%20product.dart';
import 'package:project/authentication.dart';
import 'package:project/selectionpage.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class registerpage extends StatefulWidget {

  @override
  _registerpageState createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {

  File _image;

  String _uploadFileURL;





  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final city = TextEditingController();
  final location = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential?.user != null){

      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registration productServices = registration();
  userreg userServices = userreg();
  final Name = TextEditingController();
  final Email = TextEditingController();
  final password = TextEditingController();
  // final phoneController = TextEditingController();
  bool _validate = false;
  @override
  void dispose() {
    password.dispose();
    Email.dispose();
    phoneController.dispose();
    Name.dispose();

    super.dispose();
  }

  String emailUp;
  String passwordup;
  String usernameUp;
  // String phoneController;
  final _auths = authentication();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final SnackBar _snackBar = SnackBar(content: Text("Otp Verified Successfully"),);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(

        children: [
          SizedBox(height: 60,),
          Text(
            'Hey There, \n Lets Sign up',
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Color(0xff476cfb),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image!=null)?Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ):Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/deptcs-1dca6.appspot.com/o/logo.jpeg?alt=media&token=ec37fcd2-5ecf-49fd-a057-20357c7e37b6",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: 30.0,
                  ),
                  onPressed: () {
                    getImage().whenComplete(() => showDialog(
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
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(

            keyboardType: TextInputType.name,
            controller: Name,
            decoration: InputDecoration(
              labelText: 'User Name',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),

          ),
          SizedBox(
            height: 20.0,
          ),

          TextField(

            keyboardType: TextInputType.emailAddress,
            controller: Email,
            decoration: InputDecoration(
              labelText: 'E-mail',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onChanged: (value){
              emailUp = value;
            },
          ),

          SizedBox(
            height: 20.0,
          ),
          TextField(

            obscureText: true,
            controller: password,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),

            onChanged: (value){
              passwordup = value;
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(

            keyboardType: TextInputType.emailAddress,
            controller: city,
            decoration: InputDecoration(
              labelText: 'City',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),

          ),

          SizedBox(
            height: 20.0,
          ),
          TextField(

            keyboardType: TextInputType.emailAddress,
            controller: location,
            decoration: InputDecoration(
              labelText: 'Location',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          TextField(

            //  keyboardType: TextInputType.number,

            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Mbl Number',
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(
                  " (+91) ",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
              suffixIcon: TextButton(
                child: Text("Send OTP"),
                onPressed: () async {

                  setState(() {
                    showLoading = false;
                  });

                  await _auth.verifyPhoneNumber(
                      phoneNumber: phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {

                        setState(() {
                          showLoading = false;
                        });
                        //signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text(verificationFailed.message)));
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {

                          showLoading = false;
                          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        setState(() {
                          this.verificationId = verificationId;
                        });
                      },
                      timeout: Duration(seconds: 120));


                },

              ),
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),

          ),

          SizedBox(height: 20,),
          TextField(

            keyboardType: TextInputType.number,
            controller: otpController,
            decoration: InputDecoration(
              labelText: 'OTP',
              suffixIcon: TextButton(
                child: Text("verify"),
                onPressed: ()async {
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otpController.text);

                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
              ),

              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),

          ),

          SizedBox(
            height: 40.0,
          ),
          SizedBox(
            height: 50.0,
          ),
          Roundedbuttons(
            onpressed: ()async{
              PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
              uploadFile();


              dynamic result = await _auths.Signup(emailUp, passwordup);
              if(result == null){
                print("result is null");
                setState(() {
                  Name.text.isEmpty ? _validate = true : _validate = false;
                  Email.text.isEmpty ? _validate = true : _validate = false;
                  password.text.isEmpty ? _validate = true : _validate = false;

                  phoneController.text.isEmpty ? _validate = true : _validate = false;

                });
              }
              else{
                Navigator.push(context, MaterialPageRoute(
                  builder:(context)=> SelectionType(),
                ));
              }

            },
            colors: Colors.redAccent,
            text: 'Sign up',
            textcolor: Colors.white,
          ),
        ],
      ),
    );
  }


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }
  Future uploadFile() async {
    var firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'profile${Path.basename(_image.path)}');
    var task = firebaseStorageRef.putFile(_image);


    task.whenComplete(() async {
      print('file uploaded');
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      await setState(() {
        print(downloadURL);

        productServices.upLoadProduct(
          Name: Name.text,

          Email: Email.text,
          password:password.text,
          mbl: phoneController.text,
          city:city.text,
          location:location.text,
          image:downloadURL,
        );
        userServices.upLoadProduct(
          Name: Name.text,

          Email: Email.text,
          password:password.text,
          mbl: phoneController.text,
          city:city.text,
          location:location.text,
          image:downloadURL,

        );

      });



    });



  }
}


