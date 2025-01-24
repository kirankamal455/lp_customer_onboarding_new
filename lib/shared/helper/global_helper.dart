import 'dart:async';
import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lp_customer_onboarding/const/colors.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/shared/widget/circular_timer.dart';
import 'package:lp_customer_onboarding/shared/widget/custom_dialog.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:velocity_x/velocity_x.dart';

mixin GlobalHelper<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;
  AnimationController? _animationController;
  Completer completer = Completer();

  Future<S?> showCustomDialog<S>({
    required BuildContext context,
    required WidgetBuilder builder,
    String? routerName,
    bool barrierDismissible = true,
  }) {
    return showDialog<S>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      routeSettings:
          routerName != null ? RouteSettings(name: routerName) : null,
      builder: (BuildContext buildContext) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return pageChild;
            },
          ),
        );
      },
    );
  }

  void showCustomOverlay({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (context) => SafeArea(
        child: Builder(
          builder: builder,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void showCProgressOverlay({
    required BuildContext context,
    required TickerProvider vsync,
  }) {
    _animationController = AnimationController(
      vsync: vsync,
      value: 0,
    );

    showCustomOverlay(
      context: context,
      builder: (context) => ColoredBox(
        color: Colors.black54,
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController!.view,
            builder: (BuildContext context, Widget? child) {
              return CircularProgressIndicator(
                value: _animationController?.value,
              );
            },
          ),
        ),
      ),
    );
  }

  set updateProgress(double value) {
    _animationController?.value = value;
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _animationController?.dispose();
  }

  Future<T?> showCustomBottomSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = false,
    bool enableDrag = false,
    bool useSafeArea = true,
    double? elevation,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: builder,
      enableDrag: false,
      elevation: elevation,
    );
  }

  void hideBottomSheet({
    required BuildContext context,
  }) {
    Navigator.of(context).pop();
  }

  void hideDialog() {
    Navigator.of(context).pop();
  }

  Future<S?> showBasicFlash<S>({
    required Widget content,
    required VoidCallback onConfirm,
    Widget? icon,
    Widget? title,
    List<Widget>? actions,
  }) async {
    if (context.mounted) {
      await context.showFlash<S>(
        builder: (context, controller) => FlashBar(
          controller: controller,
          indicatorColor: Colors.red,
          icon: const Icon(Icons.tips_and_updates_outlined),
          title: title,
          content: content,
          actions: actions ??
              [
                TextButton(
                  onPressed: controller.dismiss,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    onConfirm();
                    controller.dismiss();
                  },
                  child: const Text('Confirm'),
                )
              ],
        ),
      );
    }
    return null;
  }

  void showFlashOverlay({
    required Widget content,
    Widget? title,
    Widget? icon,
  }) {
    completer = Completer();
    context.showFlash(
      persistent: true,
      dismissCompleter: completer,
      builder: (context, controller) {
        return WillPopScope(
          onWillPop: () async => false,
          child: FlashBar(
            controller: controller,
            margin: const EdgeInsets.all(32.0),
            behavior: FlashBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(
                color: Colors.yellow,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            indicatorColor: Colors.amber,
            title: title,
            icon: icon ?? const CircularTimer(),
            content: content,
          ),
        );
      },
    );
  }

  void showErrorSnack({
    required Widget child,
    bool showCloseIcon = true,
    FlashPosition position = FlashPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Icon? icon = const Icon(Icons.error_outline, color: Colors.red),
    Color? indicatorColor = const Color.fromARGB(255, 232, 7, 7),
    Widget Function(BuildContext, FlashController<T>)? primaryActionBuilder,
  }) {
    if (context.mounted) {
      context.showErrorBar(
        content: child,
        duration: duration,
        position: position,
        icon: icon,
        indicatorColor: indicatorColor,
        primaryActionBuilder: showCloseIcon
            ? primaryActionBuilder ??
                (context, controller) {
                  return IconButton(
                    onPressed: controller.dismiss,
                    icon: const Icon(Icons.close),
                  );
                }
            : null,
      );
    }
  }

  void showInfoSnack({
    required String text,
    bool showCloseIcon = true,
    FlashPosition position = FlashPosition.bottom,
    Duration duration = const Duration(seconds: 4),
    Icon? icon = const Icon(Icons.info_outline),
    Color? indicatorColor = voiletPrimary,
    Widget Function(BuildContext, FlashController<T>)? primaryActionBuilder,
  }) {
    if (context.mounted) {
      var snackdemo = SnackBar(
        duration: duration,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);

      // 'showSnackBar' is deprecated and shouldn't be used.
      //Use ScaffoldMessenger.showSnackBar.
      // Scaffold.of(context).showSnackBar(snackdemo);
    }
    // context.showInfoBar(
    //   content: child,
    //   duration: duration,
    //   position: position,
    //   icon: icon,
    //   indicatorColor: indicatorColor,
    //   primaryActionBuilder: showCloseIcon
    //       ? primaryActionBuilder ??
    //           (context, controller) {
    //             return IconButton(
    //               onPressed: controller.dismiss,
    //               icon: const Icon(Icons.close),
    //             );
    //           }
    //       : null,
    // );
  }

  void showPopupDialog(
      {String? title,
      String? description,
      DialogType? dialogType,
      String? buttonText,
      VoidCallback? onPressedOK,
      bool isDismissible = true,
      int? backTimes = 1}) {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          if (!isDismissible) {
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: context.screenWidth * 0.87,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      CustomText(
                          text: title ?? '',
                          style: CustomTextStyle.titleStyle(Colors.black),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 10),
                      CustomText(
                          text: description ?? '',
                          style: CustomTextStyle.subtitleStyle(Colors.black),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 70,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  context.primaryColor)),
                          onPressed: () {
                            if (onPressedOK != null) {
                              onPressedOK.call();
                            } else {
                              if (backTimes == 1) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: CustomText(
                              text: buttonText ?? 'OK',
                              style:
                                  CustomTextStyle.subtitleStyle(Colors.white),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: -28,
                    child: CircleAvatar(
                      minRadius: 16,
                      maxRadius: 28,
                      backgroundColor: getStatusColor(dialogType!),
                      child: Icon(
                        getStatusIcon(dialogType),
                        size: 28,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessSnack({
    required Widget child,
    bool showCloseIcon = true,
    FlashPosition position = FlashPosition.bottom,
    Duration duration = const Duration(seconds: 3),
    Icon? icon = const Icon(
      Icons.check_circle_outline,
      color: Color(0xFF81C784),
    ),
    Color? indicatorColor = const Color(0xFF81C784),
    Widget Function(BuildContext, FlashController<T>)? primaryActionBuilder,
  }) {
    if (context.mounted) {
      context.showSuccessBar(
        content: child,
        duration: duration,
        position: position,
        icon: icon,
        indicatorColor: indicatorColor,
        primaryActionBuilder: showCloseIcon
            ? primaryActionBuilder ??
                (context, controller) {
                  return IconButton(
                    onPressed: controller.dismiss,
                    icon: const Icon(Icons.close),
                  );
                }
            : null,
      );
    }
  }

  void showLoading({String? message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 8),
                Text(message ?? 'Loading...')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage({
    required void Function(File file) onImagePicked,
    required VoidCallback onImagePickCancelled,
    required void Function(Object e) onError,
    required ImageSource source, // Add a parameter to decide source
  }) async {
    final imagePicker = ImagePicker();

    try {
      final image = await imagePicker.pickImage(
        source: source, // Use the passed source (camera or gallery)
        imageQuality: 50,
      );

      if (image != null) {
        onImagePicked(File(image.path));
        return;
      } else {
        onImagePickCancelled();
        return;
      }
    } on PlatformException catch (e) {
      // Handle permission issues or other platform exceptions
      String errorMessage = e.message.toString();
      onError(
        errorMessage.contains("The user did not allow camera access")
            ? "Please allow access to the Camera"
            : errorMessage,
      );
    } catch (e) {
      onError(e);
      return;
    }
  }

  void showSendingProgress({String? message, required Widget child}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    var isCancel = await showDialog<bool>(
      context: context,
      builder: (context) => CustomDialog(
        onTapYesBtn: () {
          SystemNavigator.pop();
        },
        onTapNoBtn: () => Navigator.of(context).pop(),
        subTittle: 'Do you want to exit?',
        isTittleVisible: true,
        tittle: "Are you sure?",
      ),
    );
    if (isCancel != null) {
      if (isCancel && isCancel) {
        SystemNavigator.pop();
      }
      return isCancel;
    }
    return false;
  }

  void hideFlashOverlay() {
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  void hideKeyboard() {
    if (context.mounted) {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  void dispose() {
    hideFlashOverlay();
    hideOverlay();
    _animationController?.dispose();
    super.dispose();
  }
}

enum DialogType {
  success,
  error,
  warning,
}

Color getStatusColor(DialogType customData) {
  switch (customData) {
    case DialogType.error:
      return Colors.red;
    case DialogType.warning:
      return Colors.amber;
    default:
      return Colors.green;
  }
}

IconData getStatusIcon(DialogType dialogType) {
  switch (dialogType) {
    case DialogType.error:
      return Icons.close;
    case DialogType.warning:
      return Icons.warning_amber_outlined;
    default:
      return Icons.check;
  }
}
