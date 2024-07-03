import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';


class ChangeAddress extends StatelessWidget {
  const ChangeAddress({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(UpdateNameController());
    return Scaffold(
      // Custom Appbar
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Địa chỉ', style: Theme.of(context).textTheme.headlineSmall),
      ),
      // AppBar
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'Địa chỉ là vô cũng cần thiết để đơn hàng được giao đến tay bạn',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            // Text
            const SizedBox(height: TSizes.spaceBtwSections),

            // Text field and Button
            Form(
              // key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    // controller: controller.firstName,
                    validator: (value) => TValidator.validateEmptyText('Địa chỉ', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: TTexts.address, prefixIcon: Icon(Iconsax.home)),
                  ),
                  // TextFormField
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              // child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save')),
              child: ElevatedButton(onPressed: () => {}, child: const Text('Lưu')),
            ),
            // SizedBox
          ],
        ),
      ),
    );
  }
}
