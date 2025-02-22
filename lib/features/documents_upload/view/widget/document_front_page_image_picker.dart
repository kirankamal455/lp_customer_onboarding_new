import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
//import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dotted_border/dotted_border.dart';

class DocumentFrontPageImagePicker extends StatelessWidget {
  const DocumentFrontPageImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // DocumentScannerOptions documentOptions = DocumentScannerOptions(
      //   documentFormat: DocumentFormat.pdf,
      //   mode: ScannerMode.base,
      //   pageLimit: 1,
      //   isGalleryImport: true,
      // );
      // final documentScanner = DocumentScanner(options: documentOptions);

      // final autoValidate = ref.watch(formValidatePod("photos"));
      // final scannedImage = ref.watch(scannedImagePod);

      return FormBuilderField<String>(
        name: 'scanned_image',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Upload Document Image';
          }
          return null;
        },
        builder: (FormFieldState<String> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [8, 4],
                color: context.primaryColor,
                strokeWidth: 1.5,
                child: Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: field.value != null && field.value!.isNotEmpty
                      ? Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                child: Image.file(
                                  File(field.value!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  field.didChange('');
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : IconButton(
                          iconSize: 43,
                          onPressed: () async {
                            await CunningDocumentScanner.getPictures(
                              androidOptions: const AndroidScannerOptions(
                                noOfPages: 1,
                                isGalleryImportAllowed: true,
                                scannerMode: AndroidScannerMode.scannerModeBase,
                              ),
                            ).then((imagePath) {
                              if (imagePath != null && imagePath.isNotEmpty) {
                                field.didChange(
                                    imagePath.first); // Update form field state
                              }
                            });
                          },
                          icon: Icon(
                            Icons.upload,
                            color: context.primaryColor,
                          ),
                        ),
                ),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
            ],
          );
        },
      );
    });
  }
}

//FormBuilderImagePicker(
      //   name: 'photos',
      //   autovalidateMode: autoValidate
      //       ? AutovalidateMode.disabled
      //       : AutovalidateMode.onUserInteraction,
      //   onReset: () {
      //     ref.read(formValidatePod("photos").notifier).update(
      //           (state) => true,
      //         );
      //   },
      //   onChanged: (value) {
      //     ref.read(formValidatePod("photos").notifier).update(
      //           (state) => false,
      //         );
      //   },
      //   decoration: const InputDecoration(
      //     labelText: 'Pick Document Image',
      //     labelStyle: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   maxImages: 1,
      //   imageQuality: 50,
      //   previewHeight: 200,

      //   backgroundColor: Colors.grey.shade100,
      //   icon: Icons.upload,
      //   // placeholderImage: const CVAssetImage("assets/images/image_upload.png"),
      //   cameraIcon: Icon(
      //     Icons.camera,
      //     color: context.primaryColor,
      //   ),
      //   galleryIcon: Icon(
      //     Icons.image,
      //     color: context.primaryColor,
      //   ),
      //   validator: FormBuilderValidators.required(
      //     errorText: "Please Pick Document Image",
      //   ),
      // );