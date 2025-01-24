// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ozsdk/ozsdk.dart';

// final livenessStreamProvider = StreamProvider<List<Media>>((ref) {
//   final controller = StreamController<List<Media>>();

//   final subscription = OZSDK.livenessResult.listen(
//     (event) {
//       controller.add(event);
//     },
//     onError: (error) {
//       controller.addError(error);
//     },
//     onDone: () {
//       controller.close();
//     },
//   );

//   ref.onDispose(() {
//     subscription.cancel();
//     controller.close();
//   });

//   return controller.stream;
// });
