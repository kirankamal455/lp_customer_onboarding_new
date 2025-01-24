// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';

// class FacelivenessInitStateWidget extends ConsumerWidget {
//   const FacelivenessInitStateWidget( {required this.faceLivenessArg, super.key});
//   final FaceLivenessArg faceLivenessArg;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.all(
//           16.0), // Add some padding to the edges of the screen
//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.center, // Center align the column
//         children: [
//           const Text(
//             'Liveness Detection Instructions',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),

//           const Spacer(),

//           const Card(
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     '1. Sufficient Lighting',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Make sure you are in an area that has sufficient lighting and that your ears are not covered by anything.',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     '2. Straight Ahead View',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Hold the phone at eye level and look straight at the camera.',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     '3. Maintain a Neutral Expression',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Keep your facial expression neutral (no exaggerated smiles or frowns).',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     '4. Avoid Obstructions',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Ensure nothing obstructs your face (e.g., hair, hands, or other objects).',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const Spacer(), // Add space between the card and the button

//           // Start Button
//           Consumer(
//             builder: (_, WidgetRef ref, __) {
//               return ElevatedButton(
//                 onPressed: () async {
//                    ref.read(faceLivenessProvider(faceLivenessArg).notifier).startLiveness();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                   textStyle: const TextStyle(fontSize: 18),
//                 ),
//                 child: const Text(
//                   'Start Liveness Detection',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
