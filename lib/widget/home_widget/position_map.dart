import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const double klatitude = 45.406435;
const double klongitude = 11.876761;

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/images/google_map.png"),
                ),
                SizedBox(height: 5),
                Text(
                  "Clicca per aprire la mappa",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _launchGoogleMaps(const LatLng(klatitude, klongitude));
        },
      ),
    );
  }

  void _launchGoogleMaps(LatLng location) async {
    String appleUrl =
        'https://maps.apple.com/?saddr=&daddr=${location.latitude},${location.longitude}&directionsmode=driving';
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';

    Uri appleUri = Uri.parse(appleUrl);
    Uri googleUri = Uri.parse(googleUrl);

    if (await canLaunchUrl(appleUri)) {
      await launchUrl(appleUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri, mode: LaunchMode.externalApplication);
    }
  }
}
