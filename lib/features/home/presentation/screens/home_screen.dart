import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/core/theme/app_theme.dart';
import 'package:real_estate_app/features/home/presentation/providers/house_provider.dart';
import 'package:real_estate_app/features/home/presentation/widgets/house_card.dart';
import 'package:real_estate_app/features/home/presentation/widgets/search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final housesState = ref.watch(filteredHousesProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: CustomPadding.screen,
          child: Row(
            children: [
              Text(
                'DTT REAL ESTATE',
                style: AppTypography.title01,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const CustomSearchBar(),
          Expanded(
            child: housesState.when(
              data: (houses) {
                if (houses.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: CustomPadding.screen,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/not_found.png',
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No results found!\nPerhaps try another search?',
                            textAlign: TextAlign.center,
                            style: AppTypography.body.copyWith(
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: CustomPadding.screen,
                  itemCount: houses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: CustomPadding.onlyBottom,
                      child: HouseCard(house: houses[index]),
                    );
                  },
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
                ),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: CustomPadding.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_error.svg',
                        width: 48,
                        height: 48,
                        colorFilter: ColorFilter.mode(
                          AppColors.orange,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load houses',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => ref.refresh(housesProvider),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.orange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'Try Again',
                          style: AppTypography.body.copyWith(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 