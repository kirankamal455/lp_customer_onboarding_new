import 'dart:io';
import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/registration_doc_select_page/controller/croped_image_pod.dart';
import 'package:lp_customer_onboarding/features/registration_doc_select_page/controller/doc_select_pod.dart';
import 'package:lp_customer_onboarding/features/registration_doc_select_page/widgets/document_expire_date_field.dart';
import 'package:lp_customer_onboarding/features/registration_doc_select_page/widgets/document_type_drop_down.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/shared/pods/user_register_pod.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:lp_customer_onboarding/widgets/icon_description.dart';
import 'package:lp_customer_onboarding/widgets/screen_layout.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class DocSelectPage extends ConsumerStatefulWidget {
  const DocSelectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocSelectPageState();
}

class _DocSelectPageState extends ConsumerState<DocSelectPage>
    with GlobalHelper {
  final _formKey = GlobalKey<FormBuilderState>();
  final imageCropper = ImageCropper();
  void submit() {
    if (_formKey.currentState!.validate()) {
      final photoidtype = _formKey.currentState!.fields['DocumentType']?.value;
      final docExpireDate =
          _formKey.currentState!.fields['docExpireDate']?.value as DateTime;
      String formattedDate = DateFormat('dd-MM-yyyy').format(docExpireDate);
      ref.read(userRegisterProvider).photoidtype = photoidtype;
      ref.read(userRegisterProvider).documentExpiryDate = formattedDate;
      openCamara();
    }
  }

  void openCamara() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              "Choose Document Image".text.bold.make().centered().p(8),
              ListTile(
                leading: Icon(
                  Icons.camera,
                  color: context.primaryColor,
                ),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(
                    source: ImageSource.camera,
                    onImagePicked: (file) async {
                      await cropImage(file);
                    },
                    onImagePickCancelled: () {
                      showInfoSnack(text: "Please select an image");
                    },
                    onError: (e) {
                      showErrorSnack(child: Text(e.toString()));
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color: context.primaryColor,
                ),
                title: const Text("Pick from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(
                    source: ImageSource.gallery,
                    onImagePicked: (file) async {
                      await cropImage(file);
                    },
                    onImagePickCancelled: () {
                      showInfoSnack(text: "Please select an image");
                    },
                    onError: (e) {
                      showErrorSnack(child: Text(e.toString()));
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> cropImage(File file) async {
    final croppedFile = await imageCropper.cropImage(
      sourcePath: file.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      ref.read(cropedImagePod.notifier).state = croppedFile;
      ref.read(userRegisterProvider).photoidimagepath = croppedFile.path;
      ref.read(autorouterProvider).navigate(const DocsCornerRoute());
    } else {
      showInfoSnack(text: "No image cropped");
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ScreenLayout(
        titleText: l10n!.docsSelect_title,
        subtitleText: l10n.docsSelect_subtitle,
        child: SizedBox(
          width: context.screenWidth * 0.8,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                ListView(
                  primary: false,
                  physics: const ClampingScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.only(top: 30, bottom: 12),
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: context.screenHeight * 0.02),
                    IconDescription(
                      iconData: Icons.lock,
                      description: l10n.docsSelect_photo_id_label,
                    ),
                    const SizedBox(height: 5),
                    IconDescription(
                      iconData: Icons.calendar_today_outlined,
                      description: l10n.docsSelect_photo_id_label1,
                    ),
                    SizedBox(height: context.screenHeight * 0.07),
                    CustomText(
                      textAlign: TextAlign.center,
                      text: l10n.docsSelect_photo_id_label2,
                      style: CustomTextStyle.subtitleStyle(Colors.black),
                    ),
                    const DocumentTypeDropDown(),
                    const DocumentExpireDateField(),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final selectedDocType = ref.watch(docSelectPod);
                        return ActionButton(
                          onPressed: () {
                            submit();
                          },
                          buttonText: l10n.util_continue_button,
                          buttonEnabled: true,
                        );
                      },
                    ),
                  ),
                ),
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
