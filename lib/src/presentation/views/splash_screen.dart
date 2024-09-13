import '../../util/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppProvider>().fetchData().then((routesName) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        routesName,
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Lottie.asset(
            Constants.splashAsset,
            width: 240,
            height: 240,
          ),
        ),
      ),
    );
  }
}
