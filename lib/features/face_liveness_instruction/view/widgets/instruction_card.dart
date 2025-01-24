import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/view/widgets/instruction_text.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InstructionText(
              title: '1. Sufficient Lighting',
              description:
                  'Make sure you are in an area that has sufficient lighting and that your ears are not covered by anything.',
            ),
            InstructionText(
              title: '2. Straight Ahead View',
              description:
                  'Hold the phone at eye level and look straight at the camera.',
            ),
            InstructionText(
              title: '3. Maintain a Neutral Expression',
              description:
                  'Keep your facial expression neutral (no exaggerated smiles or frowns).',
            ),
            InstructionText(
              title: '4. Avoid Obstructions',
              description:
                  'Ensure nothing obstructs your face (e.g., hair, hands, or other objects).',
            ),
          ],
        ),
      ),
    );
  }
}
