import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_gradient_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewmodelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, "User Signed up successfully, Please login");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SigninPage()),
          );
        },
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign Up.",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomField(hintText: "Name", controller: nameController),
                      const SizedBox(height: 15),
                      CustomField(
                        hintText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      CustomField(
                        hintText: "Password",
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 15),
                      CustomField(
                        hintText: "Confirm Password",
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      AuthGradientButton(
                        text: "Sign Up",
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            ref
                                .read(authViewmodelProvider.notifier)
                                .signUp(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirm_password:
                                      confirmPasswordController.text,
                                );
                          } else {
                            showSnackBar(context, "Please fill all fields");
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SigninPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  color: Pallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
