import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/shared/models/house.dart';
import 'package:real_estate_app/shared/repositories/house_repository.dart';

final selectedHouseProvider = FutureProvider.family<House, int>((ref, id) async {
  final repository = ref.read(houseRepositoryProvider);
  return repository.getHouseById(id);
}); 