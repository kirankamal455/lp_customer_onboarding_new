import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/const/resource.dart';

import 'package:lp_customer_onboarding/shared/api_client/dio/dio_client_provider.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/shared/pods/internet_checker_pod.dart';

import 'package:velocity_x/velocity_x.dart';

extension NoInternet on Widget {
  Widget noInternetWidget({bool maintainState = true}) {
    return InternetCheckerWidget(
      maintainState: maintainState,
      child: this,
    );
  }
}

class InternetCheckerWidget extends ConsumerStatefulWidget {
  const InternetCheckerWidget({
    required this.child,
    required this.maintainState,
    super.key,
  });
  final Widget child;
  final bool maintainState;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoInternetWidgetState();
}

class _NoInternetWidgetState extends ConsumerState<InternetCheckerWidget>
    with GlobalHelper {
  InternetConnectionStatus? lastResult;

  void internetListener(
    InternetConnectionStatus status, {
    required void Function() onNoInternetOKPressed,
  }) {
    switch (status) {
      case InternetConnectionStatus.connected:
        talker.debug('Data Reconnected.');
        if (lastResult == InternetConnectionStatus.disconnected) {
          ref.invalidate(dioProvider);
          // ScaffoldMessenger.of(context)
          //   ..clearMaterialBanners()
          //   ..showMaterialBanner(
          //     MaterialBanner(
          //       content: const Text(
          //         'Got Internet ...... Refreshed',
          //         style: TextStyle(
          //           color: Colors.green,
          //         ),
          //       ),
          //       actions: [
          //         ElevatedButton(
          //           onPressed: () {
          //             ScaffoldMessenger.of(context).clearMaterialBanners();
          //           },
          //           child: const Text('OK'),
          //         ),
          //       ],
          //     ),
          //   );
          Future.delayed(
            const Duration(seconds: 2),
            () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            },
          );
        } else {
          talker.debug('First time');
        }

        break;
      case InternetConnectionStatus.disconnected:
        talker.debug('You are disconnected from the internet.');
        // ScaffoldMessenger.of(context)
        //   ..clearMaterialBanners()
        //   ..showMaterialBanner(
        //     MaterialBanner(
        //       content: const Text(
        //         'No Internet Available',
        //         style: TextStyle(
        //           color: Colors.red,
        //         ),
        //       ),
        //       actions: [
        //         ElevatedButton(
        //           onPressed: () {
        //             onNoInternetOKPressed();
        //           },
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     ),
        //   );
        break;
    }
    lastResult = status;
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(internetCheckerPod);
    ref.listen(
      internetCheckerPod,
      (previous, next) {
        final status = next.value;
        if (status != null) {
          internetListener(
            status,
            onNoInternetOKPressed: () {
              ref.invalidate(internetCheckerPod);
              statusAsync.whenData((status) {
                if (status == InternetConnectionStatus.connected) {
                  ScaffoldMessenger.of(context).clearMaterialBanners();
                }
              });
            },
          );
        }
      },
    );
    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      body: !kIsWeb
          ? statusAsync.when(
              data: (status) {
                if (widget.maintainState) {
                  return Stack(
                    children: [
                      Visibility(
                        visible: status == InternetConnectionStatus.connected,
                        maintainState: true,
                        child: widget.child,
                      ),
                      if (status == InternetConnectionStatus.disconnected)
                        Scaffold(
                          appBar: AppBar(
                            systemOverlayStyle: const SystemUiOverlayStyle(
                              statusBarColor: Colors
                                  .transparent, // Makes the status bar transparent
                              statusBarIconBrightness:
                                  Brightness.dark, // Black status bar icons
                            ),
                            backgroundColor: Colors.white,
                          ),
                          body: <Widget>[
                            Image.asset(R.ASSETS_IMAGES_NO_INTERNET_PNG),
                            const Gap(30),
                            const Text(
                              "NO INTERNET CONNECTION",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const Gap(30),
                            ElevatedButton(
                                    onPressed: () {
                                      ref.invalidate(internetCheckerPod);
                                    },
                                    child: "Retry".text.white.make())
                                .h(45)
                                .w(100)
                          ].vStack(alignment: MainAxisAlignment.center),
                        ),
                    ],
                  );
                } else {
                  switch (status) {
                    case InternetConnectionStatus.connected:
                      return widget.child;
                    case InternetConnectionStatus.disconnected:
                      return Scaffold(
                        body: <Widget>[].stack(clip: Clip.none),
                      );
                  }
                }
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : widget.child,
    );
  }
}
