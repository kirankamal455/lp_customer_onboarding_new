import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FaceLivenessSuccessStateWidget extends ConsumerWidget {
  const FaceLivenessSuccessStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Liveness verification successful!',
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
        SizedBox(height: 20),
        //Text('Image Path: ${data.imagePath}'),
      ],
    );
  }
}
