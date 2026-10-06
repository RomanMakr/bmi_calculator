import 'package:flutter/material.dart';

import '../../../../core/theme/app_clolors.dart';
import '../../domain/entities/bmi_result.dart';

class BmiResultCard extends StatelessWidget {
  final BmiResult result;
  const BmiResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              'Your BMI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              result.value.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 16),
              Text(
                result.category,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                 result.description,
                 textAlign: TextAlign.center,
                 style: TextStyle(
                  fontSize: 16,
                 ), 
              ),
          ],
        ),
      ),
    );
  }
}
