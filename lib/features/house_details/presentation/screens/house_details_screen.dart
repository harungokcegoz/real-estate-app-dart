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
              expandedHeight: 250,
              pinned: true,
              backgroundColor: AppColors.white,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [AppShadows.general],
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/ic_back.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors.orange,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                onPressed: () => context.pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
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
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: CustomPadding.screen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Price and Location
                    Row(
                      children: [
                        Text(
                          '€${_priceFormatter.format(house.price)}',
                          style: AppTypography.title01,
                        ),
                        const Spacer(),
                        if (house.distance != null)
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_location.svg',
                                colorFilter: ColorFilter.mode(
                                  AppColors.textMedium,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${house.distance!.toStringAsFixed(1)}km',
                                style: AppTypography.body.copyWith(
                                  color: AppColors.textMedium,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${house.zip} ${house.city}',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Info Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _InfoItem(
                          iconPath: 'assets/icons/ic_bed.svg',
                          value: house.bedrooms.toString(),
                          label: 'Bedrooms',
                        ),
                        _InfoItem(
                          iconPath: 'assets/icons/ic_bath.svg',
                          value: house.bathrooms.toString(),
                          label: 'Bathrooms',
                        ),
                        _InfoItem(
                          iconPath: 'assets/icons/ic_layers.svg',
                          value: '${house.size}m²',
                          label: 'Size',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Description
                    Text(
                      'Description',
                      style: AppTypography.title02,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      house.description,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Location
                    Text(
                      'Location',
                      style: AppTypography.title02,
                    ),
                    const SizedBox(height: 8),
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
  final String label;

  const _InfoItem({
    required this.iconPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
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
              const SizedBox(width: 8),
              Text(
                value,
                style: AppTypography.body.copyWith(
                  color: AppColors.textStrong,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.detail.copyWith(
            color: AppColors.textMedium,
          ),
        ),
      ],
    );
  }
} 