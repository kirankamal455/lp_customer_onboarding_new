// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
// import 'package:lp_customer_onboarding/l10n/l10n.dart';
// import 'package:velocity_x/velocity_x.dart';

// class FaceVerifyError extends StatelessWidget {
//   const FaceVerifyError({super.key, required this.faceLivenessErrors, required this.faceLivenessArg});
//   final FaceLivenessErrors faceLivenessErrors;
//   final FaceLivenessArg faceLivenessArg;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             faceLivenessErrors == FaceLivenessErrors.analysisDeclined
//                 ? context.l10n!.declined
//                 : 'Face Verification Faild',
//             style: const TextStyle(fontSize: 18, color: Colors.red),
//           ),
//           const SizedBox(height: 20),
//           // Text('Error: $faceLivenessErrors'),
//           const Gap(40),
//           Consumer(
//             builder: (context, ref, child) {
//               return ElevatedButton(
//                 onPressed: () {
//                   ref.read(faceLivenessProvider(faceLivenessArg).notifier).startLiveness();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: context.primaryColor,
//                   minimumSize: const Size(200, 50),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   elevation: 5,
//                 ),
//                 child: const Text(
//                   "Check Again",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
