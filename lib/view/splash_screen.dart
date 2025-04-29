import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import '../utils/api_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  static const routeName = "/splashScreen";
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController controller = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(bottom: 52),
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/app_logos/splash_logo.svg",
                    height: 80,
                  ),
                ),
              ),
              Obx(
                () {
                  if (controller.state.value == States.loading) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      width: 150,
                      child: const LinearProgressIndicator(),
                    );
                  } else if (controller.state.value == States.data) {
                    return const SizedBox.shrink();
                  } else {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: controller.onTapRefresh,
                        child: const Text("try again"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
