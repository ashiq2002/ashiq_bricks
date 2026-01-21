import 'package:flutter/material.dart';
import '../../../config/color/app_colors.dart';
import '../../../config/theme/style.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool value;
  final Function(bool?) onChanged;
  final Color? activeColor;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = activeColor ?? AppColors.primaryColor;
    final Color borderColor = AppColors.primarySlate300;
    final Color fillColor = value ? selectedColor : AppColors.primarySlate25;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: fillColor,
              border: value ? null : Border.all(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: value
                ? Icon(Icons.check, size: 15, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style:
                titleStyle ??
                robotoRegular.copyWith(
                  color: AppColors.primarySlate800,
                  fontSize: 12,
                  letterSpacing: -0.3,
                ),
          ),
        ],
      ),
    );
  }
}
