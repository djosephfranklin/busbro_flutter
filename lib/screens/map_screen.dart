import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {},
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Mock data for now
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('bus_stop_1'),
            position: LatLng(37.7749, -122.4194), // Mock data for now
            icon: BitmapDescriptor.defaultMarker,
          ),
          Marker(
            markerId: MarkerId('bus_stop_2'),
            position: LatLng(37.7859, -122.4364), // Mock data for now
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }
}
