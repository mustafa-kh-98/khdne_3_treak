import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_constants.dart';
import '../core/utils/app_shadow.dart';

class BackButtonWidget extends StatelessWidget {
  final void Function() onTap;

  const BackButtonWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Hero(
        tag: AppConstants.BACK_HERO,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white,

                  shape: BoxShape.circle,
                  boxShadow: [
                    AppShadow.homeShadow,
                  ]),
              child: UnconstrainedBox(
                child: SvgPicture.asset(
                  AppAssets.ARROW_BACK_ICON,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
