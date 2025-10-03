import 'package:flutter/material.dart';
import '../config/theme/style.dart';
import '../config/routes/app_route.dart';

void showSnackBar({
  required String? message,
  Color? backgroundColor,
  Color? iconColor,
  Duration duration = const Duration(seconds: 2),
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double borderRadius = 16,
  TextAlign? textAlign
}) {
  final context = AppRoute.router.configuration.navigatorKey.currentContext;

  if (context == null) return;
  if (message == null || message.isEmpty) return;

  final scaffoldMessenger = ScaffoldMessenger.of(context);

  // Hide current SnackBar if any
  scaffoldMessenger.hideCurrentSnackBar();

  // Show new SnackBar
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: GestureDetector(
        onTap: () {
          scaffoldMessenger.hideCurrentSnackBar();
        },
        child: Text(
          message,
          textAlign: textAlign ?? TextAlign.center,
          style: robotoMedium.copyWith(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: -0.3,
              height: 1),
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.black,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
