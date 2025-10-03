import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/color/app_colors.dart';
import '../../../config/theme/style.dart';

class CustomTextField extends StatefulWidget {
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool borderEnable;
  final String? hintText;
  final bool obscure;
  final bool isPassword;
  final bool? enabled;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function()? onObscureTap;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final int maxLines;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? filledColor;
  final Color? hintColor;
  final Color? labelColor;
  final double borderRadius;

  const CustomTextField({
    super.key,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.borderEnable = false,
    this.isPassword = false,
    this.hintText,
    this.obscure = false,
    this.enabled,
    this.keyboardType,
    this.onObscureTap,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.style,
    this.inputFormatters,
    this.contentPadding,
    this.readOnly = false,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.labelStyle,
    this.textInputAction,
    this.filledColor,
    this.hintColor,
    this.labelColor,
    this.onTap,
    this.borderRadius = 8.0,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = true;

  void toggleObscure() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///-------------------------label
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.label!,
              style:
                  widget.labelStyle ??
                  interMedium.copyWith(
                    color:
                        widget.labelColor ??
                        (widget.enabled == false
                            ? AppColors.grey400
                            : AppColors.grey700),
                    fontSize: 13,
                  ),
            ),
          ),

        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          obscureText: widget.isPassword ? obscureText : widget.obscure,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            fillColor:
                widget.filledColor ??
                AppColors.whiteColor.withValues(alpha: 0.2),
            filled: true,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.fromLTRB(16, 8, 16, 8),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: toggleObscure,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        color: AppColors.grey200,
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        size: 24,
                      ),
                    ),
                  )
                : widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: interRegular.copyWith(
              color: widget.hintColor ?? AppColors.grey400,
              fontSize: 12,
              letterSpacing: 0,
            ),
            prefixIcon: widget.prefixIcon,
            border:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: !widget.borderEnable
                      ? BorderSide.none
                      : BorderSide(color: AppColors.primarySlate200, width: 1),
                  gapPadding: 0,
                ),
            focusedBorder:
                widget.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: !widget.borderEnable
                      ? BorderSide.none
                      : BorderSide(color: AppColors.primarySlate200, width: 1),
                  gapPadding: 0,
                ),
            enabledBorder:
                widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: !widget.borderEnable
                      ? BorderSide.none
                      : BorderSide(color: AppColors.primarySlate200, width: 1),
                  gapPadding: 0,
                ),
          ),
          style:
              widget.style ??
              interRegular.copyWith(fontSize: 15, color: Colors.black),
          cursorColor: AppColors.primaryColor,
          cursorWidth: 1,
        ),
      ],
    );
  }
}
