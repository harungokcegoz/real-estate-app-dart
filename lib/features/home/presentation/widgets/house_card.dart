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
      onTap: () => context.go('/house/${house.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [AppShadows.general],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
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
            Padding(
              padding: CustomPadding.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '€${_priceFormatter.format(house.price)}',
                    style: AppTypography.title02,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${house.zip} ${house.city}',
                    style: AppTypography.body.copyWith(color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _InfoItem(
                        iconPath: 'assets/icons/ic_bed.svg',
                        value: house.bedrooms.toString(),
                      ),
                      const SizedBox(width: 16),
                      _InfoItem(
                        iconPath: 'assets/icons/ic_bath.svg',
                        value: house.bathrooms.toString(),
                      ),
                      const SizedBox(width: 16),
                      _InfoItem(
                        iconPath: 'assets/icons/ic_home.svg',
                        value: '${house.size}m²',
                      ),
                    ],
                  ),
                ],
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
        const SizedBox(width: 4),
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