import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../models/user_model.dart';

class RoleSelectorWidget extends StatelessWidget {
  final UserRole selected;
  final ValueChanged<UserRole> onChanged;

  const RoleSelectorWidget({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Register as', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: UserRole.values
              .where((r) => r != UserRole.admin)
              .map((role) => ChoiceChip(
                    label: Text(_label(role)),
                    selected: selected == role,
                    onSelected: (_) => onChanged(role),
                  ))
              .toList(),
        ),
      ],
    );
  }

  String _label(UserRole role) => switch (role) {
        UserRole.customer => AppStrings.roleCustomer,
        UserRole.dealer => AppStrings.roleDealer,
        UserRole.society => AppStrings.roleSociety,
        UserRole.admin => AppStrings.roleAdmin,
      };
}
