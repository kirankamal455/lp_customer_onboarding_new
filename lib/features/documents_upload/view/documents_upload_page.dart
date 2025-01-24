import 'package:app_settings/app_settings.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';
import 'package:lp_customer_onboarding/features/documents_upload/view/widget/document_back_page_image_picker.dart';
import 'package:lp_customer_onboarding/features/documents_upload/view/widget/document_front_page_image_picker.dart';
import 'package:lp_customer_onboarding/features/documents_upload/view/widget/document_type_drop_down_field.dart';
import 'package:lp_customer_onboarding/features/submit_btn/controller/submit_fos_btn_notifier_pod.dart';
import 'package:lp_customer_onboarding/features/submit_btn/view/submit_fos_btn_view.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/shared/widget/custom_dialog.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  final String selctedName;
  const HomePage(this.selctedName, {super.key});

  @override
  ConsumerState<HomePage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<HomePage> with GlobalHelper {
  final _formKey = GlobalKey<FormBuilderState>();

  void submit() {
    if (_formKey.currentState!.validate()) {
      final documentType = _formKey.currentState!.fields['DocumentType']?.value;

      final imageFiles =
          _formKey.currentState!.fields['photos']?.value as List<dynamic>;

      String formattedDate = "";
      // if (nextFollowupDate != null) {
      //   formattedDate = DateFormat('dd/MM/yyyy').format(nextFollowupDate);
      // }
      List<XFile> filePaths = [];
      for (int i = 0; i < imageFiles.length; i++) {
        filePaths.add(imageFiles[i] as XFile);
      }
      talker.info("Image Files: ${filePaths.first.path}");

      ref.read(submitFosAsyncNotifierPod.notifier).submitDocument(
            documentType: documentType,

            filePath: filePaths.first,
            // filePaths: filePaths
            //     .map(
            //       (e) => e.path,
            //     )
            //     .toList(),
            onSuccess: (documentUploadResponseModel) {
              if (checkDocumentData(documentUploadResponseModel)) {
                showPopupDialog(
                  title: '',
                  description:
                      "It seems the uploaded file is not a valid document. Please upload a clear image",
                  dialogType: DialogType.error,
                  backTimes: 1,
                );
              } else {
                DateFormat format = DateFormat('dd/MM/yyyy');
                if (documentUploadResponseModel.data.expiryDate.isNotEmpty) {
                  DateTime expiryDate =
                      format.parse(documentUploadResponseModel.data.expiryDate);
                  if (!expiryDate.isBefore(DateTime.now())) {
                    ref.read(autorouterProvider).navigate(EditDocumentRoute(
                        documentUploadResponseModel:
                            documentUploadResponseModel));
                  } else {
                    showPopupDialog(
                      title: '',
                      description:
                          "Your ${documentType == "PRT" ? "Passport" : documentType == "NID" ? "National ID Card" : "Residence Permit"} has expired. Please upload a valid document.",
                      dialogType: DialogType.error,
                      backTimes: 1,
                    );
                  }
                } else {
                  ref.read(autorouterProvider).navigate(EditDocumentRoute(
                      documentUploadResponseModel:
                          documentUploadResponseModel));
                }
              }
            },
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error)),
              );
            },
            onLocationPermissionError: (error) {
              talker.info(error);
              final snackBar = SnackBar(
                content: const Text(
                  'Location permission is required to use this feature.',
                ),
                action: SnackBarAction(
                  label: 'Open Settings',
                  onPressed: () {
                    AppSettings.openAppSettings();
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            onLocationServiceError: (error) {
              final snackBar = SnackBar(
                content: const Text(
                  'Please turn on location service',
                ),
                action: SnackBarAction(
                  label: 'Open Settings',
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.location);
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            tokenExpired: () {
              // ref.read(autorouterProvider).replaceAll([const LoginRoute()]);
              showInfoSnack(text: "Token has expired; please login again.");
            },
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Fill the form.')),
      );
    }
  }

  void onResetForm() {
    final state = _formKey.currentState;
    if (state != null) {
      final fields = state.fields;
      for (var element in fields.keys) {
        _formKey.currentState?.fields[element]?.reset();
      }

      hideKeyboard();
    }
  }

  // Future<bool> logout() async {
  //   return await showCustomDialog(
  //         routerName: 'Exit',
  //         context: context,
  //         builder: (BuildContext context) => CustomDialog(
  //           onTapYesBtn: () async {
  //             SystemNavigator.pop();
  //           },
  //           onTapNoBtn: () {
  //             Navigator.pop(context);
  //           },
  //           subTittle: 'Do you want to Exit?',
  //           isTittleVisible: true,
  //           tittle: "Are you sure?",
  //         ),
  //       ) ??
  //       false;
  // }

  bool checkDocumentData(
      DocumentUploadResponseModel documentUploadResponseModel) {
    if (documentUploadResponseModel.data.name.isEmpty &&
        documentUploadResponseModel.data.dateOfBirth.isEmpty &&
        documentUploadResponseModel.data.gender.isEmpty &&
        documentUploadResponseModel.data.documentNumber.isEmpty &&
        documentUploadResponseModel.data.issueDate.isEmpty &&
        documentUploadResponseModel.data.expiryDate.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => onBackPressed(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(widget.selctedName),
            actions: [
              // IconButton(
              //     onPressed: () => onResetForm(), icon: const Icon(Icons.clear)),
              IconButton(
                onPressed: () {
                  onBackPressed();
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: const Column(
                  children: [
                    DocumentTypeDropDownField(),
                    Gap(30),
                    DocumentFrontPageImagePicker(),
                    // Gap(20),
                    // DocumentBackPageImagePicker(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SubmitFosBtnView(
            submit: submit,
          ),
        ));
  }
}
