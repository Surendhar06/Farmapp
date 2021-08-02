import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'farmerdata.dart';


class DisplayMap extends StatelessWidget {
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

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(FarmersData.latLong.latitude, FarmersData.latLong.longitude),
  );

  var marker = <Marker>{};

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      marker
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  void initState() {
    addMarker(FarmersData.latLong);
    print(FarmersData.latLong);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            markers: marker.toSet(),
            onTap: (cordinate) {
              _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
            },
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}