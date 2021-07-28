import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Main%20Page.dart';
import 'package:project/selectionpage.dart';
import 'RoundedButton.dart';
import 'admin product.dart';
import 'authentication.dart';
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

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

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
            height: 130.0,
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
          SizedBox(height: 20,),
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

              productServices.upLoadProduct(
                Name: Name.text,

                Email: Email.text,
                password:password.text,
                mbl: phoneController.text,

              );

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
}
