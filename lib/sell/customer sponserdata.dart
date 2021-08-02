import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Custom_Action_bar.dart';
import 'package:project/constants.dart';


import 'display map.dart';

class viewloan extends StatefulWidget {
  @override
  _viewloanState createState() => _viewloanState();
}
class _viewloanState extends State<viewloan> {
  final CollectionReference _productRef = FirebaseFirestore.instance.collection("loan");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text('Sponser',
            textAlign: TextAlign.center,
            style: Constants.boldHeading,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),

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
                              builder:(context)=> Loanview(productId: document.id,),
                            ));
                          },
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,horizontal: 24.0
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    child: Image.network(
                                      "${document.data()['image']}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${document.data()['Name']}" ??'Name',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                          vertical: 4.0,
                                        ),
                                        child: Text(
                                         " Loan Amount: ${document.data()['Amount']}" ??"Price",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Theme.of(context)
                                                  .accentColor,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "Location - ${document.data()['location']}",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
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





class Loanview extends StatefulWidget {
  final String productId;
  Loanview({this.productId});
  @override
  _LoanviewState createState() => _LoanviewState();
}

class _LoanviewState extends State<Loanview> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("loan").doc(widget.productId).get(),
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



                  return SingleChildScrollView(
                  child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                  children: <Widget>[
                  Container(
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green, Colors.greenAccent])),
                  child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(20.0),
                        child: Image.network(
                          "${documentData['image']}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                SizedBox(
                height: 10.0,
                ),
                Text(
                  "\Name : ${documentData['Name']}"??"Product Name",
                style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                ),
                ),
                SizedBox(
                height: 10.0,
                ),
                Card(
                margin: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 5.0),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                elevation: 5.0,
                child: Padding(
                padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 22.0),
                child: Row(
                children: <Widget>[
                Expanded(
                child: Column(
                children: <Widget>[
                Text(
                "AGE",
                style: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(
                height: 5.0,
                ),
                Text(
                  "${documentData['age']}",
                style: TextStyle(
                fontSize: 20.0,
                color: Colors.pinkAccent,
                ),
                )
                ],
                ),
                ),
                Expanded(
                child: Column(
                children: <Widget>[
                Text(
                "EXPERIENCE",
                style: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(
                height: 5.0,
                ),
                Text(
                  "${documentData['exp']}",
                style: TextStyle(
                fontSize: 20.0,
                color: Colors.pinkAccent,
                ),
                )
                ],
                ),
                ),
                Expanded(
                child: Column(
                children: <Widget>[
                Text(
                "ACRES",
                style: TextStyle(
                color: Colors.black,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(
                height: 5.0,
                ),
                Text(
                  "${documentData['acres']}",
                style: TextStyle(
                fontSize: 20.0,
                color: Colors.pinkAccent,
                ),
                )
                ],
                ),
                ),
                ],
                ),
                ),
                )
                ],
                ),
                ),
                )),
                Container(
                // height: 100.0,
                child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                Text(
                "Things Required",
                style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontSize: 28.0),
                ),
                SizedBox(
                height: 10.0,
                ),
                Text(
                "${documentData['things']}",
                style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                letterSpacing: 2.0,
                ),
                ),
                SizedBox(
                child: Divider(color: Colors.black54),
                height: 10.0,
                ),
                Text(
                "No.Of days",
                style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontSize: 28.0),
                ),
                SizedBox(
                height: 10.0,
                ),
                Text(
                "${documentData['hperiod']}",
                style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                letterSpacing: 2.0,
                ),
                ),
                SizedBox(
                child: Divider(color: Colors.black54),
                height: 10.0,
                ),
                Text(
                "Money needed",
                style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontSize: 28.0),
                ),
                SizedBox(
                height: 10.0,
                ),
                Text(
                "${documentData['Amount']}",
                style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                letterSpacing: 2.0,
                ),
                ),
                SizedBox(
                child: Divider(color: Colors.black54),
                height: 10.0,
                ),
                Text(
                "Location",
                style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontSize: 28.0),
                ),
                Container(
                height: 400.0,
                width: 400.0,
                child: DisplayMap(),
                )
                ],
                ),
                ),
                ),
                SizedBox(
                height: 20.0,
                ),
                ],
                ),
                ),

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


