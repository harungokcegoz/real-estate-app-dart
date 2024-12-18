import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/core/theme/app_theme.dart';

class ShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScreen({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [AppShadows.navigation],
        ),
        child: NavigationBar(
          height: 50,
          backgroundColor: AppColors.white,
          indicatorColor: Colors.transparent,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  AppColors.textMedium,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  AppColors.orange,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                'assets/icons/ic_info.svg',
                colorFilter: ColorFilter.mode(
                  AppColors.textMedium,
                  BlendMode.srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/ic_info.svg',
                colorFilter: ColorFilter.mode(
                  AppColors.orange,
                  BlendMode.srcIn,
                ),
              ),
              label: 'About',
            ),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
      ),
    );
  }
} 