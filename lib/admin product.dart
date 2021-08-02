import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'firebaseservices.dart';

class ProductServices {

 // String ref = "productName";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upLoadProduct(
      {String productName,
List image,
        String category,
        String Description,
        String location,
        List quantity,
        double price,
      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection(category).doc(productId).set({
      'categroy': category,
      'Name': productName,
      'id': productId,
      'Price':price,
      'Quantity':quantity,
      'Description':Description,
      await 'image':image,
      'location':location

    });
  }
}


class registration {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upLoadProduct(
      {String Email,
        String Name,
        String password,
        String location,
        String city,
        String mbl,
        String image,
      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection("Register").doc(productId).set({

      'Name': Name,
      'id': productId,
      'Mbl No:':mbl,
      'Email':Email,
      await 'image':image,
      'Password':password,
'city':city,
   'location':location,

    });
  }
}


class userreg {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser;
  Future<void> upLoadProduct(
      {String Email,
        String Name,
        String password,
String location,
        String city,
        String mbl,
        String image,
      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection("users").document(_user.uid).collection("Register").doc(productId).set({

      'Name': Name,
      await 'image':image,
      'id': productId,
      'Mbl No:':mbl,
      'Email':Email,
      'Password':password,
      'city':city,
      'location':location,


    });
  }
}

class Buynow {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upLoadProduct(
      {String method,
        String Name,
        String city,
        String Address,

        double mbl,
      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection("Buy Now").doc(productId).set({
      'Delivery Type': method,
      'Name': Name,
      'id': productId,
      'Mbl No:':mbl,

      'City & State':city,
      'Address':Address,

    });
  }
}


class sellServices {

  // String ref = "productName";
  final User _user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upLoadProduct(
      {String productName,

        String category,
        String Description,
        List image,
        List quantity,
        double price,
        String location,
      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection("users").document(_user.uid).collection("sell").doc(productId).set({
      'category': category,
      'Name': productName,
      'id': productId,
      'Price':price,
      'Quantity':quantity,
      'Description':Description,

      await 'image':image,
      'location':location

    });
  }
}




class loan {

  // String ref = "productName";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upLoadProduct(
      {String username,
        String images,
        String address,
        String mbl,
        String amount,
        String location,
        String date,
        String exp,
        String repay,
        String acres,
        String age,
        String hname,
        String hdate,
        String hperiod,
        String nsowing,
        String hnext,
        String nsdate,
        String nsperiod,


      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection("loan").doc(productId).set({

      'Name': username,
      'id': productId,
      'Amount':amount,
      'mbl':mbl,
      'Address':address,
     await 'image':images,
      'location':location,
      'date':date,
      'exp':exp,
      'repay':repay,
      'acres':acres,
      'age':age,
      'hname':hname,
      'hdate':hdate,
      'hperiod':hperiod,
      'hnext':hnext,
      'nsowing':nsowing,
      'nsdate':nsdate,
      'nsperiod':nsperiod,


    });
  }
}


class loanuser {

  // String ref = "productName";
  final User _user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upLoadProduct(
      {String username,
        String images,
        String address,
        String mbl,
        String amount,
        String location,
        String date,
        String exp,
        String repay,
        String acres,
        String age,
        String hname,
        String hdate,
        String hperiod,
        String nsowing,
        String hnext,
        String nsdate,
        String nsperiod,



      }) async {
    var id = new Uuid();

    String productId = id.v1();
    _firestore.collection("users").document(_user.uid).collection("loan").doc(productId).set({

      'Name': username,
      'id': productId,
      'Amount':amount,
      'mbl':mbl,
      'Address':address,
      await 'image':images,
      'location':location,
      'date':date,
      'exp':exp,
      'repay':repay,
      'acres':acres,
      'age':age,
      'hname':hname,
      'hdate':hdate,
      'hperiod':hperiod,
      'hnext':hnext,
      'nsowing':nsowing,
      'nsdate':nsdate,
      'nsperiod':nsperiod,

    });
  }
}
