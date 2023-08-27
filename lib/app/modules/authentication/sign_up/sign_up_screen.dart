import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/helpers/task_loading.dart';

import '../../../components/my_global_elevatedbutton_widget.dart';
import '../../../components/my_global_textformfield_widget.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/utils/my_colors.dart';
import '../../../theme/utils/my_strings.dart';
import '../sign_in/controllers/sign_in_controller.dart';
import '../widgets/sign_in_with_other_widget.dart';
import 'controllers/sign_up_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signIn = Get.find<SignInController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 80),
                _buildAttention(),
                const SizedBox(height: 24),
                _buildFieldUsername(),
                const SizedBox(height: 32),
                _buildFieldEmail(),
                const SizedBox(height: 32),
                _buildFieldPassword(),
                const SizedBox(height: 50),
                _buildSignUpButton(),
                const SizedBox(height: 24),
                _buildSignInLink(),
                const SizedBox(height: 32),
                _buildORDivider(),
                const SizedBox(height: 32),
                SignInWithOtherWidget(controller: signIn),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          size: 24.0,
          color: Colors.grey,
        ),
      ),
      actions: const [],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to get started?',
          style: MyText.defaultStyle(
            fontSize: 28,
          ),
        ),
        Text(
          'Create a new account now!',
          style: MyText.defaultStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
        ),
      ],
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

  Widget _buildFieldUsername() {
    return MyGlobalTextFormFieldWidget(
      labelText: 'Username',
      hintText: 'Enter your username ',
      controller: controller.username,
      // errorText: '',
      prefixIcon: const Icon(Icons.person, size: 18, color: Colors.grey),
    );
  }

  Widget _buildFieldEmail() {
    return MyGlobalTextFormFieldWidget(
      labelText: 'Email',
      hintText: 'Enter your email address',
      controller: controller.email,
      // errorText: '',
      prefixIcon: const Icon(Icons.email, size: 18, color: Colors.grey),
    );
  }

  Widget _buildFieldPassword() {
    return Obx(
      () => MyGlobalTextFormFieldWidget(
        labelText: 'Password',
        hintText: 'Enter your Password',
        controller: controller.password,
        obscureText: !controller.isHide.value,
        prefixIcon: const Icon(Icons.lock, size: 18, color: Colors.grey),
        suffixIcon: InkWell(
          onTap: () {
            controller.isHide.toggle();
          },
          child: Obx(
            () => controller.isHide.value
                ? const Icon(
                    Icons.visibility,
                    size: 20,
                    color: Colors.grey,
                  )
                : const Icon(
                    Icons.visibility_off,
                    size: 20,
                    color: Colors.grey,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return MyGlobalElevatedButtonWidget(
      side: BorderSide.none,
      backgroundColor: MyColors.blue,
      onPressed: () {
        controller.handleSignUp();
      },
      child: Obx(
        () => controller.isLoadingSignUp.value
            ? TaskLoading.button()
            : Text(
                'Sign Up',
                style: MyText.defaultStyle(color: Colors.white),
              ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account ?",
          style: MyText.subtitleStyle(),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.signIn),
          child: Text(
            'Sign In',
            style: MyText.subtitleStyle(
              color: MyColors.blue,
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
