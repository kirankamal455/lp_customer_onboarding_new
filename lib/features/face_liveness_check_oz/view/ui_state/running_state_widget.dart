// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class LoadingStateWidget extends StatelessWidget {
//   final String result;
//   final AppLocalizations localization;

//   const LoadingStateWidget({
//     Key? key,
//     required this.result,
//     required this.localization,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(),
//           const SizedBox(height: 15),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               result.isEmpty
//                   ? localization.initialize
//                   : localization.loadingmessages,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
