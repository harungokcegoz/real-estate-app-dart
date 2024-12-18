import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/shared/models/house.dart';
import 'package:real_estate_app/shared/repositories/house_repository.dart';

final houseRepositoryProvider = Provider<HouseRepository>((ref) {
  return HouseRepository();
});

final housesProvider = FutureProvider<List<House>>((ref) async {
  final repository = ref.read(houseRepositoryProvider);
  return repository.getHouses();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredHousesProvider = Provider<AsyncValue<List<House>>>((ref) {
  final houses = ref.watch(housesProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return houses.when(
    data: (houseList) {
      if (searchQuery.isEmpty) return AsyncValue.data(houseList);
      
      final filtered = houseList.where((house) {
        return house.city.toLowerCase().contains(searchQuery) ||
               house.zip.toLowerCase().contains(searchQuery);
      }).toList();
      
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
}); 