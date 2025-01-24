import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0.3,
          color: subtitle.isEmpty
              ? const Color.fromARGB(255, 239, 209, 207)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ).h(context.screenHeight * 0.1).p(2),
      ],
    );
  }
}
