import 'package:flutter/material.dart';

class ThemeSettingsButton extends StatelessWidget {
  final void Function(String) onSelected;
  const ThemeSettingsButton({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.settings,
        color: Theme.of(context).colorScheme.surface,
      ),
      onSelected: (String value) {
        onSelected(value);
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'theme',
          child: Row(
            children: [
              Icon(Icons.format_paint, color: Theme.of(context).primaryColor),
              const Text('  Apperance')
            ],
          ),
        ),
      ],
    );
  }
}
