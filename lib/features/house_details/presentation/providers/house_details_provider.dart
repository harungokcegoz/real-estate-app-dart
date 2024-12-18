import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/home/presentation/providers/house_provider.dart';
import 'package:real_estate_app/shared/models/house.dart';

final selectedHouseProvider = Provider.family<AsyncValue<House>, int>((ref, id) {
  final housesState = ref.watch(housesProvider);
  
  return housesState.when(
    data: (houses) {
      try {
        final house = houses.firstWhere(
          (house) => house.id == id,
        );
        return AsyncValue.data(house);
      } catch (e) {
        return AsyncValue.error(
          'House with ID $id not found',
          StackTrace.current,
        );
      }
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
}); 