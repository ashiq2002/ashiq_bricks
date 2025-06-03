import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';


import '../../config/color/app_colors.dart';
import '../../config/theme/style.dart';


class EmptyWidget extends StatelessWidget {
  final String? svgIconSrc;
  final String? message;

  const EmptyWidget({super.key, this.svgIconSrc, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svgIconSrc ?? 'assets/icons/ic_no_data_found.svg'),
          Gap(16),
          Text(
            message ?? 'Empty',
            style: interRegular.copyWith(
                color: AppColors.primarySlate300, fontSize: 16),
          )
        ],
      ),
    );
  }
}
