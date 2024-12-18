import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/shared/services/location_service.dart';

final locationStatusProvider = StateProvider<LocationStatus>((ref) => LocationStatus.error);

final locationErrorMessageProvider = Provider<String>((ref) {
  final status = ref.watch(locationStatusProvider);
  return LocationService.getLocationErrorMessage(status);
}); 