import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/RoundedButton.dart';
import 'package:project/sell/farmerdata.dart';
import 'package:project/sell/sellhome.dart';


class GMap extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController _controller;

  final CameraPosition _initialPosition =
  CameraPosition(target: LatLng(24.903623, 67.198367));

  var marker = <Marker>{};

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      marker
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 700.0,
            width: 500.0,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: _initialPosition,
                mapType: MapType.hybrid,
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                markers: marker,
                onTap: (cordinate) {
                  marker.clear();
                  _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
                  addMarker(cordinate);
                  FarmersData.latLong = cordinate;
                  print(cordinate);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RoundedButtons(
                title: "Submit",
                textcolour: Colors.white,
                colour: Colors.redAccent,
                onpressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder:(context)=> SellHome(),
                  ));
                }),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}