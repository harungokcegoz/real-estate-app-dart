import 'package:geolocator/geolocator.dart';
import 'package:real_estate_app/shared/models/house.dart';

enum LocationStatus {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  success,
  error
}

class LocationService {
  static Future<LocationStatus> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationStatus.serviceDisabled;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationStatus.permissionDenied;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return LocationStatus.permissionDeniedForever;
      }

      return LocationStatus.success;
    } catch (e) {
      print('Error checking location permission: $e');
      return LocationStatus.error;
    }
  }

  static Future<List<House>> calculateDistances(List<House> houses) async {
    try {
      final status = await checkLocationPermission();
      if (status != LocationStatus.success) {
        print('Location permission status: $status');
        return houses;
      }

      final Position position = await Geolocator.getCurrentPosition();

      return houses.map((house) {
        final distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          house.latitude,
          house.longitude,
        );
        
        final distanceInKm = double.parse((distance / 1000).toStringAsFixed(1));
    
        return house.copyWith(distance: distanceInKm);
      }).toList();
    } catch (e) {
      print('Error calculating distances: $e');
      return houses;
    }
  }

  static String getLocationErrorMessage(LocationStatus status) {
    switch (status) {
      case LocationStatus.serviceDisabled:
        return 'Location services are disabled. Please enable location services in your device settings.';
      case LocationStatus.permissionDenied:
        return 'Location permission denied. Please allow access to your location to see distances to properties.';
      case LocationStatus.permissionDeniedForever:
        return 'Location permission permanently denied. Please enable location access in your device settings.';
      case LocationStatus.error:
        return 'An error occurred while accessing location services.';
      default:
        return '';
    }
  }
} 