import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/gen/assets.gen.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class RegistrationSuccessPage extends StatelessWidget {
  final bool isRegistrationPending;

  const RegistrationSuccessPage(
      {super.key, required this.isRegistrationPending});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Registration Success'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              // Success Icon or Image
              // Icon(
              //   Icons.check_circle_outline,
              //   color: context.primaryColor,
              //   size: 130,
              // ),
              Lottie.asset(Assets.animations.sucessAnimation,
                  width: 500, height: 350, fit: BoxFit.fill),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    isRegistrationPending
                        ? 'Registration Successful,\nPending Review'
                        : 'Registration Successful!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                isRegistrationPending
                    ? 'Your account is created successfully, but we will review your application and confirm your account.'
                    : 'Your account has been created successfully.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              const Spacer(),

              // Button to go to the login page or home page
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ElevatedButton(
                    onPressed: () {
                      ref
                          .read(autorouterProvider)
                          .replaceAll([const WelcomeRoute()]);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ).w(250);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
