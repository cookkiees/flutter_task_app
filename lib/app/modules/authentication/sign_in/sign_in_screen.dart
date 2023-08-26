import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/helpers/task_loading.dart';

import '../../../components/my_global_elevatedbutton_widget.dart';
import '../../../components/my_global_textformfield_widget.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/utils/my_colors.dart';
import '../../../theme/utils/my_strings.dart';
import '../widgets/sign_in_with_other_widget.dart';
import 'controllers/sign_in_controller.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 80),
                _buildAttention(),
                const SizedBox(height: 24),
                _buildFieldEmail(),
                const SizedBox(height: 32),
                _buildFieldPassword(),
                const SizedBox(height: 8),
                _buildForgotPassword(),
                const SizedBox(height: 50),
                _buildSignInButton(),
                const SizedBox(height: 24),
                _buildSignUpLink(),
                const SizedBox(height: 32),
                _buildORDivider(),
                const SizedBox(height: 32),
                SignInWithOtherWidget(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttention() {
    return Text(
      'Make sure your input is valid !!',
      style: MyText.subtitleStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back!',
          style: MyText.defaultStyle(
            fontSize: 28,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Please sign in to your ',
                style: MyText.defaultStyle(
                  fontSize: 24,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: 'TASK',
                style: MyText.defaultStyle(
                  fontSize: 24,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' account',
                style: MyText.defaultStyle(
                  fontSize: 24,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  MyGlobalTextFormFieldWidget _buildFieldEmail() {
    return MyGlobalTextFormFieldWidget(
      labelText: 'Email',
      hintText: 'Enter your email address',
      controller: controller.email,
      // errorText: '',
      prefixIcon: const Icon(Icons.email, size: 18),
    );
  }

  Widget _buildFieldPassword() {
    return Obx(
      () => MyGlobalTextFormFieldWidget(
        labelText: 'Password',
        hintText: 'Enter your Password',
        controller: controller.password,
        obscureText: !controller.isHide.value,
        prefixIcon: const Icon(Icons.lock, size: 18),
        suffixIcon: InkWell(
          onTap: () {
            controller.isHide.toggle();
          },
          child: Obx(
            () => controller.isHide.value
                ? const Icon(
                    Icons.visibility,
                    size: 20,
                  )
                : const Icon(
                    Icons.visibility_off,
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.signUp),
        child: Text(
          'Forgot password',
          style: MyText.subtitleStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return MyGlobalElevatedButtonWidget(
      side: BorderSide.none,
      backgroundColor: MyColors.darkPrimary,
      onPressed: () {
        controller.handleSignIn();
      },
      child: Obx(
        () => controller.isLoadingSignIn.value
            ? TaskLoading.button()
            : Text(
                'Sign In',
                style: MyText.defaultStyle(color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account ?",
          style: MyText.subtitleStyle(),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.signUp),
          child: Text(
            'Sign Up',
            style: MyText.subtitleStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildORDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(child: Divider(endIndent: 16)),
        Text("or", style: MyText.subtitleStyle()),
        const Flexible(child: Divider(indent: 16)),
      ],
    );
  }
}
