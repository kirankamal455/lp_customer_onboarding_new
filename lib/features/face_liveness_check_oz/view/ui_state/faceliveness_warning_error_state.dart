// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
// import 'package:lp_customer_onboarding/l10n/l10n.dart';
// import 'package:velocity_x/velocity_x.dart';

// class FaceLivenessWarningErrorStateWidget extends StatelessWidget {
//   const FaceLivenessWarningErrorStateWidget(
//       {super.key, required this.faceLivenessErrors, required this.faceLivenessArg});
//   final FaceLivenessErrors faceLivenessErrors;
//  final FaceLivenessArg faceLivenessArg;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           // Warning icon with error message
//           const Icon(
//             Icons.warning_amber_rounded, // Warning icon
//             color: Colors.orangeAccent,
//             size: 60,
//           ),
//           const Gap(20), // Space between the icon and the text

//           Text(
//             faceLivenessErrors == FaceLivenessErrors.analysisDeclined
//                 ? context.l10n!.declined
//                 : (faceLivenessErrors == FaceLivenessErrors.faceNotFound
//                     ? context.l10n!.facenotmached
//                     : 'Liveness verification failed.'),
//             style: const TextStyle(
//               fontSize: 20,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),

//           //Text("$faceLivenessErrors"),
//           const SizedBox(height: 20),

//           // Retry button
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
