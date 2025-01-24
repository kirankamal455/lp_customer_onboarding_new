import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:velocity_x/velocity_x.dart';

class DocumentFrontPageImagePicker extends StatelessWidget {
  const DocumentFrontPageImagePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final autoValidate = ref.watch(formValidatePod("photos"));
      return FormBuilderImagePicker(
        name: 'photos',
        autovalidateMode: autoValidate
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        onReset: () {
          ref.read(formValidatePod("photos").notifier).update(
                (state) => true,
              );
        },
        onChanged: (value) {
          ref.read(formValidatePod("photos").notifier).update(
                (state) => false,
              );
        },
        decoration: const InputDecoration(
          labelText: 'Pick Document Image',
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        maxImages: 1,
        imageQuality: 50,
        previewHeight: 200,

        backgroundColor: Colors.grey.shade100,
        icon: Icons.upload,
        // placeholderImage: const CVAssetImage("assets/images/image_upload.png"),
        cameraIcon: Icon(
          Icons.camera,
          color: context.primaryColor,
        ),
        galleryIcon: Icon(
          Icons.image,
          color: context.primaryColor,
        ),
        validator: FormBuilderValidators.required(
          errorText: "Please Pick Document Image",
        ),
      );
    });
  }
}
