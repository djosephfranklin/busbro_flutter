import 'package:flutter/material.dart';
import 'package:busbro_flutter/screens/bus_stop_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BusBro'),
      ),
      body: ListView.builder(
        itemCount: 10, // Mock data for now
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Bus Stop ${index + 1}'), // Mock data for now
            subtitle: Text('Distance: 1.2 km, Timings: 08:00, 09:00, 10:00'), // Mock data for now
            trailing: Icon(Icons.directions),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusStopDetailsScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
