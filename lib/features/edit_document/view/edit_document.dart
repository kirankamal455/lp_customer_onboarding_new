import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/address_field.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/dob_field.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/doc_exp_field.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/document_number_field.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/gender_drop_down.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/issue_date_field.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/name_field.dart';
import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/controller/update_document_btn_notifier_pod.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/view/update_document_btn.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/date_format_extensions.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class EditDocumentPage extends ConsumerStatefulWidget {
  final DocumentUploadResponseModel documentUploadResponseModel;
  const EditDocumentPage(
      {required this.documentUploadResponseModel, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCustomerPageState();
}

class _EditCustomerPageState extends ConsumerState<EditDocumentPage> {
  final formkey = GlobalKey<FormBuilderState>();
  final dateFormat = DateFormat('dd-MM-yyyy');

  void updateDocument() {
    if (formkey.currentState!.saveAndValidate()) {
      final name = formkey.currentState!.fields["name"]!.value;
      final documentNumber =
          formkey.currentState!.fields["documentNumber"]!.value;
      final gender = formkey.currentState!.fields["Gender"]!.value;
      // final address1 = formkey.currentState!.fields["docaddress"]!.value;
      // Assuming you already have the DateTime objects
      final dob = formkey.currentState!.fields["dob"]!.value as DateTime;
      final issueDate =
          formkey.currentState!.fields["issuesdate"]!.value as DateTime;
      final expiryDate =
          formkey.currentState!.fields["docexpdate"]!.value as DateTime;

// Define the desired date format
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

// Format the dates
      final formattedDob = dateFormat.format(dob);
      final formattedIssueDate = dateFormat.format(issueDate);
      final formattedExpiryDate = dateFormat.format(expiryDate);

      if (hasChanges(
        initialData: widget.documentUploadResponseModel.data,
        name: name,
        documentNumber: documentNumber,
        gender: gender,
        dob: formattedDob,
        issueDate: formattedIssueDate,
        expiryDate: formattedExpiryDate,
      )) {
        print("Changed");
        ref.read(updateDocumentAsyncNotifierPod.notifier).updateDocument(
              id: widget.documentUploadResponseModel.processId,
              name: name,
              idDocumentNumber: documentNumber,
              dateOfBirth: formattedDob,
              documentExpiryDate: formattedExpiryDate,
              gender: gender,
              documentIssueDate: formattedIssueDate,
              tokenExpired: () {},
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              },
              onSuccess: (success) {
                ref
                    .read(autorouterProvider)
                    .navigate(FaceLivenessInstructionRoute(
                      faceLivenessArg: FaceLivenessArg(
                        isDetailsEdited: true,
                        documentUploadResponseModel:
                            widget.documentUploadResponseModel,
                      ),
                    ));
                // ref.read(autorouterProvider).navigate(
                //       FaceLivenessRoute(
                //         faceLivenessArg: FaceLivenessArg(
                //           userId: widget.documentUploadResponseModel.processId,
                //           isDetailsEdited: true,
                //         ),
                //       ),
                //     );
                // ref
                //     .read(autorouterProvider)
                //     .navigate(const FaceLivenessInstructionRoute());
              },
            );
      } else {
        print("ChangedNot");
        // ref.read(autorouterProvider).navigate(
        //       FaceLivenessRoute(
        //         faceLivenessArg: FaceLivenessArg(
        //           userId: widget.documentUploadResponseModel.processId,
        //           isDetailsEdited: false,
        //         ),
        //       ),
        //     );

        ref.read(autorouterProvider).navigate(FaceLivenessInstructionRoute(
              faceLivenessArg: FaceLivenessArg(
                isDetailsEdited: false,
                documentUploadResponseModel: widget.documentUploadResponseModel,
              ),
            ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please confirm the information.")),
      );
    }
  }

  bool hasChanges({
    required Data initialData,
    required String name,
    required String documentNumber,
    required String gender,
    required String dob,
    required String issueDate,
    required String expiryDate,
  }) {
    // Log each comparison
    bool hasChanged = false;

    if (initialData.name != name) {
      print("Name has changed: ${initialData.name} != $name");
      hasChanged = true;
    }

    if (initialData.documentNumber != documentNumber) {
      print(
          "Document Number has changed: ${initialData.documentNumber} != $documentNumber");
      hasChanged = true;
    }

    // if (initialData.gender != gender) {
    //   print("Gender has changed: ${initialData.gender} != $gender");
    //   hasChanged = true;
    // }

    if (initialData.dateOfBirth != dob) {
      print("Date of Birth has changed: ${initialData.dateOfBirth} != $dob");
      hasChanged = true;
    }

    if (initialData.issueDate != issueDate) {
      print("Issue Date has changed: ${initialData.issueDate} != $issueDate");
      hasChanged = true;
    }

    if (initialData.expiryDate != expiryDate) {
      print(
          "Expiry Date has changed: ${initialData.expiryDate} != $expiryDate");
      hasChanged = true;
    }

    return hasChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Document"),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
          child: FormBuilder(
            key: formkey,
            initialValue: {
              "name": widget.documentUploadResponseModel.data.name,
              "documentNumber":
                  widget.documentUploadResponseModel.data.documentNumber,
              "Gender": widget.documentUploadResponseModel.data.gender.isEmpty
                  ? null
                  : widget.documentUploadResponseModel.data.gender == "M" ||
                          widget.documentUploadResponseModel.data.gender ==
                              "Male"
                      ? "Male"
                      : widget.documentUploadResponseModel.data.gender == "F" ||
                              widget.documentUploadResponseModel.data.gender ==
                                  "Female"
                          ? "Female"
                          : "Other",
              "docaddress": "234 Elm Street, Apt. 56",
              "dob":
                  widget.documentUploadResponseModel.data.dateOfBirth.isNotEmpty
                      ? dateFormat.parse(widget
                          .documentUploadResponseModel.data.dateOfBirth
                          .toFormattedDate())
                      : null,
              "issuesdate":
                  widget.documentUploadResponseModel.data.issueDate.isEmpty
                      ? null
                      : dateFormat.parse(widget
                          .documentUploadResponseModel.data.issueDate
                          .toFormattedDate()),
              "docexpdate":
                  widget.documentUploadResponseModel.data.expiryDate.isEmpty
                      ? null
                      : dateFormat.parse(widget
                          .documentUploadResponseModel.data.expiryDate
                          .toFormattedDate()),
            },
            child: Column(
              children: [
                DocumentNumberField(
                  documentNumber:
                      widget.documentUploadResponseModel.data.documentNumber,
                ),
                const Gap(20),
                NameField(
                  name: widget.documentUploadResponseModel.data.name,
                ),
                const Gap(20),
                GenderDropDownField(
                  gender: widget.documentUploadResponseModel.data.gender,
                ),
                const Gap(20),
                DobField(
                  dob: widget.documentUploadResponseModel.data.dateOfBirth,
                ),
                //const Gap(20),
                // const DocumentAddressField(),
                const Gap(20),
                IssueDateField(
                  issueDate: widget.documentUploadResponseModel.data.issueDate,
                ),
                const Gap(20),
                DocExpirationField(
                  docExp: widget.documentUploadResponseModel.data.expiryDate,
                ),
                const Gap(20),
                // const DocumentAddressField(
                //   address: '',
                // ),
                // const Gap(20),
                FormBuilderCheckbox(
                  name: 'confirmation',
                  initialValue: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  activeColor: context.primaryColor,
                  decoration: InputDecoration(fillColor: Colors.grey.shade100),
                  side: const BorderSide(color: Colors.grey),
                  validator: FormBuilderValidators.equal(
                    true,
                    errorText:
                        "You must confirm that all information is correct",
                  ),
                  title: const Text(
                      "I hereby confirm that all information is correct"),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: UpdateDocumentBtnView(
        submit: () {
          updateDocument();
        },
      ),
    );
  }
}
