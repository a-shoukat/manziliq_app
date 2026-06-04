import 'package:flutter/material.dart';

class PlotUploadScreen extends StatefulWidget {
  const PlotUploadScreen({super.key});

  @override
  State<PlotUploadScreen> createState() => _PlotUploadScreenState();
}

class _PlotUploadScreenState extends State<PlotUploadScreen> {
  final _blockController = TextEditingController();
  final _plotNumberController = TextEditingController();
  final _sizeController = TextEditingController();
  String _status = 'available';

  @override
  void dispose() {
    _blockController.dispose();
    _plotNumberController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Plot')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _blockController,
              decoration: const InputDecoration(
                labelText: 'Block',
                prefixIcon: Icon(Icons.grid_view),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _plotNumberController,
              decoration: const InputDecoration(
                labelText: 'Plot Number',
                prefixIcon: Icon(Icons.tag),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sizeController,
              decoration: const InputDecoration(
                labelText: 'Size (e.g. 5 Marla)',
                prefixIcon: Icon(Icons.square_foot),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'available', child: Text('Available')),
                DropdownMenuItem(value: 'reserved', child: Text('Reserved')),
              ],
              onChanged: (v) => setState(() => _status = v ?? 'available'),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map_outlined),
              label: const Text('Upload SVG Map (placeholder)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Plot saved (stub)')),
                );
              },
              child: const Text('Save Plot'),
            ),
          ],
        ),
      ),
    );
  }
}
