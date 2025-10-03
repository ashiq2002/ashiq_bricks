import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../config/color/app_colors.dart';
import '../../../config/theme/style.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final void Function()? onTap;
  final T? value;
  final Color borderColor;
  final Color? dropdownColor;
  final double borderRadius;
  final Widget? icon;
  final String? hintText;
  final String? label;
  final String? labelText;
  final bool readOnly;
  final bool enableIconBorder;
  final int elevation;
  final bool isExpanded;
  final bool? isDense;
  final bool enableBorder;
  final Color? fillColor;
  final Color? hintColor;
  final bool filled;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const CustomDropdown({
    super.key,
    this.items,
    this.elevation = 8,
    this.onChanged,
    this.value,
    this.borderColor = AppColors.primarySlate300,
    this.borderRadius = 6,
    this.icon,
    this.hintText,
    this.label,
    this.readOnly = false,
    this.enableIconBorder = false,
    this.labelText,
    this.onTap,
    this.dropdownColor,
    this.isDense,
    this.isExpanded = true, // ✅ default true
    this.contentPadding,
    this.selectedItemBuilder,
    this.enableBorder = true,
    this.fillColor,
    this.filled = true, this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    // Helper to extract plain text from item.child
    String _labelOf(Widget w) {
      if (w is Text) {
        if (w.data != null) return w.data!;
        final span = w.textSpan;
        if (span != null) return span.toPlainText();
      }
      return w.toStringShort();
    }

    final hasItems = !readOnly && (items?.isNotEmpty ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: interMedium.copyWith(
              fontSize: 13,
              color: readOnly ? AppColors.grey400 : AppColors.grey700,
              letterSpacing: -0.2,
            ),
          ),
        if (label != null) const Gap(8),
        GestureDetector(
          onTap: onTap,
          child: DropdownButtonFormField<T>(
            isExpanded: isExpanded, // ✅ critical for ellipsis
            padding: EdgeInsets.zero,
            elevation: elevation,
            dropdownColor: dropdownColor,
            hint: hintText == null
                ? null
                : Text(
              hintText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: interRegular.copyWith(
                color: hintColor ?? AppColors.primarySlate400,
                fontSize: 14,
              ),
            ),

            // ✅ Only provide builder when we actually have items
            selectedItemBuilder: hasItems
                ? (context) => items!.map((item) {
              final text = _labelOf(item.child);
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // 👈 works now
                  style: interRegular.copyWith(
                    color: AppColors.grey700,
                    fontSize: 13,
                    letterSpacing: -0.3,
                  ),
                ),
              );
            }).toList()
                : null,

            icon: icon ??
                Container(
                  height: 22,
                  width: 0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    border: !enableIconBorder
                        ? null
                        : Border(
                      left: BorderSide(
                        width: 1,
                        color: AppColors.primarySlate200,
                      ),
                    ),
                  ),
                  child: Assets.icons.icArrowDown.svg(),
                ),

            decoration: InputDecoration(
              isDense: isDense,
              // ❌ don’t tie isCollapsed to isExpanded; it can break layout
              fillColor: fillColor,
              filled: filled,
              label: labelText != null
                  ? Text(
                labelText!,
                style: interMedium.copyWith(
                  color: readOnly
                      ? AppColors.primarySlate400
                      : const Color(0xff333333),
                  letterSpacing: -0.2,
                  fontSize: 14,
                ),
              )
                  : null,
              contentPadding:
              contentPadding ?? const EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
                borderSide: !enableBorder
                    ? BorderSide.none
                    : BorderSide(
                  color: readOnly
                      ? AppColors.primarySlate200
                      : borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
                borderSide: !enableBorder
                    ? BorderSide.none
                    : BorderSide(
                  color: readOnly
                      ? AppColors.primarySlate200
                      : borderColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
                borderSide: !enableBorder
                    ? BorderSide.none
                    : BorderSide(
                  color: readOnly
                      ? AppColors.primarySlate200
                      : borderColor,
                ),
              ),
            ),
            items: hasItems ? items : null,
            initialValue: readOnly ? null : value,
            onChanged: readOnly ? null : onChanged,
          ),
        ),
      ],
    );
  }
}
