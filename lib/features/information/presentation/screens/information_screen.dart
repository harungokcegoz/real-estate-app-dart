import 'package:flutter/material.dart';
import 'package:real_estate_app/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(   
        backgroundColor: AppColors.white,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                'ABOUT',
                style: AppTypography.title01,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: CustomPadding.screen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum. '
              'Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus. '
              'Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Curabitur aliquet quam id dui posuere blandit. '
              'Sed porttitor lectus nibh. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; '
              'Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. '
              'Pellentesque in ipsum id orci porta dapibus. Nulla porttitor accumsan tincidunt. '
              'Cras ultricies ligula sed magna dictum porta. Quisque velit nisi, pretium ut lacinia in, elementum id enim. '
              'Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Sed porttitor lectus nibh.',
              style: AppTypography.body.copyWith(
                color: AppColors.textMedium,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Design and Development',
              style: AppTypography.title02,
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Image.asset(
                  'assets/images/dtt_banner.png',
                  width: 150,
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'by DTT',
                        style: AppTypography.title03,
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse('https://d-tt.nl'));
                        },
                        child: Text(
                          'd-tt.nl',
                          style: AppTypography.body.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 