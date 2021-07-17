import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/BuyNow.dart';
import 'package:project/Custom_Action_bar.dart';
import 'package:project/imageswipe.dart';
import 'package:badges/badges.dart';
import 'package:project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Quantity.dart';
import 'package:project/firebaseservices.dart';
import 'constants.dart';
import 'package:project/productcard.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'firebaseservices.dart';

class pulsePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userID = FirebaseFirestore.instance.collection(
      "users");
  final User _user = FirebaseAuth.instance.currentUser;
  final CollectionReference _productRef = FirebaseFirestore.instance.collection("Pulses");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text("Pulses Product",style:Constants.boldHeading)),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {

                }),
            Container(
              width: 42.0,
              height: 42.0,
              alignment: Alignment.center,

              child: StreamBuilder(
                stream: _userID.doc(_user.uid).collection("cart").snapshots(),
                builder: (context, snapshot) {
                  int _totalitem = 0;
                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data.docs;
                    _totalitem = _documents.length;
                  }

                  return Badge(

                    position: BadgePosition.topEnd(top: 0, end: 3),
                    animationType: BadgeAnimationType.slide,
                    badgeColor: Colors.red,
                    badgeContent: Text("$_totalitem" ?? "0",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: (){

                      },
                    ),

                  );

                },
              ),
            ),
          ]
      ),

      body: Container(
        child: Stack(
          children: [
            FutureBuilder <QuerySnapshot>(
                future: _productRef.get(),
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
                              builder:(context)=> pulsesProduct(productId: document.id,),
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

class pulsesProduct extends StatefulWidget {
  final String productId;
  pulsesProduct({this.productId});
  @override
  _pulsesProductState createState() => _pulsesProductState();
}

class _pulsesProductState extends State<pulsesProduct> {
  Firebaseservices _firebaseservices = Firebaseservices();


  User _user = FirebaseAuth.instance.currentUser;
  String _selectedproduct = "0";

  Future _addtocart(){
    return _firebaseservices.userID.doc(_user.uid).collection("cart").doc(widget.productId).collection('Pulses').doc().set(
        {
          "Quantity":_selectedproduct
        }
    );
  }



  final SnackBar _snackBar = SnackBar(content: Text("Product added to the cart"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("Pulses").doc(widget.productId).get(),
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
                        onSelected: (quantity){
                          _selectedproduct = quantity;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(

                              child: GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder:(context)=> BuyNow(),
                                  ));
                                },

                                child: Container(
                                  height:65.0,
                                  decoration:BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment:Alignment.center,
                                  child: Text("Buy",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(

                              child: GestureDetector(
                                onTap:()async {
                                  await _addtocart();
                                  Scaffold.of(context).showSnackBar(_snackBar);

                                },
                                child: Container(
                                  height:65.0,
                                  margin: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  decoration:BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Add to cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

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


