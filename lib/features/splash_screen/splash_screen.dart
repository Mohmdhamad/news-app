import 'package:flutter/material.dart';

import '../../../core/utilites/constants/app_assets.dart';
import '../../core/utilites/styles/app_colors.dart';
import '../home_screen/presentation/view/screens/home_screen.dart';

class Splash extends StatefulWidget {
  static const String routeName = "splash";

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              AppAssets.background),
        ),
        Center(
          child: Image.asset(AppAssets.splashLogo),
        ),
      ],
    );
  }
}
