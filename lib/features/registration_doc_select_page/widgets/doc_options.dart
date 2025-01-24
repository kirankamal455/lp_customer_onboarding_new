
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/registration_doc_select_page/controller/doc_select_pod.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';

class DocOptions extends ConsumerWidget {
  final String documentTitle;
  final String documentValue;
  const DocOptions(
      {required this.documentValue, super.key, required this.documentTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDoc = ref.watch(docSelectPod);
    return Container(
      color: selectedDoc == documentValue ? Colors.grey[300] : Colors.white,
      child: ListTile(
        onTap: () {
          ref.read(docSelectPod.notifier).update((state) => documentValue);
        },
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        dense: true,
        title: CustomText(
          textAlign: TextAlign.center,
          text: documentTitle,
          style: CustomTextStyle.subtitleStyle(Colors.black),
        ),
      ),
    );
  }
}
