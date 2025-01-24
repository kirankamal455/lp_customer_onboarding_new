import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class EditButton extends ConsumerWidget {
  final String buttonType;
  final String data;
  const EditButton({required this.data, required this.buttonType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return data.isEmpty
        ? const SizedBox(
            height: 10,
            width: 50,
          )
        : SizedBox(
            width: 50,
            child: IconButton(
              onPressed: () {
                ref.read(editDocPod(buttonType).notifier).update(
                      (state) => !state,
                    );
              },
              icon: Icon(
                Icons.edit,
                color: context.primaryColor,
              ),
            ),
          );
  }
}
