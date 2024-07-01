import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImages.grillIcon,
        width: 60,
        height: 60,
        padding: 0,
      ),
      title: Text('Taikt08s',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white)),
      subtitle: Text('styematic@gmail.com',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white)),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Iconsax.edit),
        color: TColors.white,
        iconSize: 25,
      ),
    );
  }
}
