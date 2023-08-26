import 'package:flutter/material.dart';

import '../../../components/my_global_elevatedbutton_widget.dart';
import '../../../theme/utils/my_colors.dart';
import '../../../theme/utils/my_strings.dart';
import '../sign_in/controllers/sign_in_controller.dart';

class SignInWithOtherWidget extends StatelessWidget {
  const SignInWithOtherWidget({
    super.key,
    required this.controller,
  });

  final SignInController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: MyGlobalElevatedButtonWidget(
            side: const BorderSide(),
            backgroundColor: Colors.white,
            onPressed: () {
              controller.handleGoogleSignIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(),
                const SizedBox(width: 12),
                Text(
                  'Flutter',
                  style: MyText.defaultStyle(color: MyColors.darkPrimary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        Flexible(
          child: MyGlobalElevatedButtonWidget(
            side: const BorderSide(),
            backgroundColor: Colors.white,
            onPressed: () {
              controller.handleGoogleSignIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.apple, color: MyColors.darkPrimary),
                const SizedBox(width: 12),
                Text(
                  'Apple',
                  style: MyText.defaultStyle(color: MyColors.darkPrimary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
