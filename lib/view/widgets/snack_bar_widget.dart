import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static bool isOpen = false;

  static void showSnackBar({
    required String message,
    IconData icon = Icons.warning_amber_rounded,
    double? offsetY,
    BuildContext? context,
  }) async {
    isOpen = true;

    ScaffoldMessenger.of(context ?? Get.context!)
      ..removeCurrentSnackBar()
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide.none,
          ),
          backgroundColor: Theme.of(Get.context!).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 19),
          elevation: 0,
          content: Row(
            children: [
              Icon(
                icon,
                color: Colors.white.withOpacity(.85),
                size: 25,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  message.tr,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).closed.then((_) => isOpen = false);
  }
}
