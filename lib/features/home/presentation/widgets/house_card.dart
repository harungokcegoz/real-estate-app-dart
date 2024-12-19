import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/core/theme/app_theme.dart';
import 'package:real_estate_app/shared/models/house.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class HouseCard extends StatelessWidget {
  final House house;
  final _priceFormatter = NumberFormat('#,###', 'en_US');

  HouseCard({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/house/${house.id}'),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [AppShadows.general],
        ),
        child: Row(
          children: [
            // Image section
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
              child: SizedBox(
                width: 120,
                height: 120,
                child: CachedNetworkImage(
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
            // Content section
            Expanded(
              child: Padding(
                padding: CustomPadding.all,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price and Address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '€${_priceFormatter.format(house.price)}',
                          style: AppTypography.title03,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${house.zip} ${house.city}',
                          style: AppTypography.body.copyWith(
                            color: AppColors.textMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    // Info row
                    Row(
                      children: [
                        _InfoItem(
                          iconPath: 'assets/icons/ic_bed.svg',
                          value: house.bedrooms.toString(),
                        ),
                        const SizedBox(width: 10),
                        _InfoItem(
                          iconPath: 'assets/icons/ic_bath.svg',
                          value: house.bathrooms.toString(),
                        ),
                        const SizedBox(width: 10),
                        _InfoItem(
                          iconPath: 'assets/icons/ic_layers.svg',
                          value: '${house.size}m²',
                        ),
                        if (house.distance != null) ...[
                          const SizedBox(width: 10),
                          _InfoItem(
                            iconPath: 'assets/icons/ic_location.svg',
                            value: '${house.distance!.toStringAsFixed(1)}km',
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            AppColors.textMedium,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          value,
          style: AppTypography.detail.copyWith(
            color: AppColors.textMedium,
          ),
        ),
      ],
    );
  }
} 