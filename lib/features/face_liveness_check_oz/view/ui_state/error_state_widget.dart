// import 'package:fgrs/data/const/theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class ErrorStateWidget extends StatelessWidget {
//   final String result;
//   final VoidCallback onPressed;
//   final AppLocalizations localization;

//   const ErrorStateWidget({
//     Key? key,
//     required this.result,
//     required this.onPressed,
//     required this.localization,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print("result is :$result");
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedOpacity(
//             opacity: 1.0,
//             duration: const Duration(seconds: 1),
//             child: Icon(
//               result == "USER_CANCELLED"
//                   ? Icons.warning_amber_outlined
//                   : Icons.error_outline,
//               color: result == "USER_CANCELLED" ? Colors.orange : Colors.red,
//               size: 65.0,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Text(
//               result == "USER_CANCELLED" ? localization.canceled : result,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//             ),
//           ),
//           const SizedBox(height: 32),
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
//             child: const Text(
//               "Check Again",
//               style: TextStyle(
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
