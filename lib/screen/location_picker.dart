import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

const double klatitude = 45.40799448013583;
const double klongitude = 11.893889699335174;

class LocationPicker extends StatefulWidget {
  const LocationPicker(this.onChanged, {super.key});
  final ValueChanged<String> onChanged;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String address = "null";
  String autocompletePlace = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
          child: Center(
        child: MapLocationPicker(
            hideMapTypeButton: true,
            hideLocationButton: true,
            topCardColor: Colors.lightBlue[200]!.withOpacity(0.9),
            bottomCardColor: Theme.of(context).primaryColor.withOpacity(0.9),
            language: "it",
            region: "it",
            //types: ['address'],
            searchHintText: "Cerca il tuo indirizzo",
            apiKey: "AIzaSyAwhBXaYPS_FdtoUkkA-BNVq8nlmpdJP0Q",
            popOnNextButtonTaped: true,
            bottomCardIcon: const Icon(
              Icons.send,
              color: Colors.black,
            ),
            currentLatLng: const LatLng(klatitude, klongitude),
            onNext: (GeocodingResult? result) {
              if (result != null) {
                setState(() {
                  address = result.formattedAddress ?? "";
                  widget.onChanged(address);
                  //saveUserInfos(address: address, phone: "1234");
                });
              }
            },
            hideMoreOptions: true,
            onSuggestionSelected: (PlacesDetailsResponse? result) {
              if (result != null) {
                setState(() {
                  autocompletePlace = result.result.formattedAddress ?? "";
                });
              }
            }),
      )),
    );
  }
}
