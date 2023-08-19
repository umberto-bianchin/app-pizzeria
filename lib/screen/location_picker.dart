import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../data/data_item.dart';

const double klatitude = 45.406435;
const double klongitude = 11.876761;

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
        backgroundColor: kprimaryColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
          child: Center(
        child: MapLocationPicker(
            hideMapTypeButton: true,
            language: "it",
            searchHintText: "Cerca il tuo indirizzo",
            apiKey: "AIzaSyAwhBXaYPS_FdtoUkkA-BNVq8nlmpdJP0Q",
            popOnNextButtonTaped: true,
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
