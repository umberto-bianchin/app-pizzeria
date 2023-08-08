import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double klatitude = 45.406435;
const double klongitude = 11.876761;

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(klatitude, klongitude);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Marker> _markers = [
    const Marker(
      markerId: MarkerId("Pizzeria"),
      position: LatLng(klatitude, klongitude),
      infoWindow: InfoWindow(
        title: "Pizzeria",
        snippet: "Via Pizzeria",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 300,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _markers.toSet(),
          onTap: (argument) {},
        ),
      ),
    );
  }
}
