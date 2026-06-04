import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../widgets/property_card_widget.dart';

class SavedPropertiesScreen extends StatelessWidget {
  const SavedPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Properties')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PropertyCardWidget(
              plotNumber: '${i + 3}',
              societyName: 'Green Valley Society',
              block: 'B',
              price: 'PKR ${(2 + i) * 600},000',
              status: AppStrings.available,
              onTap: () => context.push('/customer/plot/saved-$i'),
            ),
          );
        },
      ),
    );
  }
}
