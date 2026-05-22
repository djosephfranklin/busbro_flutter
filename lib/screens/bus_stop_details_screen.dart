import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Stop Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {},
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Mock data for now
                zoom: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Bus Stop Name: Bus Stop 1'), // Mock data for now
                Text('Address: 123 Main St, Anytown, USA'), // Mock data for now
                Text('Timings: 08:00, 09:00, 10:00'), // Mock data for now
              ],
            ),
          ),
        ],
      ),
    );
  }
}
