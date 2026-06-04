import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class PipelineStepperWidget extends StatelessWidget {
  final List<String> stages;
  final int currentIndex;

  const PipelineStepperWidget({
    super.key,
    required this.stages,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stages.length * 2 - 1, (i) {
        if (i.isOdd) {
          final stepIndex = i ~/ 2;
          final done = stepIndex < currentIndex;
          return Expanded(
            child: Container(
              height: 2,
              color: done ? AppColors.success : Colors.grey.shade300,
            ),
          );
        }
        final index = i ~/ 2;
        final active = index <= currentIndex;
        return Column(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: active ? AppColors.primary : Colors.grey.shade300,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: active ? Colors.white : Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 72,
              child: Text(
                stages[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: index == currentIndex ? FontWeight.bold : null,
                ),
                maxLines: 2,
              ),
            ),
          ],
        );
      }),
    );
  }
}
