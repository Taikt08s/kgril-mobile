import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OrderStatusStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isLast;
  final bool isActive;
  final bool showBottomSpace;

  const OrderStatusStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isLast = false,
    this.isActive = false,
    this.showBottomSpace=true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final color =
        isActive ? iconColor : (dark ? TColors.darkerGrey : Colors.black26);
    final subtextColor = isActive
        ? (dark ? TColors.white : TColors.primary)
        : (dark ? TColors.darkerGrey : Colors.black54);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: color, size: 30),
            if (!isLast) Container(width: 2.5, height: 40, color: color),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(subtitle,
                  style: TextStyle(color: subtextColor, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}
