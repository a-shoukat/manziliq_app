import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    final name = extra is Map ? extra['name'] as String? ?? 'Document' : 'Document';
    final category = extra is Map ? extra['category'] as String? ?? '' : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf, size: 80, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (category.isNotEmpty) Text(category, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            const Text('PDF viewer placeholder'),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }
}
