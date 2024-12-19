import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/core/theme/app_theme.dart';
import 'package:real_estate_app/features/house_details/presentation/providers/house_details_provider.dart';

class HouseDetailsScreen extends ConsumerWidget {
  final int houseId;
  final _priceFormatter = NumberFormat('#,###', 'en_US');

  HouseDetailsScreen({super.key, required this.houseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houseAsync = ref.watch(selectedHouseProvider(houseId));
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: houseAsync.when(
        data: (house) => CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: AppColors.white,
              leading: IconButton(
                icon:
                  SvgPicture.asset(
                    'assets/icons/ic_back.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                onPressed: () => context.pop(),
              ),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: 'https://intern.d-tt.nl${house.image}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.lightGray,
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.lightGray,
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                padding: CustomPadding.screen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price and Location
                    Row(
                      children: [
                        Text(
                          '€${_priceFormatter.format(house.price)}',
                          style: AppTypography.title01,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _InfoItem(
                              iconPath: 'assets/icons/ic_bed.svg',
                              value: house.bedrooms.toString(),
                            ),
                            _InfoItem(
                              iconPath: 'assets/icons/ic_bath.svg',
                              value: house.bathrooms.toString(),
                            ),
                            _InfoItem(
                              iconPath: 'assets/icons/ic_layers.svg',
                              value: '${house.size}m²',
                            ),
                            _InfoItem(
                              iconPath: 'assets/icons/ic_location.svg',
                              value: '${house.distance}km',
                            ),
                          ],
                        ),
                      ),
                      ],
                    ),

                    // Description
                    Text(
                      'Description',
                      style: AppTypography.title02,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      house.description,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Location
                    Text(
                      'Location',
                      style: AppTypography.title02,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [AppShadows.general],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(house.latitude, house.longitude),
                            zoom: 15,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId(house.id.toString()),
                              position: LatLng(house.latitude, house.longitude),
                            ),
                          },
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          myLocationButtonEnabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
          ),
        ),
        error: (error, stack) => Center(
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
                'Failed to load house details',
                style: AppTypography.body.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              TextButton(
                onPressed: () => ref.refresh(selectedHouseProvider(houseId)),
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
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String iconPath;
  final String value;

  const _InfoItem({
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.textMedium,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: AppTypography.body.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 