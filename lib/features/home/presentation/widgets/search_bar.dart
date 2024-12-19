import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/core/theme/app_theme.dart';
import 'package:real_estate_app/features/home/presentation/providers/house_provider.dart';

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: CustomPadding.screen,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.darkGray,
            width: 1,
          ),
        ),
      ),
      child: TextField(
        onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
        style: AppTypography.input.copyWith(
          color: AppColors.textStrong,
        ),
        decoration: InputDecoration(
          hintText: 'Search for a home',
          hintStyle: AppTypography.hint.copyWith(
            color: AppColors.textLight,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/ic_search.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                AppColors.textMedium,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          filled: true,
          fillColor: AppColors.lightGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
} 