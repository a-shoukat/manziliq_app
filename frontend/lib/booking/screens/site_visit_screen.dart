import 'package:flutter/material.dart';

class SiteVisitScreen extends StatefulWidget {
  const SiteVisitScreen({super.key});

  @override
  State<SiteVisitScreen> createState() => _SiteVisitScreenState();
}

class _SiteVisitScreenState extends State<SiteVisitScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 3));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(context: context, initialTime: _selectedTime);
    if (time != null) setState(() => _selectedTime = time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Site Visit')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Card(
            child: ListTile(
              leading: Icon(Icons.home_work),
              title: Text('Plot A-15'),
              subtitle: Text('Green Valley Society'),
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Date'),
            subtitle: Text(
              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            ),
            trailing: const Icon(Icons.edit),
            onTap: _pickDate,
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Time'),
            subtitle: Text(_selectedTime.format(context)),
            trailing: const Icon(Icons.edit),
            onTap: _pickTime,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Notes for dealer/society',
              alignLabelWithHint: true,
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Site visit scheduled (stub)')),
              );
            },
            child: const Text('Confirm Visit'),
          ),
        ],
      ),
    );
  }
}
