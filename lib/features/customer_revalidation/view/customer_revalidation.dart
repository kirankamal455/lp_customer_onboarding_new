import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/controller/document_expiry_check_pod.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/controller/notifier/document_expiry_notifier.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/state/document_expiry_state.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/view/ui_state/document_expire_notdata.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/view/ui_state/document_expired.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/view/ui_state/document_not_expired.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/asynvalue_easy_when.dart';

@RoutePage()
class CustomerRevalidationPage extends ConsumerStatefulWidget {
  const CustomerRevalidationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerRevalidationPageState();
}

class _CustomerRevalidationPageState
    extends ConsumerState<CustomerRevalidationPage> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document Revalidation"),
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
      body: WillPopScope(
        onWillPop: () => onBackPressed(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final documentExpiryCheckAsync =
                    ref.watch(documentExpiryNotifierProvider);
                return documentExpiryCheckAsync.easyWhen(
                  data: (data) {
                    return switch (data) {
                      DocumentExpiredState() => DocumentExpired(
                          documentType: data.docmentType,
                          isDocumentIntelligenceEnabled:
                              data.isDocumentIntelligenceEnabled,
                        ),
                      DocumentExpiryNoDataState() =>
                        const DocumentExpiredNotData(),
                      DocumentNotExpiredState() => DocumentNotExpired(
                          documentType: data.docmentType,
                        ),
                    };
                  },
                  onRetry: () {
                    ref.invalidate(documentExpiryCheckPod);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
