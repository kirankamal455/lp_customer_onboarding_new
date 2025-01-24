import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/app/view/app.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
 
Future <void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}



// void main() async {
//   await SentryFlutter.init(
//     (options) {
//       options.dsn =
//           'https://92c8a2d43037b7de3103ec8f5829a425@o4506263171629056.ingest.us.sentry.io/4508121278644224';
//       options.tracesSampleRate = 1.0;
//       options.profilesSampleRate = 1.0;
//     },
//     appRunner: () => bootstrap(() => DevicePreview(
//         enabled: false,
//           tools: const [
//             ...DevicePreview.defaultTools,
//           ],
//           builder: (context) => const App(),
//         )),
//   );
// }
