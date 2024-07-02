import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key,
    required this.onPressed,
    required this.fullName,
    required this.email,
    required this.profilePicture,
  });

  final VoidCallback onPressed;
  final String fullName;
  final String email;
  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TCircularImage(
        image: profilePicture,
        width: 60,
        height: 60,
        padding: 0,
        isNetworkImage: true,
      ),
      title: Text(fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white)),
      subtitle: Text(email,
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
