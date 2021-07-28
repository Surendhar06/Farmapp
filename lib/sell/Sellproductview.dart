import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Custom_Action_bar.dart';
import 'package:project/Main%20Page.dart';
import 'package:project/imageswipe.dart';
import 'package:project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Quantity.dart';
import 'package:project/firebaseservices.dart';
import 'package:project/sell/firebase.dart';
import 'package:project/sell/sellhome.dart';
import 'package:project/sell/sellprofile.dart';
import '../constants.dart';

import '../firebaseservices.dart';

class sellPage extends StatelessWidget {
  Firebaseservices _firebaseservices = Firebaseservices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text("Sell Product & View",style:Constants.boldHeading)),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {

                }),
           IconButton(onPressed: (){},
               icon: Icon(Icons.notification_important))
          ]
      ),
drawer: Drawer(
  child: ListView(
    children: [
      InkWell(
        onTap: (){ Navigator.push(context, MaterialPageRoute(
          builder:(context)=> SellHome(),
        )); },

        child: ListTile(
          title: Text('Home Page'),
          leading: Icon(Icons.home),
        ),
      ),

      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder:(context)=> FarmersProfile(),
          ));
        },
        child: ListTile(
          title: Text('Profile'),
          leading: Icon(Icons.person),
        ),
      ),

      InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(
          builder:(context)=> MainPage(),
        ));},
        child: ListTile(
          title: Text('Customer'),
          leading: Icon(Icons.account_box_outlined),
        ),
      ),
    ],
  ),
),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed:(){
          Navigator.push(context, MaterialPageRoute(
            builder:(context)=> AddProduct(),
          ));}
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            FutureBuilder <QuerySnapshot>(
                future: _firebaseservices.userID.doc(_firebaseservices.getuserId())
                    .collection("sell").get(),
                builder:(context,snapshot){
                  if(snapshot.hasError){
                    return Scaffold(
                      body: Center(
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 15.0,
                        bottom: 12.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder:(context)=> sellProduct(productId: document.id,),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            height: 250.0,
                            margin: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 24.0,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height:350.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      "${document.data()['image'][0]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          document.data()['Name'] ?? 'Product Name',
                                          style: Constants.regularHeading,),
                                        Text(
                                          "\$${document.data()['Price']}" ?? 'Price',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w600
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );

                  }

                  //loding ScrollIncrementType.page
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

            ),

          ],
        ),
      ),
    );
  }
}

class sellProduct extends StatefulWidget {
  final String productId;
  sellProduct({this.productId});
  @override
  _sellProductState createState() => _sellProductState();
}

class _sellProductState extends State<sellProduct> {
  Firebaseservices _firebaseservices = Firebaseservices();


  User _user = FirebaseAuth.instance.currentUser;
  String _selectedproduct = "0";



  final SnackBar _snackBar = SnackBar(content: Text("Product added to the cart"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _firebaseservices.userID.doc(_firebaseservices.getuserId()).collection("sell").doc(widget.productId).get(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> documentData = snapshot.data.data();

                  //list of length
                  List imageList = documentData['image'];
                  List productquantity = documentData['Quantity'];
                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Imageswipe(imageList:imageList,),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,

                        ),
                        child: Text(
                          "\Name : ${documentData['Name']}"??"Product Name",
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "\$"
                              "${documentData['Price']}"??"Price",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "\Description:\n${documentData['Description']}"??"Description",
                          style: TextStyle(
                            fontSize: 16.0,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "Quality : 1",
                          style: Constants.regularHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,

                        ),
                        child: Text(
                          "\Category : ${documentData['category']}"??"Product Name",
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "Quantity",
                          style: Constants.regularHeading,
                        ),
                      ),
                      quantity(
                        productquantity: productquantity,

                      ),


                    ],
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
          ),
          customactionBar(
            hascart: false,
            hastitle: false,
            hasBackground: false,
            hasBackArrow:true,
          ),

        ],
      ),
    );
  }
}


