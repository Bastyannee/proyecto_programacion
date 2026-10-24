import 'package:flutter/material.dart';

/// Selector de cuántos pokemon se muestran por página.
class PageSizeSelector extends StatelessWidget {
  const PageSizeSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.options = const [5, 10, 20],
  });

  final int value;
  final List<int> options;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Text('Pokémon por página:')),
        DropdownButton<int>(
          key: const Key('pageSizeDropdown'),
          value: value,
          items: [
            for (final option in options)
              DropdownMenuItem(value: option, child: Text('$option')),
          ],
          onChanged: (selected) {
            if (selected != null) onChanged(selected);
          },
        ),
      ],
    );
  }
}
