import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../widgets/document_tile_widget.dart';

class DocumentLockerScreen extends StatelessWidget {
  const DocumentLockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final docs = [
      {'name': 'CNIC Copy.pdf', 'category': 'CNIC', 'date': '2026-05-10'},
      {'name': 'Booking Agreement.pdf', 'category': 'Agreement', 'date': '2026-06-01'},
      {'name': 'Token Receipt.pdf', 'category': 'Receipt', 'date': '2026-06-02'},
      {'name': 'NOC Certificate.pdf', 'category': 'NOC', 'date': '2026-04-15'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Locker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: docs.length,
        itemBuilder: (context, i) {
          final d = docs[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: DocumentTileWidget(
              name: d['name']!,
              category: d['category']!,
              date: d['date']!,
              onTap: () => context.push(
                AppRoutes.documentViewer,
                extra: {'name': d['name'], 'category': d['category']},
              ),
            ),
          );
        },
      ),
    );
  }
}
