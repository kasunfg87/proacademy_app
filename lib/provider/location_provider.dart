import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker_flutter/google_map_location_picker_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../components/widgets/utilities/app_colors.dart';

class LocationProvider extends ChangeNotifier {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  //---- store position details
  Position? _position;

  //----- get position details

  Position? get position => _position;

  //---- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----chage loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //----- get user coordinates

  Future<void> getUserCoordinates() async {
    try {
      setLoading(true);
      _position = await _determinePosition();
      notifyListeners();
      Logger().e(_position);
      setLoading(false);
    } catch (e) {
      Logger().e(e);
      setLoading(false);
    }
  }

  Future<void> pickUserAddress(BuildContext context) async {
    AddressResult result = await showGoogleMapLocationPicker(
      pinWidget: const Icon(
        Icons.location_pin,
        color: Colors.red,
        size: 55,
      ),
      pinColor: Colors.blue,
      context: context,
      addressPlaceHolder: 'Move the map',
      addressTitle: 'Selected Address',
      apiKey: "AIzaSyCCyQcvTgbR653d19S5QZoq0SrThwc5FYw",
      appBarTitle: "Pick Your Current Location",
      confirmButtonColor: AppColors.kPrimary,
      confirmButtonText: 'Pick Address',
      confirmButtonTextColor: Colors.white,
      country: "LK",
      language: "en",
      searchHint: 'Search..',
      initialLocation: LatLng(position!.latitude, position!.longitude),
    );
    // ignore: unnecessary_null_comparison
    if (result != null) {
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).addressController.text =
          result.address;
      Logger().e(result.address);
    }
  }
}
