import 'package:flutter/widgets.dart';

class DocumentExpireError extends StatelessWidget {
  const DocumentExpireError({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}
