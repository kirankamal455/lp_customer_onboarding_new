import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/view/ui_state/document_expire_notdata.dart';
import 'package:velocity_x/velocity_x.dart';

class DocumentNotExpired extends StatelessWidget {
  final String documentType;
  const DocumentNotExpired({super.key, required this.documentType});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Your $documentType is up to date.",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ).centered();
  }
}
