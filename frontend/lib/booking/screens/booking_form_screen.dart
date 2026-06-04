import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _phoneController = TextEditingController();
  String _paymentPlan = 'installment';

  @override
  void dispose() {
    _nameController.dispose();
    _cnicController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Plot')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.home_work),
                title: Text('Plot A-15'),
                subtitle: Text('Green Valley • PKR 3,500,000'),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _cnicController,
              decoration: const InputDecoration(
                labelText: 'CNIC',
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text('Payment Plan', style: TextStyle(fontWeight: FontWeight.w600)),
            RadioListTile(
              title: const Text('Full Payment'),
              value: 'full',
              groupValue: _paymentPlan,
              onChanged: (v) => setState(() => _paymentPlan = v!),
            ),
            RadioListTile(
              title: const Text('Installment Plan'),
              value: 'installment',
              groupValue: _paymentPlan,
              onChanged: (v) => setState(() => _paymentPlan = v!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.push(AppRoutes.bookingConfirmation);
                }
              },
              child: const Text('Submit Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
