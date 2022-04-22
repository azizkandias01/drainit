import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  static final Completer<GoogleMapController> _googleMapsController =
      Completer();
  @override
  Widget build(BuildContext context) {
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(0.510440, 101.438309),
      zoom: 14.4746,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: GoogleMap(
        mapToolbarEnabled: false,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          if (!_googleMapsController.isCompleted) {
            _googleMapsController.complete(controller);
          } else {
            print('completer has created');
          }
        },
      ),
    );
  }
}
