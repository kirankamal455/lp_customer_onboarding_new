// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
// import 'package:velocity_x/velocity_x.dart';

// class FaceLivenessErrorStateWidget extends StatelessWidget {
//   const FaceLivenessErrorStateWidget(
//       {super.key, required this.faceLivenessErrors, required this.faceLivenessArg});
//   final FaceLivenessErrors faceLivenessErrors;
//   final FaceLivenessArg faceLivenessArg;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           // Warning icon with error message
//           const Icon(
//             Icons.error, // Warning icon
//             color: Colors.red,
//             size: 60,
//           ),
//           const Gap(20), // Space between the icon and the text

//           // Error message text
//           const Text(
//             'Something went wrong ,Please try again later',
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.black,
//               fontWeight: FontWeight.bold, // Make the text bold
//             ),
//             textAlign: TextAlign.center, // Center align the text
//           ),
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
