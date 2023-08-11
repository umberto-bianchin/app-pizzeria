import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

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

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
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
    final initialCameraPosition = CameraPosition(
      target: _center,
      zoom: 17.0,
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              },
              zoomControlsEnabled: false,
              mapToolbarEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: initialCameraPosition,
              markers: _markers.toSet(),
            ),
          ),
        ),
      ),
    );
  }
}
