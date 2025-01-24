import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class DocumentExpiredNotData extends StatelessWidget {
  const DocumentExpiredNotData({super.key});

  @override
  Widget build(BuildContext context) {
    return "Document Expire Date Not Found".text.bold.make().centered();
  }
}
