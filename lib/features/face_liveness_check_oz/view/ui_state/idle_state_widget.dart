// import 'dart:io';
// import 'package:fgrs/data/const/theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class IdleStateWidget extends StatelessWidget {
//   final VoidCallback onPressed;
//   final AppLocalizations localization;
//   final VoidCallback pickImage;
//   final File? selectedImagePath;
//   final VoidCallback removeImage; // Function to handle removing the image

//   const IdleStateWidget({
//     Key? key,
//     required this.onPressed,
//     required this.localization,
//     required this.pickImage,
//     required this.selectedImagePath,
//     required this.removeImage, // Initialize the removeImage function
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           const SizedBox(height: 20),
//           const Text(
//             "Add a reference photo",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 30),
//           Expanded(
//             child: Center(
//               child: selectedImagePath != null
//                   ? Stack(
//                       alignment: Alignment
//                           .topRight, // Align the icon to the top-right corner
//                       children: [
//                         // Image displayed from file (wrapped in a Container to maintain size)
//                         SizedBox(
//                           height: 350, // Ensure the image size is fixed
//                           width: double
//                               .infinity, // You can adjust the width if needed
//                           child: Image.file(
//                             selectedImagePath!, // Assuming 'selectedImagePath' is a File
//                             // This will ensure the image covers the available space
//                           ),
//                         ),

//                         // Positioned remove icon on top of the image
//                         Positioned(
//                           top: 10, // Adjust the top position
//                           right: 10, // Adjust the right position
//                           child: IconButton(
//                             icon: const Icon(Icons.remove_circle_outline,
//                                 color: Colors.red, size: 30),
//                             onPressed: () {
//                               removeImage();
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   : Image.asset(
//                       'assets/appicon/Image_upload.png', // Add your illustration asset
//                       height: 350,
//                     ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             localization.imageselection,
//             style: const TextStyle(fontSize: 16, color: Colors.grey),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),

//           // Select Image Button
//           ElevatedButton.icon(
//             onPressed: () {
//               pickImage();
//               // Trigger pickImage callback to handle photo selection
//               // throw Exception('This is test exception');
//             },
//             icon: Icon(
//               Icons.upload_file,
//               color: selectedImagePath != null ? darkPinkAccent : Colors.white,
//             ),
//             label: Text(
//               "Select photo",
//               style: TextStyle(
//                   color: selectedImagePath != null
//                       ? darkPinkAccent
//                       : Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 50),
//               backgroundColor:
//                   selectedImagePath != null ? darkPinkAccent2 : darkPinkAccent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 0.0, // Disable shadow by setting elevation to 0
//             ),
//           ),
//           const SizedBox(height: 23),
//           // Disabled "Do Check" Button
//           ElevatedButton(
//             onPressed: selectedImagePath == null
//                 ? null // Disable if no image is selected
//                 : onPressed, // Enable when an image is selected
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size(double.infinity, 50),
//               backgroundColor:
//                   selectedImagePath == null ? Colors.grey[300] : darkPinkAccent,
//               disabledForegroundColor: Colors.grey,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               localization.liveness, // Text for the button
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
