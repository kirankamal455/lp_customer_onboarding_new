// import 'package:fgrs/data/const/theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:gap/gap.dart';

// class ResultScreen extends StatelessWidget {
//   final String result;
//   final bool isFaceSimilar;
//   final AppLocalizations localization;
//   final VoidCallback onPressed;
//   final bool isFaceCompareSuccess;
//   final String facecompareErrorMsg;
//   const ResultScreen({
//     Key? key,
//     required this.result,
//     required this.isFaceSimilar,
//     required this.localization,
//     required this.onPressed,
//     required this.isFaceCompareSuccess,
//     required this.facecompareErrorMsg,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           LivenessResultIcon(result: result, localization: localization),
//           LivenessResultMessage(result: result, localization: localization),
//           FaceMatchResult(
//             isFaceSimilar: isFaceSimilar,
//             localization: localization,
//             isFaceCompareSuccess: isFaceCompareSuccess,
//             facecompareErrorMsg: facecompareErrorMsg,
//           ),
//           const SizedBox(height: 50),
//           ElevatedButton(
//             onPressed: onPressed,
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: darkPinkAccent, // Text color
//               minimumSize:
//                   const Size(200, 50), // Set a minimum size for the button
//               padding: const EdgeInsets.symmetric(
//                   vertical: 15, horizontal: 25), // Padding inside the button
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30), // Rounded corners
//               ),
//               elevation: 5, // Add shadow for elevation effect
//             ),
//             child: Text(
//               localization.repeat,
//               style: const TextStyle(
//                 fontSize: 16, // Font size for the button text
//                 fontWeight: FontWeight.bold, // Bold text
//                 letterSpacing:
//                     1.2, // Add spacing between letters for a clean look
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class LivenessResultIcon extends StatelessWidget {
//   final String result;
//   final AppLocalizations localization;

//   const LivenessResultIcon({
//     Key? key,
//     required this.result,
//     required this.localization,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     IconData icon;
//     Color color;

//     if (result == localization.success) {
//       icon = Icons.check_circle_outline;
//       color = Colors.green;
//     } else if (result == localization.declined || result == "USER_CANCELLED") {
//       icon = Icons.warning_amber_outlined;
//       color = Colors.orange;
//     } else {
//       icon = Icons.error_outline;
//       color = Colors.red;
//     }

//     return AnimatedOpacity(
//       opacity: 1.0,
//       duration: const Duration(seconds: 1),
//       child: Icon(icon, color: color, size: 65.0),
//     );
//   }
// }

// class LivenessResultMessage extends StatelessWidget {
//   final String result;
//   final AppLocalizations localization;

//   const LivenessResultMessage({
//     Key? key,
//     required this.result,
//     required this.localization,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           result == localization.success
//               ? Icons.check_circle_outline
//               : Icons.error_outline,
//           color: result == localization.success ? Colors.green : Colors.red,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(15),
//           child: Text(
//             result == "USER_CANCELLED" ? localization.canceled : result,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class FaceMatchResult extends StatelessWidget {
//   final bool isFaceSimilar;
//   final AppLocalizations localization;
//   final bool isFaceCompareSuccess;
//   final String facecompareErrorMsg;
//   const FaceMatchResult({
//     Key? key,
//     required this.isFaceSimilar,
//     required this.localization,
//     required this.isFaceCompareSuccess,
//     required this.facecompareErrorMsg,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Gap(5),
//           Icon(
//               isFaceCompareSuccess
//                   ? isFaceSimilar
//                       ? Icons.check_circle_outline
//                       : Icons.error_outline
//                   : Icons.error_outline,
//               color: isFaceCompareSuccess
//                   ? isFaceSimilar
//                       ? Colors.green
//                       : Colors.red
//                   : Colors.red),
//           const Gap(5),
//           Flexible(
//             child: Text(
//               isFaceCompareSuccess
//                   ? isFaceSimilar
//                       ? localization.faceismached
//                       : localization.facenotmached
//                   : facecompareErrorMsg.isEmpty
//                       ? localization.facecompareerror
//                       : facecompareErrorMsg,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
