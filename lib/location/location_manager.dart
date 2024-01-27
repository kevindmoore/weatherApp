import 'package:geocoder_plus/geocoder_plus.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:location_geocoder/location_geocoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Use a package to grant permissions and get the current location
/// Also has the ability to get the address from the location
/// NOTE: You will need a .env file at the root of your project with the
/// mapsAPIKey variable set to your Google Maps API key
class LocationManager {
  late GoogleGeocoding googleService;

  LocationManager() {
    googleService = GoogleGeocoding(
      dotenv.env['mapsAPIKey']!,
      language: 'en',
    );
  }

  Future<bool> isLocationEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> hasPermission() async {
    var permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted != LocationPermission.denied) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<Position> getLocation() async {
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }

  Future<List<Address>> getAddressFromLocation(Coordinates coordinates) async {
    return googleService.findAddressesFromCoordinates(coordinates);
  }

  Future<List<Address>> getLocationFromAddress(String address) async {
    return googleService.findAddressesFromQuery(address);
  }
}
